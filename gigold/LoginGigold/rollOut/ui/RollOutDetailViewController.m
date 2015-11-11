//
//  RollOutDetailViewController.m
//  gigold
//
//  Created by 单小萍 on 15/11/1.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "RollOutDetailViewController.h"
#import "TimeUtil.h"
#import "StringUtil.h"

@interface RollOutDetailViewController (){
    //转出类型
    __weak IBOutlet UILabel *rollOutType;
    //转出时间
    __weak IBOutlet UILabel *rollOutTime;
    //转出金额
    __weak IBOutlet UILabel *rollOutAmount;
    
    
    
    __weak IBOutlet UILabel *flow1Desc;
    __weak IBOutlet UILabel *flow1Time;
    
    
    
    __weak IBOutlet UILabel *flow2Desc;
    
    __weak IBOutlet UILabel *flow2Time;
    
    __weak IBOutlet UIImageView *flow2Img;
    
    
    __weak IBOutlet UIView *flowLine1;
    __weak IBOutlet UIView *flowLine2;
    
    
    __weak IBOutlet UIButton *payBtn;
    
    __weak IBOutlet UIButton *deleteBtn;
    
    
    __weak IBOutlet NSLayoutConstraint *delectToPayLayoutConstraint;
    __weak IBOutlet NSLayoutConstraint *delectToViewLayoutConstraint;
}
@end

@implementation RollOutDetailViewController
@synthesize order=_order;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [self getTitle];
    rollOutType.text = [Order getOrderTypeDesc:_order.orderType];
    if ([StringUtil isEmpty:_order.desc]){
        rollOutTime.textColor = white_auxiliary_color;
        rollOutTime.text = _order.timeStr;
    }else{
        rollOutTime.textColor =  status_dec_yellow_color;
        rollOutTime.text = _order.desc;
    }
    rollOutAmount.textColor  = [self getAmoutColor];
    rollOutAmount.text = [self getAmountDesc:_order.amountStr];
    [self setFlowStatus];
    
    payBtn.layer.cornerRadius = payBtn.frame.size.height/2;
    deleteBtn.layer.cornerRadius = deleteBtn.frame.size.height/2;
    deleteBtn.layer.borderColor =white_auxiliary_color.CGColor;
    deleteBtn.layer.borderWidth = 1.f;
    
    [self setPayBtnAndDelectBtn];
}
//获得金额描述
-(NSString*)getAmountDesc:(NSString*)amoutStr{
    switch (_order.orderType) {
        case OrderTypeProperty:
        case OrderTypeStopCarfees:
        case OrderTypeElectricityfees:
        case OrderTypeWaterfees:
        case OrderTypeFastRollOut:
        case OrderTypeNomalRollOut:
            return [NSString stringWithFormat:@"-%@",amoutStr];
        case OrderTypeTransferAccounts:
            return [NSString stringWithFormat:@"+%@",amoutStr];
    }
    return [NSString stringWithFormat:@"+%@",amoutStr];
}
//获得金额颜色
-(UIColor*)getAmoutColor{
    switch (_order.orderType) {
        case OrderTypeProperty:
        case OrderTypeStopCarfees:
        case OrderTypeElectricityfees:
        case OrderTypeWaterfees:
        case OrderTypeFastRollOut:
        case OrderTypeNomalRollOut:
            return warning_red_color;
        case OrderTypeTransferAccounts:
            return theme_color;
    }
    return theme_color;
}
-(NSString*)getTitle{
    switch (_order.orderType) {
        case OrderTypeFastRollOut:
        case OrderTypeNomalRollOut:
            return @"转出详情";
        case OrderTypeProperty:
        case OrderTypeStopCarfees:
        case OrderTypeElectricityfees:
        case OrderTypeWaterfees:
        case OrderTypeTransferAccounts:
            return @"账单详情";
    }
    return @"详情";
}
/*
 *流程状态设置
 */
-(void)setFlowStatus{
    switch (_order.rollFlowProcess) {
        case RollFlowProcessStart:{
                flowLine1.backgroundColor = theme_color;
                flowLine2.backgroundColor = gray_diver_color;
                flow2Img.image = [UIImage imageNamed:@"ico_submit_2_2.png"];
                flow2Desc.textColor = gray_diver_color;
                flow1Desc.textColor = theme_color;
            }
            break;
        case RollFlowProcessEnd:{
                flowLine1.backgroundColor = theme_color;
                flowLine2.backgroundColor = theme_color;
                flow2Img.image = [UIImage imageNamed:@"ico_submit_2_1.png"];
                flow2Desc.textColor = theme_color;
                flow1Desc.textColor = theme_color;
            }
            break;
        case RollFlowProcessCalculate:
            break;
    }
    [self setFlowProcessDesc];
}

//获得流程描述
-(NSString*)setFlowProcessDesc{
    if (_order.rollFlowProcess == RollFlowProcessStart) {
        switch (_order.orderType) {
            case OrderTypeNomalRollOut:{
                    flow1Desc.text = @"申请已提交，等待银行处理";
                    flow2Desc.text = @"最迟到账时间";
                    NSDate* date = [TimeUtil stringToNsData:_order.timeStr format:DATA1];
                    flow1Time.text = [NSString stringWithFormat:@"%@ 招商银行（尾号4567）", [TimeUtil nsDataToString:date format:DATA6]];
                    flow2Time.text = [self getFlow2Time:date];

                }
                break;
            case OrderTypeFastRollOut:{
                    flow1Desc.text = @"申请已提交，等待银行处理";
                    flow2Desc.text = @"预计两小时到账";
                    NSDate* date = [TimeUtil stringToNsData:_order.timeStr format:DATA1];
                    flow1Time.text = [NSString stringWithFormat:@"%@ 招商银行（尾号4567）", [TimeUtil nsDataToString:date format:DATA6]];
                    flow2Time.text = [self getFlow2Time:date];
            }
                break;
            case OrderTypeProperty:
            case OrderTypeElectricityfees:
            case OrderTypeWaterfees:
            case OrderTypeStopCarfees:
            case OrderTypeTransferAccounts:{
                flow1Desc.text = @"已提交申请，等待付款";
                flow2Desc.text = @"交易完成";
                NSDate* date = [TimeUtil stringToNsData:_order.timeStr format:DATA1];
                flow1Time.text = @"订单编号：20150012300 \n订单信息：御溪国际（3栋1032）";
                flow2Time.text = @"";//[self getFlow2Time:date];
            }
            break;
        }
    }else if(_order.rollFlowProcess == RollFlowProcessEnd){
        
        switch (_order.orderType) {
            case OrderTypeNomalRollOut:
            case OrderTypeFastRollOut:{
                 flow1Desc.text = @"提出转账申请";
                 flow2Desc.text = @"到账时间";
                 NSDate* date = [TimeUtil stringToNsData:_order.timeStr format:DATA1];
                 flow1Time.text = [NSString stringWithFormat:@"%@ 招商银行（尾号4567）", [TimeUtil nsDataToString:date format:DATA6]];
                 flow2Time.text = [self getFlow2Time:date];
            }
            break;
            case OrderTypeProperty:
            case OrderTypeElectricityfees:
            case OrderTypeWaterfees:
            case OrderTypeStopCarfees:
            case OrderTypeTransferAccounts:{
                    flow1Desc.text = @"提交申请";
                    flow2Desc.text = @"交易完成";
                    NSDate* date = [TimeUtil stringToNsData:_order.timeStr format:DATA1];
                    flow1Time.text = @"订单编号：20150012300 \n订单信息：御溪国际（3栋1032）";
                    flow2Time.text = @"付款信息：招商银行信用卡（7362）";
            }
            break;
        }

    
    }
    return @"";
}
/*
 *设置按钮
 */
-(void)setPayBtnAndDelectBtn{
    switch (_order.orderType) {
        case OrderTypeProperty:
        case OrderTypeStopCarfees:
        case OrderTypeElectricityfees:
        case OrderTypeWaterfees:{
            if (_order.rollFlowProcess == RollFlowProcessStart) {
                payBtn.hidden = NO;
                deleteBtn.hidden = NO;
                delectToViewLayoutConstraint.priority = 250;
                delectToPayLayoutConstraint.priority = 750;
            }else{
                payBtn.hidden = YES;
                deleteBtn.hidden = NO;
                delectToViewLayoutConstraint.priority = 750;
                delectToPayLayoutConstraint.priority = 250;
            }
        }
        break;
        default:{
            payBtn.hidden = YES;
            deleteBtn.hidden = YES;
        }
        break;
    }

}


/*
 *获得时间
 */
-(NSString*)getFlow2Time:(NSDate*)date{
    switch (_order.orderType) {
        case OrderTypeNomalRollOut:
            return [TimeUtil nsDataToString:[TimeUtil getMarkTime:0 month:0 day:2 hours:0 date:date] format:DATA6];
            
        case OrderTypeFastRollOut:
            return [TimeUtil nsDataToString:[TimeUtil getMarkTime:0 month:0 day:0 hours:2 date:date] format:DATA6];
           
    }
    return [TimeUtil nsDataToString:[TimeUtil getMarkTime:0 month:0 day:2 hours:0 date:date] format:DATA6];

}
@end
