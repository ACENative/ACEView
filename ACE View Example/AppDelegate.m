//
//  AppDelegate.m
//  ACE View Example
//
//  Created by Michael Robinson on 26/08/12.
//  Copyright (c) 2012 Code of Interest. All rights reserved.
//

#import "AppDelegate.h"
#import <ACEView/ACEModeNames.h>
#import <ACEView/ACEThemeNames.h>

@implementation AppDelegate

- (void) applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Set ACEView's content
    NSString *htmlFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"HTML5" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:htmlFilePath encoding:NSUTF8StringEncoding error:nil];

    [aceView setString:html];
    [aceView setMode:ACEModeHTML];
    [aceView setTheme:ACEThemeXcode];
}

- (void) awakeFromNib {
    [syntaxMode addItemsWithTitles:[ACEModeNames humanModeNames]];
    [syntaxMode selectItemAtIndex:ACEModeHTML];
    
    [theme addItemsWithTitles:[ACEThemeNames humanThemeNames]];
    [theme selectItemAtIndex:ACEThemeXcode];
}

- (IBAction) syntaxModeChanged:(id)sender {
    [aceView setMode:[syntaxMode indexOfSelectedItem]];
}

- (IBAction) themeChanged:(id)sender {
    [aceView setTheme:[theme indexOfSelectedItem]];
}

@end
