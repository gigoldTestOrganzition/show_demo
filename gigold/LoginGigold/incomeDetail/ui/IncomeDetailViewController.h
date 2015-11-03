//
//  IncomeDetailViewController.h
//  gigold
//
//  Created by 单小萍 on 15/10/22.
//  Copyright © 2015年 wsc. All rights reserved.
//
/*
 *收益明细
 */
#import "BaseViewController.h"
typedef NS_ENUM(NSInteger,CheckType){
   //转入
   CheckTypeRollIn,
   //转出
   CheckTypeRollOut,
   //转入转出
   CheckTypeRollInOut,
   //收益
   CheckTypeInCome
};
@interface IncomeDetailViewController : BaseViewController
//查看类型
@property(nonatomic,assign)CheckType checkType;
@end
