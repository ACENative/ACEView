#import "ACEKeyboardHandlers.h"

/** Class providing methods to:

 - convert ACE keyboard handler names used internally to to their human-readable counterparts and vise-versa.
 - Convert ACEKeyboardHandler constants into their ACE keyboard handler or human-readable ACE keyboard handler names.

 */
@interface ACEKeyboardHandlerNames : NSObject { }

/**---------------------------------------------------------------------------------------
 * @name Class Methods
 *  ---------------------------------------------------------------------------------------
 */

/** Return an array of ACE keyboard handler names.

 @return Array of ACE keyboard handler names.
 */
+ (NSArray *) keyboardHandlerCommands;
/** Return an array of human-readable ACE keyboard handler names.

 @return Array of human-readable ACE keyboard handler names.
 */
+ (NSArray *) humanKeyboardHandlerNames;

/** Return the ACE keyboard handler command for a given ACEKeyboardHandler constant.

 @param keyboardHandler The ACEKeyboardHandler constant to be converted.
 @return The ACE keyboard handler name corresponding to the given ACEKeyboardHandler constant.
 */
+ (NSString *) commandForKeyboardHandler:(ACEKeyboardHandler)keyboardHandler;
/** Return the human-readable ACE keyboard handler name for a given ACEKeyboardHandler constant.

 @param keyboardHandler The ACEKeyboardHandler constant to be converted.
 @return The human-readable ACE keyboard handler name corresponding to the given ACEKeyboardHandler constant.
 */
+ (NSString *) humanNameForKeyboardHandler:(ACEKeyboardHandler)keyboardHandler;

@end
