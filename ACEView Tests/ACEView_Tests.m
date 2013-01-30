//
//  ACEView_Tests.m
//  ACEView Tests
//
//  Created by Michael Robinson on 30/01/13.
//  Copyright (c) 2013 Code of Interest. All rights reserved.
//

#import "ACEView_Tests.h"
#import "ACEViewAppDelegate.h"
#import "ACEView.h"

@implementation ACEView_Tests

- (void)setUp {
    [super setUp];
    appDelegate = [[NSApplication sharedApplication] delegate];
    aceView = [appDelegate aceView];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testAppDelegate {
    STAssertTrue([appDelegate isKindOfClass:[ACEViewAppDelegate class]],
                 @"Cannot find the application delegate.");
}

- (void) testAceViewLoad {
    STAssertNotNil(aceView, @"ACEView should load");
}

- (void) testSetHTML {
    NSString *html = @"<html><head></head><body></body></html>";
    [aceView setString:html];
    STAssertEqualObjects(html, [aceView string], @"ACEView string should equal set value");
}

@end
