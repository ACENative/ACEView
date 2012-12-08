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

extern NSString *const ACETextDidEndEditingNotification;

#pragma mark - ACEViewDelegate
@protocol ACEViewDelegate <NSObject>

- (void) textDidChange:(NSNotification *)notification;

@end

#pragma mark - ACEView
@interface ACEView : WebView <NSTextFinderClient> {
    NSTextFinder *textFinder;
    CGColorRef _borderColor;
    
    id delegate;
    
    NSRange firstSelectedRange;
    
}

@property (assign) id delegate;
@property(readonly) NSRange firstSelectedRange;
@property(readonly) NSString *string;

#pragma mark - ACEView interaction
- (NSString *) string;
- (void) setString:(NSString *)string;

- (void) setMode:(ACEMode)mode;
- (void) setTheme:(ACETheme)theme;

@end
