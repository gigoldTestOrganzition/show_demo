//
//  NSDictionary+Optimize.m
//  eteams
//
//  Created by liu.wei on 9/10/14.
//  Copyright (c) 2014 王 苏诚. All rights reserved.
//

#import "NSDictionary+Optimize.h"

@implementation NSDictionary (Optimize)

- (id)ObjectForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if ([object isKindOfClass:[NSNull class]]) {
        object = nil;
    }
    return object;
}

@end

@implementation NSMutableDictionary (Optimize)

- (id)ObjectForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if ([object isKindOfClass:[NSNull class]]) {
        object = nil;
    }
    return object;
}

- (void)SetObject:(id)anObject forKey:(id <NSCopying>)aKey {
    if (anObject && aKey) {
        [self setObject:anObject forKey:aKey];
    }
}

@end
