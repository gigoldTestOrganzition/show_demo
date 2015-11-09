//
//  NSArray+Optimize.m
//  eteams
//
//  Created by liu.wei on 9/3/14.
//  Copyright (c) 2014 王 苏诚. All rights reserved.
//

#import "NSArray+Optimize.h"

@implementation NSArray (Optimize)

- (id)ObjectAtIndex:(NSUInteger)index {
    if (self.count <= index) {
        return nil;
    }
    return [self objectAtIndex:index];
}

@end

@implementation NSMutableArray (Optimize)

- (id)ObjectAtIndex:(NSUInteger)index {
    if (self.count <= index) {
        return nil;
    }
    return [self objectAtIndex:index];
}

- (void)InsertObject:(id)anObject atIndex:(NSUInteger)index {
    if (self.count < index) {
        return;
    }
    [self insertObject:anObject atIndex:index];
}

- (void)RemoveObjectAtIndex:(NSUInteger)index {
    if (self.count <= index) {
        return;
    }
    [self removeObjectAtIndex:index];
}

- (void)ReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (self.count <= index) {
        return;
    }
    [self replaceObjectAtIndex:index withObject:anObject];
}

@end
