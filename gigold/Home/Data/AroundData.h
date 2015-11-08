//
//  AroundData.h
//  gigold
//
//  Created by 单小萍 on 15/11/7.
//  Copyright © 2015年 wsc. All rights reserved.
//
/*
 *周边
 */
#import <Foundation/Foundation.h>

@interface AroundData : NSObject
//商家名字
@property(nonatomic,copy)NSString* merchantName;
//地址
@property(nonatomic,copy)NSString* address;
//优惠
@property(nonatomic,copy)NSString* discount;
//距离
@property(nonatomic,copy)NSString* distance;
//评价
@property(nonatomic,copy)NSString* evaluate;
//配送方式
@property(nonatomic,copy)NSString* sentWay;
@end
