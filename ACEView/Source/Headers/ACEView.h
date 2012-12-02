//
//  ACEView.h
//  ACEView
//
//  Created by Michael Robinson on 26/08/12.
//  Copyright (c) 2012 Code of Interest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ACEView/ACEModes.h>
#import <ACEView/ACEThemes.h>

@interface ACEView : NSView {
    
}

- (NSString *) content;
- (void) setContent:(NSString *)content;

- (void) setMode:(ACEMode)mode;
- (void) setTheme:(ACETheme)theme;

@end
