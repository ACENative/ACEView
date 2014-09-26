#import "ACEKeyboardHandlerNames.h"

NSString *const _ACEKeyboardHandlerCommands[ACEKeyboardHandlerCount] = {
    [ACEKeyboardHandlerAce]			 = @"null",
    [ACEKeyboardHandlerEmacs]		 = @"require(\"ace/keyboard/emacs\").handler",
    [ACEKeyboardHandlerVim]			 = @"require(\"ace/keyboard/vim\").handler"
};

NSString *const _ACEKeyboardHandlerNamesHuman[ACEKeyboardHandlerCount] = {
    [ACEKeyboardHandlerAce]			 = @"Ace",
    [ACEKeyboardHandlerEmacs]		 = @"Emacs",
    [ACEKeyboardHandlerVim]			 = @"Vim"
};

@implementation ACEKeyboardHandlerNames

+ (NSArray *) keyboardHandlerCommands {
    return [NSArray arrayWithObjects:_ACEKeyboardHandlerCommands count:ACEKeyboardHandlerCount];
}
+ (NSArray *) humanKeyboardHandlerNames {
    return [NSArray arrayWithObjects:_ACEKeyboardHandlerNamesHuman count:ACEKeyboardHandlerCount];
}

+ (NSString *) commandForKeyboardHandler:(ACEKeyboardHandler)keyboardHandler  {
    return _ACEKeyboardHandlerCommands[keyboardHandler];
}
+ (NSString *) humanNameForKeyboardHandler:(ACEKeyboardHandler)keyboardHandler {
    return _ACEKeyboardHandlerNamesHuman[keyboardHandler];
}

@end
