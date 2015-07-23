//
//  ACEObject.m
//  ACEView
//
//  Created by Jan Gassen on 10/01/15.
//  Copyright (c) 2015 Code of Interest. All rights reserved.
//

#import <ACESearchItem.h>

@interface ACESearchItem()
+ (ACESearchItem*) convertSingleObject:(NSDictionary*) data;
+ (NSMutableArray *)convertMultipleObjects:(NSArray*)object;
@end

@implementation ACESearchItem

@synthesize startColumn, startRow, endColumn, endRow;

+ (NSArray*) fromString:(NSString*)text {
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:[text dataUsingEncoding:NSUTF8StringEncoding]
                 options:0
                 error:&error];
    
    if(!error && [object isKindOfClass:[NSArray class]]) {
        return [self convertMultipleObjects:object];
    }
    
    return nil;
}

+ (NSMutableArray *)convertMultipleObjects:(NSArray*)list {
    NSMutableArray* result = [[NSMutableArray alloc] init];
    for (id item in list) {
        if ([item isKindOfClass:[NSDictionary class]]) {
            [result addObject:[ACESearchItem convertSingleObject:item]];
        }
    }
    return result;
}

+ (ACESearchItem*) convertSingleObject:(NSDictionary*) data {
    ACESearchItem* result = [[ACESearchItem alloc] init];
    
    NSDictionary* start = [data objectForKey:@"start"];
    if (start != nil) {
        [result setStartRow:[ACESearchItem getIntOrZero:start key:@"row"]];
        [result setStartColumn:[ACESearchItem getIntOrZero:start key:@"column"]];
    }
    
    NSDictionary* end = [data objectForKey:@"end"];
    if (end != nil) {
        [result setEndRow:[ACESearchItem getIntOrZero:end key:@"row"]];
        [result setEndColumn:[ACESearchItem getIntOrZero:end key:@"column"]];
    }
    
    return result;
}

+ (NSInteger) getIntOrZero:(NSDictionary*) dict key:(NSString*)key {
    id val = [dict objectForKey:key];
    if (val) {
        return [val integerValue];
    }
    return 0;
}

@end