//
//  BankCard.h
//  gigold
//
//  Created by 单小萍 on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//
/*
 *银行卡
 */
#import <Foundation/Foundation.h>

@interface BankCard : NSObject
//卡姓名
@property(nonatomic,copy)NSString* name;
//余额
@property(nonatomic,copy)NSString* balance;

@end
