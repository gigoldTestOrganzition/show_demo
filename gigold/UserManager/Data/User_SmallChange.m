//
//  User_SmallChange.m
//  gigold
//
//  Created by wsc on 15/11/5.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "User_SmallChange.h"

@implementation User_SmallChange

-(id)init{
    self.acTyp = @"";
    self.oldTxDt = @"";
    self.oldTxTm = @"";
    self.busTyp = @"";
    self.txTyp = @"";
    self.ordTyp = @"";
    self.ordNo = @"";
    self.sysCnl = @"";
    self.capTyp = @"";
    self.ccy = @"";
    self.txAmt = 0;
    self.drAmt = 0;
    self.crAmt = 0;
    self.odAmt = 0;
    self.bal = 0;
    self.canWdBal = 0;
    return [super init];
}

// "00：远程消费01：充值02：提现03：缴话费04：缴公共事业费05：现场联机06：现场脱机07：圈存08：转账09：手工调账"
-(NSString*)ordTyp{
    if ([_ordTyp isEqualToString:@"0"]) {
        return @"远程消费";
    }
    else if ([_ordTyp isEqualToString:@"01"]){
        return @"充值";
    }
    else if ([_ordTyp isEqualToString:@"02"]){
        return @"提现";
    }
    else if ([_ordTyp isEqualToString:@"03"]){
        return @"缴话费";
    }
    else if ([_ordTyp isEqualToString:@"04"]){
        return @"缴公共事业费";
    }
    else if ([_ordTyp isEqualToString:@"05"]){
        return @"现场联机";
    }
    else if ([_ordTyp isEqualToString:@"06"]){
        return @"现场脱机";
    }
    else if ([_ordTyp isEqualToString:@"07"]){
        return @"圈存";
    }
    else if ([_ordTyp isEqualToString:@"08"]){
        return @"转账";
    }
    else if ([_ordTyp isEqualToString:@"09"]){
        return @"手工调账";
    }
    return @"未知类型";
}

@end
