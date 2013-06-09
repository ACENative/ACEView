//
//  AppDelegate.m
//  ACE View Example
//
//  Created by Michael Robinson on 26/08/12.
//  Copyright (c) 2012 Code of Interest. All rights reserved.
//

#import "ACEViewAppDelegate.h"
#import "ACEView/ACEView.h"
#import "ACEView/ACEModeNames.h"
#import "ACEView/ACEThemeNames.h"

@implementation ACEViewAppDelegate

@synthesize aceView;

- (void) applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSString *htmlFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"HTML5" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:htmlFilePath encoding:NSUTF8StringEncoding error:nil];
    [aceView setString:html];
//    [aceView setString:[NSString stringWithContentsOfURL:[NSURL URLWithString:@"https://github.com/faceleg/ACEView"] encoding:NSUTF8StringEncoding
//                                                   error:nil]];
    [aceView setDelegate:self];
    [aceView setMode:ACEModeHTML];
    [aceView setTheme:ACEThemeXcode];
    [aceView setShowPrintMargin:NO];
    [aceView setShowInvisibles:YES];
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

- (void) textDidChange:(NSNotification *)notification {
    // Handle text changes
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end
