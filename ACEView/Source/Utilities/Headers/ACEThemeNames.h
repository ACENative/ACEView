//
//  ACEThemeNames.h
//  ACEView
//
//  Created by Michael Robinson on 2/12/12.
//  Copyright (c) 2012 Code of Interest. All rights reserved.
//
#import <ACEView/ACEThemes.h>

/** Class providing methods to:

 - convert ACE theme names used internally to to their human-readable counterparts and vise-versa.
 - Convert ACETheme constants into their ACE theme or human-readable ACE theme names.

 */

@interface ACEThemeNames : NSObject { }

/**---------------------------------------------------------------------------------------
 * @name Class Methods
 *  ---------------------------------------------------------------------------------------
 */

/** Return an array of ACE theme names.

 @return Array of ACE theme names.
 */
+ (NSArray *) themeNames;
/** Return an array of human-readable ACE theme names.

 @return Array of human-readable ACE theme names.
 */
+ (NSArray *) humanThemeNames;

/** Return the ACE theme name for a given ACETheme constant.

 @param theme The ACETheme constant to be converted.
 @return The ACE theme name corresponding to the given ACETheme constant.
 */
+ (NSString *) nameForTheme:(ACETheme)theme;
/** Return the human-readable ACE theme name for a given ACETheme constant.

 @param theme The ACETheme constant to be converted.
 @return The human-readable ACE theme name corresponding to the given ACETheme constant.
 */
+ (NSString *) humanNameForTheme:(ACETheme)theme;

@end
