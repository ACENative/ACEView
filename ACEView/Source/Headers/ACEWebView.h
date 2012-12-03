//
//  ACEWebView.h
//  ACEView
//
//  Created by Michael Robinson on 3/12/12.
//  Copyright (c) 2012 Code of Interest. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface ACEWebView : WebView <NSTextFinderClient> {
    NSTextFinder *textFinder;
}

@property(readonly) NSString *string;
@property(readonly) NSRange firstSelectedRange;
@property(copy) NSArray *selectedRanges;

- (void) executeScriptsWhenLoaded:(NSArray *)scripts;
- (void) executeScriptWhenLoaded:(NSString *)script;

- (void) showFindInterface;

@end
