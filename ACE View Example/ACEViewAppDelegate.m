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
#import "ACEView/ACEKeyboardHandlerNames.h"

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
    [aceView setKeyboardHandler:ACEKeyboardHandlerAce];
    [aceView setShowPrintMargin:NO];
    [aceView setShowInvisibles:YES];
    [aceView setBasicAutoCompletion:YES];
    [aceView setLiveAutocompletion:YES];
    [aceView setSnippets:YES];
    [aceView setEmmet: YES];
}

- (void) awakeFromNib {
    [syntaxMode addItemsWithTitles:[ACEModeNames humanModeNames]];
    [syntaxMode selectItemAtIndex:ACEModeHTML];
    
    [theme addItemsWithTitles:[ACEThemeNames humanThemeNames]];
    [theme selectItemAtIndex:ACEThemeXcode];

    [keyboardHandler addItemsWithTitles:[ACEKeyboardHandlerNames humanKeyboardHandlerNames]];
    [keyboardHandler selectItemAtIndex:ACEKeyboardHandlerAce];
}

- (IBAction) syntaxModeChanged:(id)sender {
    [aceView setMode:[syntaxMode indexOfSelectedItem]];
}

- (IBAction) themeChanged:(id)sender {
    [aceView setTheme:[theme indexOfSelectedItem]];
}

- (IBAction) keyboardHandlerChanged:(id)sender {
    [aceView setKeyboardHandler:[keyboardHandler indexOfSelectedItem]];
}

#pragma mark - Delegate methods

- (void) textDidChange:(NSNotification *)notification {
    // Handle text changes
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)startPrintOperation:(NSPrintOperation *)printOp
{
    printOp.jobTitle = @"ACE View Print";
}

- (float) printHeaderHeight
{
    return 20.0f;
}

- (float) printFooterHeight
{
    return 12.0f;
}

//
// I'm not saying that this flashy look goes best with the content
// of the page, this is just to demonstrate the possibilities.
//
- (void) drawPrintHeaderForPage:(int)pageNo inRect:(NSRect)rect
{
    NSGradient * gradient =
        [[NSGradient alloc] initWithStartingColor:[NSColor colorWithWhite:0.3 alpha:1.0]
                                      endingColor:[NSColor colorWithWhite:0.95 alpha:1.0]];
    [gradient drawInRect:rect angle:0.0];
    NSString *      pageString  = [NSString stringWithFormat:@"%d", pageNo];
    NSFont *        pageFont    = [NSFont userFixedPitchFontOfSize: 15.0];
    NSDictionary *  attr        = @{NSFontAttributeName: pageFont};

    NSSize size     = [pageString sizeWithAttributes:attr];
    size.width     += 10.0;
    rect.origin.x  += rect.size.width-size.width;
    rect.size.width = size.width;
    rect.origin.y  += 0.5*(rect.size.height-pageFont.ascender);
    [pageString drawInRect:rect withAttributes:attr];
}

- (void) drawPrintFooterForPage:(int)pageNo inRect:(NSRect)rect
{
    NSString *      colophon    = @"Printed by ACE View Example";
    NSFont *        coloFont    = [NSFont userFontOfSize:9.0];
    NSDictionary *  attr        = @{NSFontAttributeName: coloFont};

    NSSize  size    = [colophon sizeWithAttributes:attr];
    NSPoint at      = {
        rect.origin.x+0.5*(rect.size.width-size.width),
        rect.origin.y-coloFont.descender};
    [colophon drawAtPoint:at withAttributes:attr];
}

@end
