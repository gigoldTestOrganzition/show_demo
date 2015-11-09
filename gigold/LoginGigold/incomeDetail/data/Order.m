//
//  IncomeDetailData.m
//  gigold
//
//  Created by 单小萍 on 15/10/22.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "Order.h"

@implementation Order
@synthesize orderType = _orderType;
@synthesize rollFlowProcess = _rollFlowProcess;
@synthesize timeStr = _timeStr;
@synthesize desc = _desc;
@synthesize amountStr = _amountStr;
//获得订单类型描述
+(NSString*)getOrderTypeDesc:(OrderType)orderType{
    switch (orderType) {
        case OrderTypeNomalRollIn:
            return @"普通转入";
        case OrderTypeFastRollIn:
            return @"快速转入";
        case OrderTypeNomalRollOut:
            return @"普通转出";
        case OrderTypeFastRollOut:
            return @"快速转出";
        case OrderTypeIncome:
            return @"收益";
        case OrderTypeProperty:
            return @"物业费";
        case OrderTypeStopCarfees:
            return @"停车费";
        case OrderTypeElectricityfees:
            return @"电费";
        case OrderTypeWaterfees:
            return @"水费";
        case OrderTypeTransferAccounts:
            return @"转账";
    }
    return @"";
}
@end
