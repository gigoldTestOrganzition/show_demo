//
//  GigoldTreasureHomeViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/22.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "GigoldTreasureHomeViewController.h"
#import "appliacation_attribute.h"
#import "IncomeInstructionViewController.h"
#import "IncomeDetailViewController.h"
#import "TradingDetailViewController.h"
#import "SenvenIncomeRateViewController.h"
#import "TenThousandIncomeViewController.h"
#import "RollOutViewController.h"
#import "RollInViewController.h"

@interface GigoldTreasureHomeViewController (){
  //累计收益
    
    __weak IBOutlet UIView *totalIncomeView;
    __weak IBOutlet UILabel *totalIncome;
  //总金额
    __weak IBOutlet UIView *totalAmountView;
    __weak IBOutlet UILabel *totalAmount;
    
   //昨日收益
    __weak IBOutlet UIView *yesterDayIncomeView;
    __weak IBOutlet UILabel *yesterDayIncome;
  //七年收益率
    __weak IBOutlet UILabel *sevenIncomeRate;
  //万分收益
    __weak IBOutlet UILabel *tenThousandIncome;
  //转出
    __weak IBOutlet UILabel *rollOut;
  //转入
    __weak IBOutlet UILabel *rollIn;
}

@end

@implementation GigoldTreasureHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"吉高宝";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"收益说明" style:UIBarButtonItemStyleDone target:self action:@selector(incomeInstructions)];
    
    
    UITapGestureRecognizer* yesterDayIncomeRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(incomeDetail)];
    [yesterDayIncomeView addGestureRecognizer:yesterDayIncomeRecognizer];
    
    
    UITapGestureRecognizer* totalIncomeRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(incomeDetail)];
     [totalIncomeView addGestureRecognizer:totalIncomeRecognizer];
    
    UITapGestureRecognizer* totalAmountRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tradingDetail)];
     [totalAmountView addGestureRecognizer:totalAmountRecognizer];
    
    
    rollOut.userInteractionEnabled = YES;
    UITapGestureRecognizer* rollOutRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rollOut)];
    [rollOut addGestureRecognizer:rollOutRecognizer];
    
    rollIn.userInteractionEnabled = YES;
    UITapGestureRecognizer* rollInRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rollIn)];
    [rollIn addGestureRecognizer:rollInRecognizer];
    // Do any additional setup after loading the view.
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
#pragma mark -转出，转入
//收益明细
-(void)incomeDetail{
    IncomeDetailViewController* incomeDetailViewController =(IncomeDetailViewController*)storyboard_controller_identity(@"GigoldTreasureHome", @"incomeDetail");
    [self.navigationController pushViewController:incomeDetailViewController animated:YES];
    NSLog(@"incomeDetail");

}
//交易明细
-(void)tradingDetail{
    NSLog(@"tradingDetail");
    TradingDetailViewController* tradingDetailViewController =(TradingDetailViewController*)storyboard_controller_identity(@"GigoldTreasureHome", @"tradingDetail");
    [self.navigationController pushViewController:tradingDetailViewController animated:YES];
    
    
}
// 转出
-(void)rollOut{
    NSLog(@"out");
    RollOutViewController* rollOutViewController  = (RollOutViewController*)storyboard_controller_identity(@"GigoldTreasureHome", @"rollOut");
    [self.navigationController pushViewController:rollOutViewController animated:YES];
}
//转入
-(void)rollIn{
     NSLog(@"in");
    RollInViewController* rollInViewController  = (RollInViewController*)storyboard_controller_identity(@"GigoldTreasureHome", @"rollIn");
    [self.navigationController pushViewController:rollInViewController animated:YES];
}
//收益说明
-(void)incomeInstructions{
    IncomeInstructionViewController* incomeInstructionViewController  = (IncomeInstructionViewController*)storyboard_controller_identity(@"GigoldTreasureHome", @"struction");
    [self.navigationController pushViewController:incomeInstructionViewController animated:YES];
    NSLog(@"instructions");
}

#pragma mark -xib跳转
//进去七年年化率查看
- (IBAction)intoSevenIncomeRate:(id)sender {
    NSLog(@"seven");
    SenvenIncomeRateViewController* senvenIncomeRateViewController  = (SenvenIncomeRateViewController*)storyboard_controller_identity(@"GigoldTreasureHome", @"senverIncome");
    [self.navigationController pushViewController:senvenIncomeRateViewController animated:YES];
    
}
//进去万分收益查看
- (IBAction)intotenThousandIncome:(id)sender {
    NSLog(@"tenthousand");
    TenThousandIncomeViewController* tenThousandIncomeViewController  = (TenThousandIncomeViewController*)storyboard_controller_identity(@"GigoldTreasureHome", @"tenThousandIncome");
    [self.navigationController pushViewController:tenThousandIncomeViewController animated:YES];
}
@end
