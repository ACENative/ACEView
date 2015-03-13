//
//  ACEWebView.m
//  ACEView
//
//  Created by Conor Taylor on 13/03/2015.
//  Copyright (c) 2015 Code of Interest. All rights reserved.
//

#import "ACEWebView.h"

@implementation ACEWebView

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
	// disable all dragging into the WebView
	return false;
}

@end
