//
//  ACEWebView.h
//  ACEView
//
//  Created by Conor Taylor on 13/03/2015.
//  Copyright (c) 2015 Code of Interest. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface ACEWebView : WebView

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender;

@end
