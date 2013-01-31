//
//  ACEModeNames.h
//  ACEView
//
//  Created by Michael Robinson on 2/12/12.
//  Copyright (c) 2012 Code of Interest. All rights reserved.
//
#import <ACEView/ACEModes.h>

/** Class providing methods to:

 - convert ACE mode names used internally to to their human-readable counterparts and vise-versa.
 - Convert ACEmode constants into their ACE theme or human-readable ACE mode names.

 */

@interface ACEModeNames : NSObject { }

/**---------------------------------------------------------------------------------------
 * @name Class Methods
 *  ---------------------------------------------------------------------------------------
 */

/** Return an array of ACE mode names.

 @return Array of ACE mode names.
 */
+ (NSArray *) modeNames;
/** Return an array of human-readable ACE mode names.

 @return Array of human-readable ACE mode names.
 */
+ (NSArray *) humanModeNames;

/** Return the ACE mode name for a given ACEmode constant.

 @param mode The ACEMode constant to be converted.
 @return The ACE mode name corresponding to the given ACEMode constant.
 */
+ (NSString *) nameForMode:(ACEMode)mode;
/** Return the human-readable ACE mode name for a given ACEMode constant.

 @param mode The ACEMode constant to be converted.
 @return The human-readable ACE mode name corresponding to the given ACEMode constant.
 */
+ (NSString *) humanNameForMode:(ACEMode)mode;

@end
