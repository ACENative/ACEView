//
//  AppDelegate.m
//  ACE View Example
//
//  Created by Michael Robinson on 26/08/12.
//  Copyright (c) 2012 Code of Interest. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void) applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSString *htmlFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"HTML5" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:htmlFilePath encoding:NSUTF8StringEncoding error:nil];

    [aceView setContent:html];
    [aceView setMode:ACEViewModeHTML];
}

@end
