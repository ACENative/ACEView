//
//  ACEView.h
//  ACEView
//
//  Created by Michael Robinson on 26/08/12.
//  Copyright (c) 2012 Code of Interest. All rights reserved.
//

#import "Foundation/Foundation.h"
#import "ACEModes.h"

@interface ACEView : NSView {
    
}

- (NSString *) content;
- (void) setContent:(NSString *)content;

- (void) setMode:(ACEViewMode)mode;

@end
