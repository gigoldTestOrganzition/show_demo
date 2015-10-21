//
//  FonctionDesc.h
//  gigold
//
//  Created by 单小萍 on 15/10/20.
//  Copyright © 2015年 wsc. All rights reserved.
//
/*
 *功能描述数据
 */
#import <Foundation/Foundation.h>
#import "JsonFactory.h"
@interface FonctionDesc : NSObject<JsonData>
//图片路径
@property(nonatomic,copy)NSString* imgPath;
//描述
@property(nonatomic,copy)NSString* desc;
//响应
@property(nonatomic,assign)SEL action;
@end
