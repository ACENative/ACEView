# ACEView 
[![Build Status](https://travis-ci.org/faceleg/ACEView.svg?branch=master)](https://travis-ci.org/faceleg/ACEView)
[![Join the chat at https://gitter.im/faceleg/ACEView](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/faceleg/ACEView?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Use the wonderful [ACE editor](http://ace.ajax.org/) in your Cocoa applications.

![ACEView example](https://raw.github.com/faceleg/ACEView/master/Collateral/ace-example.jpg)

For great justice.

# Documentation

[Full API documentation](http://faceleg.github.com/ACEView/index.html).

# Usage

Using ACEView is about as easy as it gets. First add the ACEView framework to your project (see [linking library or framework](https://developer.apple.com/library/ios/#recipes/xcode_help-project_editor/Articles/AddingaLibrarytoaTarget.html#//apple_ref/doc/uid/TP40010155-CH17-SW1) for information on how to do this), then add a view to your XIB, and tell it to be an ACEView:

*note that ACEView has some dependencies - either use CocoaPods or run: `git submodule update --init --recursive` inside the folder you cloned ACEView into.

![ACEView XIB](https://raw.github.com/faceleg/ACEView/master/Collateral/ace-xib.jpg)

Make sure you've got an IBOutlet in your view controller, and bind that bad girl:

![ACEView XIB Binding](https://raw.github.com/faceleg/ACEView/master/Collateral/ace-xib-binding.jpg)

Now, you could do something like this:

```ObjectiveC
#import "Cocoa/Cocoa.h"
#import "ACEView/ACEView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, ACEViewDelegate> {
    IBOutlet ACEView *aceView;
}

@property (assign) IBOutlet NSWindow *window;

@end

#import "AppDelegate.h"
#import "ACEView/ACEView.h"
#import "ACEView/ACEModeNames.h"
#import "ACEView/ACEThemeNames.h"

@implementation AppDelegate

- (void) applicationDidFinishLaunching:(NSNotification *)aNotification {

    // Note that you'll likely be using local text
    [aceView setString:[NSString stringWithContentsOfURL:[NSURL URLWithString:@"https://github.com/faceleg/ACEView"] encoding:NSUTF8StringEncoding
                                                   error:nil]];
    [aceView setDelegate:self];
    [aceView setMode:ACEModeHTML];
    [aceView setTheme:ACEThemeXcode];
    [aceView setShowInvisibles:YES];
}

- (void) textDidChange:(NSNotification *)notification {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end
```

# Contributions

All are welcome, all are read.

Here is a list of the honorable humans who have submitted fixes, features and time to this great cause:

 - Michael Robinson
 - Matthias Neeracher
 - Mikael Hallendal
 - Ashok Gelal
 - Tim Preuß
 - Vincent Wayne
 - Vladimir Prudnikov
 - AquarHEAD L
 - Basuke Suzuki
 - Conor Taylor
 - Fabian Jäger
 - Harikrishnan Gopalakrishnan
