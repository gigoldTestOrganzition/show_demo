//
//  RollOutResultViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "RollOutResultViewController.h"
#import "TimeUtil.h"
@interface RollOutResultViewController (){
    //时间和银行
    __weak IBOutlet UILabel *timeAndBankLabel;
    // 到账时间
    __weak IBOutlet UILabel *getTime;
}
@end

@implementation RollOutResultViewController
@synthesize parames=_parames;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"结果详情";
    NSDictionary* attributesDic = [NSDictionary dictionaryWithObjectsAndKeys:main_font,NSFontAttributeName,nil];
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributesDic forState:0];
    
    NSDate* date = _parames[@"time"];
    timeAndBankLabel.text = [NSString stringWithFormat:@"%@ 招商银行（尾号4567）", [TimeUtil nsDataToString:date format:DATA6]];
    getTime.text = [TimeUtil nsDataToString:[TimeUtil getMarkTime:0 month:0 day:0 hours:2 date:date] format:DATA6];
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
}

//关闭界面
-(void)close{
    UIViewController* specifiedViewController = [self.navigationController viewControllers][1];
    [self.navigationController popToViewController:specifiedViewController animated:YES];
    
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
