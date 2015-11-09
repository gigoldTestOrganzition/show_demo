//
//  NSArray+Optimize.h
//  eteams
//
//  Created by liu.wei on 9/3/14.
//  Copyright (c) 2014 王 苏诚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Optimize)

- (id)ObjectAtIndex:(NSUInteger)index;

@end

@interface NSMutableArray (Optimize)

- (id)ObjectAtIndex:(NSUInteger)index;
//- (void)InsertObject:(id)anObject atIndex:(NSUInteger)index;
//- (void)RemoveObjectAtIndex:(NSUInteger)index;
//- (void)ReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

@end