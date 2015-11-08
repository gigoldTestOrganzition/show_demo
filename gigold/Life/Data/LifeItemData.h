//
//  LifeItemData.h
//  gigold
//
//  Created by 单小萍 on 15/11/7.
//  Copyright © 2015年 wsc. All rights reserved.
//
/*
 *生活模块功能
 */
#import <Foundation/Foundation.h>
@interface LifeItemData : NSObject
@property(nonatomic,strong)UIImage* img;
@property(nonatomic,copy)NSString* desc;
@property(nonatomic,assign)SEL action;
@end
