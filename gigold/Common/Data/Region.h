//
//  Region.h
//  gigold
//
//  Created by 单小萍 on 15/10/29.
//  Copyright © 2015年 wsc. All rights reserved.
//
/*地区数据*/
#import <Foundation/Foundation.h>

@interface Region : NSObject
//地区编码
@property(nonatomic,copy)NSString* code;
//地区名城
@property(nonatomic,copy)NSString* name;
//地区从属
@property(nonatomic,copy)NSString* belongCode;
@end
