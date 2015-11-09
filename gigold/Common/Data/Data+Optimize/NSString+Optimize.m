//
//  NSString+Optimize.m
//  eteams
//
//  Created by liu.wei on 9/18/14.
//  Copyright (c) 2014 王 苏诚. All rights reserved.
//

#import "NSString+Optimize.h"

@implementation NSString (Optimize)

+ (instancetype)StringWithUTF8String:(const char *)nullTerminatedCString {
    if (nullTerminatedCString == NULL) {
        return @"";
    }
    return [self stringWithUTF8String:nullTerminatedCString];
}

- (NSString *)trimString {
    NSMutableString *mStr = [self mutableCopy];
    CFStringTrimWhitespace((CFMutableStringRef)mStr);
    NSString *result = [mStr copy];
    return result;
}

@end
