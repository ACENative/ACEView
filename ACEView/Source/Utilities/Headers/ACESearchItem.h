//
//  ACEObject.h
//  ACEView
//
//  Created by Jan Gassen on 10/01/15.
//  Copyright (c) 2015 Code of Interest. All rights reserved.
//

#ifndef ACEView_ACEObject_h
#define ACEView_ACEObject_h

@interface ACESearchItem : NSObject {
    NSInteger startColumn;
    NSInteger startRow;
    NSInteger endColumn;
    NSInteger endRow;
}

@property NSInteger startColumn;
@property NSInteger startRow;
@property NSInteger endColumn;
@property NSInteger endRow;

+ (NSArray*) fromString:(NSString*)text;

@end


#endif
