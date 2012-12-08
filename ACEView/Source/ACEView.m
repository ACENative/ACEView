//
//  ACEView.m
//  ACEView
//
//  Created by Michael Robinson on 26/08/12.
//  Copyright (c) 2012 Code of Interest. All rights reserved.
//

#import <ACEView/ACEView.h>
#import <ACEView/ACEModeNames.h>
#import <ACEView/ACEThemeNames.h>
#import <ACEView/ACERange.h>
#import <ACEView/ACEStringFromBool.h>

#import <ACEView/NSView+ScrollView.h>
#import <ACEView/NSString+EscapeForJavaScript.h>
#import <ACEView/NSInvocation+MainThread.h>

#define ACE_JAVASCRIPT_DIRECTORY @"___ACE_VIEW_JAVASCRIPT_DIRECTORY___"

#pragma mark - ACEViewDelegate
NSString *const ACETextDidEndEditingNotification = @"ACETextDidEndEditingNotification";

#pragma mark - ACEView private
static NSArray *allowedSelectorNamesForJavaScript;

@interface ACEView()

- (CGColorRef) borderColor;

- (NSString *) stringByEvaluatingJavaScriptOnMainThreadFromString:(NSString *)script;
- (void) executeScriptsWhenLoaded:(NSArray *)scripts;
- (void) executeScriptWhenLoaded:(NSString *)script;

- (void) showFindInterface;
- (void) showReplaceInterface;

+ (NSArray *) allowedSelectorNamesForJavaScript;

- (void) aceTextDidChange;

@end

#pragma mark - ACEView implementation
@implementation ACEView

@synthesize firstSelectedRange, delegate;

#pragma mark - Internal
- (id) initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self == nil) {
        return nil;
    }
    
    [self setFrameLoadDelegate:self];

    return self;
}

- (void) awakeFromNib {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    NSString *htmlPath = [bundle pathForResource:@"index" ofType:@"html" inDirectory:@"ace"];
    NSString *html = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    
    NSString *javascriptDirectory = [[bundle pathForResource:@"ace" ofType:@"js" inDirectory:@"ace/javascript"] stringByDeletingLastPathComponent];
    
    html = [html stringByReplacingOccurrencesOfString:ACE_JAVASCRIPT_DIRECTORY withString:javascriptDirectory];
    
    [[self mainFrame] loadHTMLString:html baseURL:[bundle bundleURL]];
    [self drawRect:[self frame]];
}
- (void) drawRect:(NSRect)rect {
    [self setWantsLayer:YES];
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1.0f;
    
    [self.layer setBorderColor:[self borderColor]];

    [super drawRect:rect];
}
+ (BOOL) isSelectorExcludedFromWebScript:(SEL)aSelector {
    return ![[ACEView allowedSelectorNamesForJavaScript] containsObject:NSStringFromSelector(aSelector)];
}

#pragma mark - WebView delegate methods
- (void) webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
    textFinder = [[NSTextFinder alloc] init];
    [textFinder setClient:self];
    [textFinder setFindBarContainer:[self scrollView]];
    
    [[self windowScriptObject] setValue:self forKey:@"ACEView"];
}

#pragma mark - NSTextFinderClient methods
- (void) performTextFinderAction:(id)sender {
    [textFinder performAction:[sender tag]];
}
- (void) scrollRangeToVisible:(NSRange)range {
    firstSelectedRange = range;
    [self executeScriptWhenLoaded:[NSString stringWithFormat:
                                   @"editor.session.selection.clearSelection();"
                                   @"editor.session.selection.setRange(new Range(%@));"
                                   "editor.centerSelection()",
                                   ACEStringFromRangeAndString(range, [self string])]];
}
- (void) replaceCharactersInRange:(NSRange)range withString:(NSString *)string {
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.session.replace(new Range(%@), \"%@\");",
                                    ACEStringFromRangeAndString(range, [self string]), [string stringByEscapingForJavaScript]]];
}
- (BOOL) isEditable {
    return YES;
}

#pragma mark - Private
- (CGColorRef) borderColor {
    if (_borderColor == nil) {
        NSColor *windowFrameColor = [[NSColor windowFrameColor] colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
        _borderColor = CGColorCreateGenericRGB([windowFrameColor redComponent],
                                               [windowFrameColor greenComponent],
                                               [windowFrameColor blueComponent],
                                               [windowFrameColor alphaComponent]);
    }
    return _borderColor;
}

- (NSString *) stringByEvaluatingJavaScriptOnMainThreadFromString:(NSString *)script {
    SEL stringByEvaluatingJavascriptFromString = @selector(stringByEvaluatingJavaScriptFromString:);
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
                                [[self class] instanceMethodSignatureForSelector:stringByEvaluatingJavascriptFromString]];
    [invocation setSelector:stringByEvaluatingJavascriptFromString];

    [invocation setArgument:&script atIndex:2];
    [invocation setTarget:self];
    [invocation invokeOnMainThread];
    
    NSString *contentString;
    [invocation getReturnValue:&contentString];
    return contentString;
}
- (void) executeScriptsWhenLoaded:(NSArray *)scripts {
    if ([self isLoading]) {
        [self performSelector:@selector(executeScriptsWhenLoaded:) withObject:scripts afterDelay:0.2];
        return;
    }
    [scripts enumerateObjectsUsingBlock:^(id script, NSUInteger index, BOOL *stop) {
        [self stringByEvaluatingJavaScriptFromString:script];
    }];
}
- (void) executeScriptWhenLoaded:(NSString *)script {
    if ([self isLoading]) {
        [self performSelector:@selector(executeScriptWhenLoaded:) withObject:script afterDelay:0.2];
        return;
    }
    [self stringByEvaluatingJavaScriptFromString:script];
}

- (void) showFindInterface {
    [textFinder performAction:NSTextFinderActionShowFindInterface];
}
- (void) showReplaceInterface {
    [textFinder performAction:NSTextFinderActionShowReplaceInterface];
}

+ (NSArray *) allowedSelectorNamesForJavaScript {
    if (allowedSelectorNamesForJavaScript == nil) {
        allowedSelectorNamesForJavaScript = @[
            @"showFindInterface",
            @"showReplaceInterface",
            @"aceTextDidChange"
        ];
    }
    return [allowedSelectorNamesForJavaScript retain];
}

- (void) aceTextDidChange {
    NSNotification *textDidChangeNotification = [NSNotification notificationWithName:ACETextDidEndEditingNotification
                                                                              object:self];
    [[NSNotificationCenter defaultCenter] postNotification:textDidChangeNotification];
    if (self.delegate == nil) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(textDidChange:)]) {
        [self.delegate performSelector:@selector(textDidChange:) withObject:textDidChangeNotification];
    }
}

#pragma mark - Public
- (NSString *) string {
    return [self stringByEvaluatingJavaScriptOnMainThreadFromString:@"editor.getValue();"];
}
- (void) setString:(id)string {
    [self executeScriptsWhenLoaded:@[
        @"reportChanges = false;",
        [NSString stringWithFormat:@"editor.setValue(\"%@\");", [string stringByEscapingForJavaScript]],
        @"editor.clearSelection();",
        @"editor.moveCursorTo(0, 0);",
        @"reportChanges = true;",
        @"ACEView.aceTextDidChange();"
    ]];
}

- (void) setMode:(ACEMode)mode {
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.getSession().setMode(\"ace/mode/%@\");", [ACEModeNames nameForMode:mode]]];
}
- (void) setTheme:(ACETheme)theme {
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.setTheme(\"ace/theme/%@\");", [ACEThemeNames nameForTheme:theme]]];
}

- (void) setWrappingBehavioursEnabled:(BOOL)wrap {
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.setWrapBehavioursEnabled(%@);", ACEStringFromBool(wrap)]];
}
- (void) setUseSoftWrap:(BOOL)wrap {
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.getSession().setUseWrapMode(%@);", ACEStringFromBool(wrap)]];
}
- (void) setWrapLimitRange:(NSRange)range {
    [self setUseSoftWrap:YES];
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.getSession().setWrapLimitRange(%ld, %ld);", range.location, range.length]];
}
- (void) setShowInvisibles:(BOOL)show {
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.setShowInvisibles(%@);", ACEStringFromBool(show)]];
}
- (void) setShowFoldWidgets:(BOOL)show {
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.setShowFoldWidgets(%@);", ACEStringFromBool(show)]];
}
- (void) setHighlightActiveLine:(BOOL)highlight {
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.setHighlightActiveLine(%@);", ACEStringFromBool(highlight)]];
}
- (void) setHighlightGutterLine:(BOOL)highlight {
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.setHighlightGutterLine(%@);", ACEStringFromBool(highlight)]];
}
- (void) setHighlightSelectedWord:(BOOL)highlight {
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.setHighlightSelectedWord(%@);", ACEStringFromBool(highlight)]];
}
- (void) setDisplayIndentGuides:(BOOL)display {
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.setDisplayIndentGuides(%@);", ACEStringFromBool(display)]];
}
- (void) setFadeFoldWidgets:(BOOL)fade {
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.setFadeFoldWidgets(%@);", ACEStringFromBool(fade)]];
}
- (void) setAnimatedScroll:(BOOL)animate {
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.setAnimatedScroll(%@);", ACEStringFromBool(animate)]];
}
- (void) setPrintMarginColumn:(NSUInteger)column {
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.setPrintMarginColumn(%ld);", column]];
}
- (void) setScrollSpeed:(NSUInteger)speed {
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.setScrollSpeed(%ld);", speed]];
}
- (void) setFontSize:(NSUInteger)size {
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.setFontSize(%ld);", size]];
}

@end
