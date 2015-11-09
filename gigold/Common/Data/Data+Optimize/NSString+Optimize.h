//
//  NSString+Optimize.h
//  eteams
//
//  Created by liu.wei on 9/18/14.
//  Copyright (c) 2014 王 苏诚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Optimize)

+ (instancetype)StringWithUTF8String:(const char *)nullTerminatedCString;
- (NSString *)trimString;

@end
