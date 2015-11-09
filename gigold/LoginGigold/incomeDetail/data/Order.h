//
//  IncomeDetailData.h
//  gigold
//
//  Created by 单小萍 on 15/10/22.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,OrderType){
    //普通转入
    OrderTypeNomalRollIn,
    //快速转入
    OrderTypeFastRollIn,
    //普通转出
    OrderTypeNomalRollOut,
    //快速转出
    OrderTypeFastRollOut,
    //收益
    OrderTypeIncome,
    //物业
    OrderTypeProperty,
    //停车费
    OrderTypeStopCarfees,
    //电费
    OrderTypeElectricityfees,
    //水费
    OrderTypeWaterfees,
    //转账
    OrderTypeTransferAccounts
    
};
//转入转出流程进度
typedef NS_ENUM(NSInteger,RollFlowProcess){
    //开始
    RollFlowProcessStart,
    //收益计算
    RollFlowProcessCalculate,
    //到账
    RollFlowProcessEnd
};
@interface Order : NSObject
@property(nonatomic,assign)OrderType orderType;
@property(nonatomic,assign)RollFlowProcess rollFlowProcess;
@property(nonatomic,copy)NSString* desc;
@property(nonatomic,copy)NSString* timeStr;
@property(nonatomic,copy)NSString* amountStr;
//获得订单类型描述
+(NSString*)getOrderTypeDesc:(OrderType)orderType;
@end
