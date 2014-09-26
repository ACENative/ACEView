#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ACEKeyboardHandler) {
    ACEKeyboardHandlerAce = 0,
    ACEKeyboardHandlerEmacs,
    ACEKeyboardHandlerVim,

    ACEKeyboardHandlerCount,  // keep track of the enum size automatically
};
