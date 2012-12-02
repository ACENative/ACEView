//
//  ACEView.m
//  ACEView
//
//  Created by Michael Robinson on 26/08/12.
//  Copyright (c) 2012 Code of Interest. All rights reserved.
//

#import <WebKit/WebKit.h>

#import <ACEView/ACEView.h>
#import <ACEView/ACEModeNames.h>
#import <ACEView/ACEThemeNames.h>

#define ACE_JAVASCRIPT_DIRECTORY @"___ACE_VIEW_JAVASCRIPT_DIRECTORY___"

@interface ACEView() {
    WebView *_webView;
    CGColorRef _borderColor;
}

- (CGColorRef) borderColor;
- (WebView *) webView;
- (void) initialiseWebView;
- (void) embedWebView;
- (void) executeScriptsWhenLoaded:(NSArray *)scripts;
- (void) executeScriptWhenLoaded:(NSString *)script;

@end

@implementation ACEView

#pragma mark - Internal
- (void) awakeFromNib {
    [self initialiseWebView];
    [self embedWebView];
}
- (void) drawRect:(NSRect)rect {
    [self setWantsLayer:YES];
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1.0f;
    
    [self.layer setBorderColor:[self borderColor]];

    [super drawRect:rect];
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
- (WebView *)webView {
    if (_webView == nil) {
        _webView = [[WebView alloc] initWithFrame:self.frame];
    }
    return _webView;
}
- (void) initialiseWebView {
    WebView *webView = [self webView];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    NSString *htmlPath = [bundle pathForResource:@"index" ofType:@"html" inDirectory:@"ace"];
    NSString *html = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    
    NSString *javascriptDirectory = [[bundle pathForResource:@"ace" ofType:@"js" inDirectory:@"ace/javascript"] stringByDeletingLastPathComponent];
    
    html = [html stringByReplacingOccurrencesOfString:ACE_JAVASCRIPT_DIRECTORY withString:javascriptDirectory];
    
    [[webView mainFrame] loadHTMLString:html baseURL:[bundle bundleURL]];
}
- (void) embedWebView {
    WebView *webView = [self webView];
    
    [self setAutoresizesSubviews:YES];
    [self addSubview:webView];
    
    [webView setAutoresizesSubviews:YES];
    [webView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    
    // Reduce bounds by 1 to allow for border
    NSRect bounds = NSMakeRect(self.bounds.origin.x - 1, self.bounds.origin.y - 1, self.bounds.size.width - 1, self.bounds.size.height - 1);
    [webView setFrame:bounds];
}
- (void) executeScriptsWhenLoaded:(NSArray *)scripts {
    if ([[self webView] isLoading]) {
        [self performSelector:@selector(executeScriptsWhenLoaded:) withObject:scripts afterDelay:0.2];
        return;
    }
    [scripts enumerateObjectsUsingBlock:^(id script, NSUInteger index, BOOL *stop) {
        [[self webView] stringByEvaluatingJavaScriptFromString:script];
    }];
}
- (void) executeScriptWhenLoaded:(NSString *)script {
    if ([[self webView] isLoading]) {
        [self performSelector:@selector(executeScriptWhenLoaded:) withObject:script afterDelay:0.2];
        return;
    }
    [[self webView] stringByEvaluatingJavaScriptFromString:script];
}

#pragma mark - Public
- (NSString *) content {
    return [[self webView] stringByEvaluatingJavaScriptFromString:@"editor.getValue()"];
}
- (void) setContent:(NSString *)content {
    NSString *jsonString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:@[content]
                                                                                          options:0
                                                                                            error:nil] encoding:NSUTF8StringEncoding];
    
    content = [jsonString substringWithRange:NSMakeRange(2, jsonString.length - 4)];
    
    [self executeScriptsWhenLoaded:@[[NSString stringWithFormat:@"editor.setValue(\"%@\");", content], @"editor.clearSelection();"]];
}

- (void) setMode:(ACEMode)mode {
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.getSession().setMode(\"ace/mode/%@\");", [ACEModeNames nameForMode:mode]]];
}
- (void) setTheme:(ACETheme)theme {
    [self executeScriptWhenLoaded:[NSString stringWithFormat:@"editor.setTheme(\"ace/theme/%@\");", [ACEThemeNames nameForTheme:theme]]];
}

@end
