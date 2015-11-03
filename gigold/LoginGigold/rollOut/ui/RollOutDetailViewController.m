//
//  RollOutDetailViewController.m
//  gigold
//
//  Created by 单小萍 on 15/11/1.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "RollOutDetailViewController.h"
#import "TimeUtil.h"

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
    
}
@end

@implementation RollOutDetailViewController
@synthesize order=_order;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"转出详情";
    [self setRollOutDesc];
    rollOutTime.text = _order.timeStr;
    rollOutAmount.text = [NSString stringWithFormat:@"-%@",_order.amountStr];
    NSDate* date = [TimeUtil stringToNsData:_order.timeStr format:DATA1];
    flow1Time.text = [NSString stringWithFormat:@"%@ 招商银行（尾号4567）", [TimeUtil nsDataToString:date format:DATA6]];
    flow2Time.text = [self getFlow2Time:date];
    [self setFlowStatus];
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
            flow2Desc.text = [self getFlow2Desc];
            flow1Desc.textColor = theme_color;
            flow1Desc.text = @"申请已提交，等待银行处理";
            
        }
            break;
        case RollFlowProcessEnd:{
            flowLine1.backgroundColor = theme_color;
            flowLine2.backgroundColor = theme_color;
            flow2Img.image = [UIImage imageNamed:@"ico_submit_2_1.png"];
            flow2Desc.textColor = theme_color;
            flow2Desc.text = @"到账时间";
            flow1Desc.textColor = theme_color;
            flow1Desc.text = @"提出转账申请";
        }
            break;
        case RollFlowProcessCalculate:
            break;
    }
}
-(NSString*)getFlow2Desc{
    switch (_order.orderType) {
        case OrderTypeNomalRollOut:
            return @"最迟到账时间";
        case OrderTypeFastRollOut:
            return @"预计两小时到账";
    }
    return @"最迟到账时间";
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

/*
 *获得转出描述
 */
-(void)setRollOutDesc{
    switch (_order.orderType){
        case OrderTypeFastRollOut:
            rollOutType.text = @"快速转出";
            break;
        case OrderTypeNomalRollOut:
            rollOutType.text = @"普通转出";
            break;
    }
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
