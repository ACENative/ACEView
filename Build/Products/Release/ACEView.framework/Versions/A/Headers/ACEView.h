//
//  ACEView.h
//  ACEView
//
//  Created by Michael Robinson on 26/08/12.
//  Copyright (c) 2012 Code of Interest. All rights reserved.
//

#import <WebKit/WebKit.h>

#import <ACEView/ACEModes.h>
#import <ACEView/ACEThemes.h>

@class ACEWebView;

@interface ACEView : WebView <NSTextFinderClient> {
    NSTextFinder *textFinder;
    CGColorRef _borderColor;
    
    NSRange firstSelectedRange;
}

@property(readonly) NSRange firstSelectedRange;
@property(readonly) NSString *string;

#pragma mark - ACE interaction
- (NSString *) string;
- (void) setString:(NSString *)string;

- (void) setMode:(ACEMode)mode;
- (void) setTheme:(ACETheme)theme;

@end
