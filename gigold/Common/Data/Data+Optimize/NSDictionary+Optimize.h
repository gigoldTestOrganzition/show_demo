//
//  NSDictionary+Optimize.h
//  eteams
//
//  Created by liu.wei on 9/10/14.
//  Copyright (c) 2014 王 苏诚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Optimize)

- (id)ObjectForKey:(id)aKey;

@end

@interface NSMutableDictionary (Optimize)

- (id)ObjectForKey:(id)aKey;
- (void)SetObject:(id)anObject forKey:(id <NSCopying>)aKey;

@end