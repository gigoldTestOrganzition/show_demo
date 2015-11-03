//
//  RollInDetailViewController.m
//  gigold
//
//  Created by 单小萍 on 15/11/1.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "RollInDetailViewController.h"
#import "TimeUtil.h"
@interface RollInDetailViewController (){
    //转入类型
    __weak IBOutlet UILabel *rollInType;
    //转入时间
    __weak IBOutlet UILabel *rollInTime;
    //转入金额
    __weak IBOutlet UILabel *rollInAmount;
    
    //流程转入金额
    __weak IBOutlet UILabel *flowRollInAmount;
    //流程转入时间
    __weak IBOutlet UILabel *flowRollInTime;
    //计算收益时间
    __weak IBOutlet UILabel *calculateIncomeTime;
    __weak IBOutlet UIImageView *incomeImg;
    
    //收益到转时间
    __weak IBOutlet UILabel *getIncomeTime;
    __weak IBOutlet UIImageView *getIncomeImg;
    
    
    
    __weak IBOutlet UIView *line1;
    __weak IBOutlet UIView *line2;
    __weak IBOutlet UIView *line3;
    __weak IBOutlet UIView *line4;
}
@end

@implementation RollInDetailViewController
@synthesize order=_order;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"转入详情";
    rollInType.text = [self getOrderTypeDesc];
    rollInTime.text = _order.timeStr;
    rollInAmount.text = _order.amountStr;
    
    flowRollInAmount.text = [NSString stringWithFormat:@"成功转入%@元",_order.amountStr];
    
    NSDate* date = [TimeUtil stringToNsData:_order.timeStr format:DATA1];
    flowRollInTime.text = [TimeUtil nsDataToString:date format:DATA6];
    calculateIncomeTime.text = [TimeUtil nsDataToString:[TimeUtil getMarkTime:0 month:0 day:1 hours:0 date:date] format:DATA7];
    
    getIncomeTime.text = [TimeUtil nsDataToString:[TimeUtil getMarkTime:0 month:0 day:2 hours:0 date:date] format:DATA7];
    //设置流程
    [self setFlowProcess];
    // Do any additional setup after loading the view.
}

//流程转台设置
-(void)setFlowProcess{
    switch (_order.rollFlowProcess) {
        case RollFlowProcessStart:{
            line1.backgroundColor = theme_color;
            line2.backgroundColor = gray_diver_color;
            line3.backgroundColor = gray_diver_color;
            line4.backgroundColor = gray_diver_color;
            incomeImg.image = [UIImage imageNamed:@"ico_submit_3_2.png"];
            getIncomeImg.image = [UIImage imageNamed:@"ico_submit_2_2.png"];
        }
        break;
        case RollFlowProcessCalculate:{
            line1.backgroundColor = theme_color;
            line2.backgroundColor = theme_color;
            line3.backgroundColor = theme_color;
            line4.backgroundColor = gray_diver_color;
            incomeImg.image = [UIImage imageNamed:@"ico_submit_3_1.png"];
            getIncomeImg.image = [UIImage imageNamed:@"ico_submit_2_2.png"];
        }
        break;
        case RollFlowProcessEnd:{
            line1.backgroundColor = theme_color;
            line2.backgroundColor = theme_color;
            line3.backgroundColor = theme_color;
            line4.backgroundColor = theme_color;
            incomeImg.image = [UIImage imageNamed:@"ico_submit_3_1.png"];
            getIncomeImg.image = [UIImage imageNamed:@"ico_submit_2_1.png"];
        }
        break;
    }
}
//获得订单类型描述
-(NSString*)getOrderTypeDesc{
    switch (_order.orderType) {
        case OrderTypeFastRollIn:
            return @"快速转入";
        case OrderTypeNomalRollIn:
            return @"普通转入";
    }
    return @"转入";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
