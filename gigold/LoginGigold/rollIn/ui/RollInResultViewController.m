//
//  RollInResultViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "RollInResultViewController.h"
#import "IncomeInstructionViewController.h"
#import "appliacation_attribute.h"
#import "TimeUtil.h"
@interface RollInResultViewController (){
    __weak IBOutlet UIButton *next;
    //转入金额
    __weak IBOutlet UILabel *amountLabel;
    //转入时间
    __weak IBOutlet UILabel *rollInTime;
    //计算收益时间
    __weak IBOutlet UILabel *calculateIncomeTime;
    //获得收益时间
    __weak IBOutlet UILabel *getIncomeTime;

}
@end

@implementation RollInResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"结果详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"收益说明" style:UIBarButtonItemStyleDone target:self action:@selector(incomeInstructions)];
    NSDictionary* attributesDic = [NSDictionary dictionaryWithObjectsAndKeys:main_font,NSFontAttributeName,nil];
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributesDic forState:0];
    amountLabel.text = [NSString stringWithFormat:@"成功转入%@元",self.parames[@"amount"]];
    NSDate* date = self.parames[@"time"];
    rollInTime.text = [TimeUtil nsDataToString:date format:DATA6];
    
    NSDate* nextDate1 = [TimeUtil getMarkTime:0 month:0 day:1 hours:0 date:date];
    calculateIncomeTime.text = [TimeUtil nsDataToString:nextDate1 format:DATA7];
    
    NSDate* nextDate2 = [TimeUtil getMarkTime:0 month:0 day:2 hours:0 date:date];
    getIncomeTime.text = [TimeUtil nsDataToString:nextDate2 format:DATA7];
    
    next.layer.cornerRadius = next.frame.size.height/2;
    // Do any additional setup after loading the view.
}


//收益说明
-(void)incomeInstructions{
    IncomeInstructionViewController* incomeInstructionViewController = storyboard_controller_identity(@"GigoldTreasureHome", @"struction");
    [self.navigationController pushViewController:incomeInstructionViewController animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
}
//关闭
-(void)close{
    UIViewController* specifiedViewController = [self.navigationController viewControllers][1];
    [self.navigationController popToViewController:specifiedViewController animated:YES];
    
}



#pragma mark -xib链接
//再次转入
- (IBAction)againRollIn:(id)sender {
    UIViewController* specifiedViewController = [self.navigationController viewControllers][2];
    [self.navigationController popToViewController:specifiedViewController animated:YES];
}


@end
