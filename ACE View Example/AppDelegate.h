//
//  AppDelegate.h
//  ACE View Example
//
//  Created by Michael Robinson on 26/08/12.
//  Copyright (c) 2012 Code of Interest. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <ACEView/ACEView.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, ACEViewDelegate> {
    IBOutlet ACEView *aceView;
    
    IBOutlet NSPopUpButton *syntaxMode;
    IBOutlet NSPopUpButton *theme;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction) syntaxModeChanged:(id)sender;
- (IBAction) themeChanged:(id)sender;

@end
