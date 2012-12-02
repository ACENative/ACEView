//
//  AppDelegate.h
//  ACE View Example
//
//  Created by Michael Robinson on 26/08/12.
//  Copyright (c) 2012 Code of Interest. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <ACEView/ACEView.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet ACEView *aceView;
}

@property (assign) IBOutlet NSWindow *window;

@end
