//
//  ACEWebView.m
//  ACEView
//
//  Created by Michael Robinson on 3/12/12.
//  Copyright (c) 2012 Code of Interest. All rights reserved.
//

#import <ACEView/ACEWebView.h>
#import <ACEView/NSView+ScrollView.h>

@implementation ACEWebView

@synthesize selectedRanges, string;

- (id) initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self == nil) {
        return nil;
    }
    
    [self setFrameLoadDelegate:self];
    
    return self;
}
- (void) webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
    textFinder = [[NSTextFinder alloc] init];
    [textFinder setClient:self];
    [textFinder setFindBarContainer:[self scrollView]];
    [textFinder setIncrementalSearchingEnabled:YES];
    
    [[self windowScriptObject] setValue:self forKey:@"ACEWebView"];
}
+ (BOOL) isSelectorExcludedFromWebScript:(SEL)aSelector {
    if (aSelector == @selector(showFindInterface)) {
        return NO;
    }
    return YES;
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
- (void) performTextFinderAction:(id)sender {
    [textFinder performAction:[sender tag]];
}

#pragma mark - NSTextFinderClient methods
- (NSUInteger) stringLength {
    ACELog(@"");
    return [@"string" length];
}
- (NSString *) string {
    ACELog(@"");
    return @"string";
}
- (void) scrollRangeToVisible:(NSRange)range {
    ACELog(@"");
}

- (NSRange) firstSelectedRange {
    ACELog(@"");
    return NSMakeRange(0, 0);
}
- (BOOL) isEditable {
    ACELog(@"");
    return YES;
}
- (NSView *) contentViewAtIndex:(NSUInteger)index effectiveCharacterRange:(NSRangePointer)outRange {
    ACELog(@"");
    return self;
}
- (void) drawCharactersInRange:(NSRange)range forContentView:(NSView *)view {
    ACELog(@"");
}

@end
