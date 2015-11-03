//
//  SenvenIncomeRateViewController.h
//  gigold
//
//  Created by 单小萍 on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//
/*
 *七年年化率收益
 */
#import "SXPViewController.h"
#import "BaseViewController.h"
typedef NS_ENUM(NSInteger,IRShowType){
    //七日收益
    IRShowTypeSeven = 1 << 0,
    //万分收益
    IRShowTypeTenthousand = 1 << 1
};
@interface SenvenIncomeRateViewController : BaseViewController
@property(nonatomic,assign)IRShowType showType;
@end
