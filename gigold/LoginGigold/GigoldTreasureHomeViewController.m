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
#import "IncomeRrialViewController.h"
#import "UUChart.h"
@interface GigoldTreasureHomeViewController ()<UUChartDataSource>{
    //昨日收益
    __weak IBOutlet UILabel *yesterdayLabel;
    //总金额
    __weak IBOutlet UILabel *totalAmount;
    //收益试算
    __weak IBOutlet UIView *calculateIncomeView;
    
    //万份收益
    __weak IBOutlet UIView *tenthousandView;
    //万分收益
    __weak IBOutlet UILabel *tenthousandLable;
    //累计收益
    __weak IBOutlet UIView *totalIncomeView;
    //累计收益
    __weak IBOutlet UILabel *totalIncomeLable;
    //渐变背景view
    __weak IBOutlet UIView *topLayout;
    
    //七日年化率
    __weak IBOutlet UIView *sevenRateView;
    __weak IBOutlet UIView *sevenRateChartView;
    //转出
    __weak IBOutlet UILabel *rollOut;
    //转入
    __weak IBOutlet UILabel *rollIn;
}

@end

@implementation GigoldTreasureHomeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"吉有钱";
    
    NSDictionary* attributesDic = [NSDictionary dictionaryWithObjectsAndKeys:main_font,NSFontAttributeName,nil];
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributesDic forState:0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"收益说明" style:UIBarButtonItemStyleDone target:self action:@selector(incomeInstructions)];
    [self setTopBackground];
    
    UUChart* sevenRateChart = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(0.f,0.f,mainScreenWidth - 20.f,150.f) withSource:self withStyle:UUChartLineStyle];
    [sevenRateChart showInView:sevenRateChartView];
    
    
    UITapGestureRecognizer* yesterDayIncomeRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(incomeDetail)];
    yesterdayLabel.userInteractionEnabled = yesterdayLabel;
    [yesterdayLabel addGestureRecognizer:yesterDayIncomeRecognizer];
    
    UITapGestureRecognizer* totalAmountRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tradingDetail)];
    totalAmount.userInteractionEnabled = YES;
    [totalAmount addGestureRecognizer:totalAmountRecognizer];
    
    UITapGestureRecognizer* calculateIncomeGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(calculateIncome)];
    calculateIncomeView.userInteractionEnabled = YES;
    [calculateIncomeView addGestureRecognizer:calculateIncomeGestureRecognizer];
    
    UITapGestureRecognizer* tenthousandGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(intotenThousandIncome)];
    tenthousandView.userInteractionEnabled = YES;
    [tenthousandView addGestureRecognizer:tenthousandGestureRecognizer];
    
    UITapGestureRecognizer* totalIncomeRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(incomeDetail)];
     [totalIncomeView addGestureRecognizer:totalIncomeRecognizer];
    
    UITapGestureRecognizer* sevenRateGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(intoSevenIncomeRate)];
    sevenRateView.userInteractionEnabled = YES;
    [sevenRateView addGestureRecognizer:sevenRateGestureRecognizer];
    
    
    rollOut.userInteractionEnabled = YES;
    UITapGestureRecognizer* rollOutRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rollOut)];
    [rollOut addGestureRecognizer:rollOutRecognizer];
    
    rollIn.userInteractionEnabled = YES;
    UITapGestureRecognizer* rollInRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rollIn)];
    [rollIn addGestureRecognizer:rollInRecognizer];
    // Do any additional setup after loading the view.
}
/*
 *设置渐变背景色
 */
-(void)setTopBackground{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0.f,0.f,mainScreenWidth,280.f);
    gradient.colors = [NSArray arrayWithObjects:
                       (id)theme_light_color.CGColor,
                       (id)theme_color.CGColor,nil];
    topLayout.clipsToBounds = YES;
    [topLayout.layer insertSublayer:gradient atIndex:0];
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
//收益试算
-(void)calculateIncome{
    IncomeRrialViewController* incomeRrialViewController = [[IncomeRrialViewController alloc]init];
    [self.navigationController pushViewController:incomeRrialViewController animated:YES];
}

//收益明细
-(void)incomeDetail{
    IncomeDetailViewController* incomeDetailViewController =(IncomeDetailViewController*)storyboard_controller_identity(@"GigoldTreasureHome", @"incomeDetail");
    incomeDetailViewController.checkType = CheckTypeInCome;
    [self.navigationController pushViewController:incomeDetailViewController animated:YES];
    NSLog(@"incomeDetail");

}
//交易明细
-(void)tradingDetail{
    IncomeDetailViewController* incomeDetailViewController =(IncomeDetailViewController*)storyboard_controller_identity(@"GigoldTreasureHome", @"incomeDetail");
    incomeDetailViewController.checkType = CheckTypeRollInOut;
    [self.navigationController pushViewController:incomeDetailViewController animated:YES];
    
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
- (void)intoSevenIncomeRate{
    NSLog(@"seven");
    SenvenIncomeRateViewController* senvenIncomeRateViewController  = (SenvenIncomeRateViewController*)storyboard_controller_identity(@"GigoldTreasureHome", @"senverIncome");
    senvenIncomeRateViewController.showType = IRShowTypeSeven;
    [self.navigationController pushViewController:senvenIncomeRateViewController animated:YES];
    
}
//进去万分收益查看
- (void)intotenThousandIncome {
    NSLog(@"tenthousand");
    SenvenIncomeRateViewController* senvenIncomeRateViewController  = (SenvenIncomeRateViewController*)storyboard_controller_identity(@"GigoldTreasureHome", @"senverIncome");
    senvenIncomeRateViewController.showType = IRShowTypeTenthousand;
    [self.navigationController pushViewController:senvenIncomeRateViewController animated:YES];}
#pragma mark -UUChart协议
-(CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart{
    return CGRangeMake(12,0);
}
-(CGRange)UUChartMarkRangeInLineChart:(UUChart *)chart{
    return CGRangeZero;
}
-(BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index{
    return YES;
}
-(BOOL)UUChart:(UUChart *)chart ShowMaxMinAtIndex:(NSInteger)index{
    return YES;
}
-(NSArray *)UUChart_ColorArray:(UUChart *)chart{
    return @[theme_color,UURed,UUBrown];
}
-(NSArray *)UUChart_xLableArray:(UUChart *)chart{
    return @[@"10.19",@"10.20",@"10.21",@"10.22",@"10.23",@"10.24",@"10.25"];
}
-(NSArray *)UUChart_yValueArray:(UUChart *)chart{
    return @[@[@"3.4",@"2.4",@"5.4",@"7.4",@"4.4",@"8.4",@"9.0"]];
}
@end
