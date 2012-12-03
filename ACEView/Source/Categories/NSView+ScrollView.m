//
//  NSView+ScrollView.m
//  ACEView
//
//  Created by Michael Robinson on 4/12/12.
//  Copyright (c) 2012 Code of Interest. All rights reserved.
//

#import "NSView+ScrollView.h"

@implementation NSView (ScrollView)

- (NSScrollView *) scrollView {
    if ([self isKindOfClass:[NSScrollView class]]) {
        return (NSScrollView *)self;
    }
    
    if ([self.subviews count] == 0) {
        return nil;
    }
    
    for (NSView *subview in self.subviews) {
        NSView *scrollView = [subview scrollView];
        if (scrollView != nil) {
            return (NSScrollView *)scrollView;
        }
    }
    return nil;
}

@end
