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

#import <ACEView/NSView+ScrollView.h>
#import <ACEView/NSString+EscapeForJavaScript.h>
#import <ACEView/NSInvocation+MainThread.h>

#define ACE_JAVASCRIPT_DIRECTORY @"___ACE_VIEW_JAVASCRIPT_DIRECTORY___"

#pragma mark - ACEViewDelegate
NSString *const ACETextDidEndEditingNotification = @"ACETextDidEndEditingNotification";

#pragma mark - ACEView private

@interface ACEView()

- (CGColorRef) borderColor;

- (void) executeScriptsWhenLoaded:(NSArray *)scripts;
- (void) executeScriptWhenLoaded:(NSString *)script;

- (void) showFindInterface;
- (void) showReplaceInterface;

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
    if (aSelector == @selector(showFindInterface)) {
        return NO;
    }
    if (aSelector == @selector(showReplaceInterface)) {
        return NO;
    }
    return YES;
}

#pragma mark - WebView delegate methods
- (void) webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
    textFinder = [[NSTextFinder alloc] init];
    [textFinder setClient:self];
    [textFinder setFindBarContainer:[self scrollView]];
    
    [[self windowScriptObject] setValue:self forKey:@"ACEWebView"];
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
- (void) setString:(NSString *)string {
    [self executeScriptsWhenLoaded:@[
        [NSString stringWithFormat:@"editor.setValue(\"%@\");", [string stringByEscapingForJavaScript]],
        @"editor.clearSelection();",
        @"editor.moveCursorTo(0, 0);"
    ]];
}

- (void) setMode:(ACEMode)mode {
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.getSession().setMode(\"ace/mode/%@\");", [ACEModeNames nameForMode:mode]]];
}
- (void) setTheme:(ACETheme)theme {
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.setTheme(\"ace/theme/%@\");", [ACEThemeNames nameForTheme:theme]]];
}

@end
