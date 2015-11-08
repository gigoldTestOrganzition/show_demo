//
//  OpenGigoldViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/29.
//  Copyright © 2015年 wsc. All rights reserved.
//
//基金介绍
#define DeclarationCell1 @"FundCell"
//风险介绍
#define DeclarationCell2 @"RiskCell"
//时间限制介绍
#define DeclarationCell3 @"TimelimitCell"
//公司介绍
#define DeclarationCell4 @"CompanyCell"
//公告介绍
#define DeclarationCell5 @"NoteCell"

#import "OpenGigoldViewController.h"
#import "GiglodsDeclarationView.h"
#import "GigoldDeclaration.h"
#import "appliacation_attribute.h"
#import "IncomeInstructionViewController.h"
#import "PerfectPersonInformationViewController.h"
#import "appliacation_attribute.h"
#import "SenvenIncomeRateViewController.h"
#import "IncomeRrialViewController.h"
#import "UUChart.h"
#import "OpenGigoldHeadView.h"
#import "OpenGigoldSenvenRateView.h"
#import "ViewUtil.h"
@interface OpenGigoldViewController ()<UITableViewDataSource,UITableViewDelegate,UUChartDataSource>{
    
//    // 万份收益
//    __weak IBOutlet UIView *tenThousandView;
//    //收益试算
//    __weak IBOutlet UIView *incomeCalculateView;
//    //七日年化率
//    __weak IBOutlet UIView *sevenDayRateView;
//    //七日年化率图
//    __weak IBOutlet UIView *sevenRateChartView;
//    UUChart* sevenRateChart;
    
    
    __weak IBOutlet NSLayoutConstraint *topLayoutConstraint;
    
    __weak IBOutlet UITableView *functionTableView;
    //head
    OpenGigoldHeadView* gigoldHeadView;
    //seven rate
    OpenGigoldSenvenRateView* gigoldSevenRateView;
    //数据
    NSMutableArray* datas;
}

@end

@implementation OpenGigoldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
    //nagationitem
    self.navigationItem.title = @"吉有钱";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"收益说明" style:UIBarButtonItemStyleDone target:self action:@selector(incomeInstructions)];
    NSDictionary* attributesDic = [NSDictionary dictionaryWithObjectsAndKeys:main_font,NSFontAttributeName,nil];
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributesDic forState:0];
    topLayoutConstraint.constant = 44.f+STATUSBAR_OFFSET;
    //tableview
    functionTableView.estimatedSectionHeaderHeight = 45.f;
    functionTableView.estimatedRowHeight = 500.f;
    functionTableView.tableFooterView = [UIView new];
    functionTableView.backgroundColor = back_ground_color;
    functionTableView.separatorColor = [UIColor clearColor];
}

#pragma mark -数据初始化
-(void)initDatas{
    if (!datas) {
        datas = [NSMutableArray new];
    }
    
    GigoldDeclaration* dec1 = [GigoldDeclaration new];
    dec1.title = @"基金介绍";
    dec1.type = DeclarationCell1;
    dec1.isLook = NO;
    [datas addObject:dec1];
    
    
    GigoldDeclaration* dec2 = [GigoldDeclaration new];
    dec2.title = @"风险提示";
    dec2.type = DeclarationCell2;
    dec2.isLook = NO;
    [datas addObject:dec2];

    
    GigoldDeclaration* dec3 = [GigoldDeclaration new];
    dec3.title = @"转入转出时间规则";
    dec3.type = DeclarationCell3;
    dec3.isLook = NO;
    [datas addObject:dec3];

    GigoldDeclaration* dec4 = [GigoldDeclaration new];
    dec4.title = @"基金公司介绍";
    dec4.type = DeclarationCell4;
    dec4.isLook = NO;
    [datas addObject:dec4];

    
    GigoldDeclaration* dec5 = [GigoldDeclaration new];
    dec5.title = @"基金公告";
    dec5.type = DeclarationCell5;
    dec5.isLook = NO;
    [datas addObject:dec5];
}

#pragma mark -ui初始化
-(UITableViewCell*)getGigoldHeadView{
    if (!gigoldHeadView) {
        gigoldHeadView = [[NSBundle mainBundle]loadNibNamed:@"OpenGigoldHeadView" owner:nil options:nil][0];
        [ViewUtil registerGestures:gigoldHeadView.tenThousandView target:self action:@selector(intoTenthousand)];
        [ViewUtil registerGestures:gigoldHeadView.incomeCalculate target:self action:@selector(intoIncomeCalculate)];
    }
    return gigoldHeadView;
}
-(UITableViewCell*)getGigoldSevenRatwView{
    if (!gigoldSevenRateView) {
        gigoldSevenRateView = [[[NSBundle mainBundle]loadNibNamed:@"OpenGigoldSenvenRateView" owner:self options:nil]firstObject];
        UUChart* sevenRateChart = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(0.f,0.f,mainScreenWidth-20.f,150.f) withSource:self withStyle:UUChartLineStyle];
        [sevenRateChart showInView:gigoldSevenRateView.sevenRateChartView];
        [ViewUtil registerGestures:gigoldSevenRateView.sevenRateChartView target:self action:@selector(intoServenDayRate)];
    }
    return gigoldSevenRateView;
}
#pragma mark -事件跳转
//收益说明
-(void)incomeInstructions{
    IncomeInstructionViewController* incomeInstructionViewController = (IncomeInstructionViewController*)storyboard_controller_identity(@"GigoldTreasureHome", @"struction");
    [self.navigationController pushViewController:incomeInstructionViewController animated:YES];
}
//进入七日年化率
-(void)intoServenDayRate{
    SenvenIncomeRateViewController* senvenIncomeRateViewController  = (SenvenIncomeRateViewController*)storyboard_controller_identity(@"GigoldTreasureHome", @"senverIncome");
    senvenIncomeRateViewController.showType = IRShowTypeSeven;
    [self.navigationController pushViewController:senvenIncomeRateViewController animated:YES];
}
//进入万分收益
-(void)intoTenthousand{
    SenvenIncomeRateViewController* senvenIncomeRateViewController  = (SenvenIncomeRateViewController*)storyboard_controller_identity(@"GigoldTreasureHome", @"senverIncome");
    senvenIncomeRateViewController.showType = IRShowTypeTenthousand;
    [self.navigationController pushViewController:senvenIncomeRateViewController animated:YES];

}
//进入收益试算
-(void)intoIncomeCalculate{
    IncomeRrialViewController* incomeRrialViewController = [[IncomeRrialViewController alloc]init];
    [self.navigationController pushViewController:incomeRrialViewController animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//立即开通吉有钱
- (IBAction)openGigoldMoney:(id)sender {
    PerfectPersonInformationViewController* perfectPersonInformationViewController = [[PerfectPersonInformationViewController alloc]init];
    [self.navigationController pushViewController:perfectPersonInformationViewController animated:YES];
}

#pragma mark -tableView协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [datas count]+2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section > 1) {
        GigoldDeclaration* gigoldDeclaration = datas[section-2];
        if (gigoldDeclaration.isLook) {
            return 1;
        }else{
            return 0;
        }
    }else{
        return 1;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section > 1) {
        GiglodsDeclarationView* headView = [[[NSBundle mainBundle]loadNibNamed:@"GiglodsDeclaration" owner:nil options:nil] firstObject];
        GigoldDeclaration* declaration = datas[section-2];
        headView.title.text = declaration.title;
        if(declaration.isLook){
            headView.lookImg.image = [UIImage   imageNamed:@"list_open_arrow"];
            headView.lookImg.transform  = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));
            headView.bottomLineLeadingLayoutConstraint.constant = 10.f;
        }else{
            headView.lookImg.image = [UIImage imageNamed:@"list_open_arrow"];
            headView.bottomLineLeadingLayoutConstraint.constant = 0.f;
        }
        headView.tag = section-2;
        UITapGestureRecognizer* lookGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookDeclaration:)];
        headView.userInteractionEnabled = YES;
        [headView addGestureRecognizer:lookGestureRecognizer];
        return headView;
    }else{
        return nil;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = nil;
    if (indexPath.section > 1) {
        GigoldDeclaration* gigoldDeclaration = datas[indexPath.section-2];
        cell = [[[NSBundle mainBundle] loadNibNamed:gigoldDeclaration.type owner:self options:nil] firstObject];
    }else{
        switch (indexPath.section) {
            case 0:{
                cell =  [self getGigoldHeadView];
                
            }
                break;
            case 1:
                cell =  [self getGigoldSevenRatwView];
                
                break;
            default:
                cell =  [self getGigoldHeadView];
                break;
        }

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section > 1) {
        return 45.f;
    }else{
        return 0;
    }
}

/*展开或关闭*/
-(void)lookDeclaration:(id)sender{
    UITapGestureRecognizer* lookGestureRecognizer = sender;
    NSInteger index = lookGestureRecognizer.view.tag;
    GigoldDeclaration* gigoldDeclaration = datas[index];
    gigoldDeclaration.isLook = !gigoldDeclaration.isLook;
    [functionTableView reloadData];
    //[self calculateTableViewHeight];
}
//计算tableview高度
-(void)calculateTableViewHeight{
    CGFloat totalHeight = 0.f;
    for (int section = 0; section < [datas count]; section++) {
        CGFloat sectionHeight = [functionTableView rectForHeaderInSection:section].size.height;
        totalHeight+=sectionHeight;
        
        GigoldDeclaration* gigoldDeclaration = datas[section];
        if (gigoldDeclaration.isLook) {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
            CGFloat rowHeight = [functionTableView rectForRowAtIndexPath:indexPath].size.height;
            totalHeight+=rowHeight;
        }
    }
   //CGFloat addHeightValue = totalHeight-functionTableView.frame.size.height;
   functionTableView.frame = CGRectMake(functionTableView.frame.origin.x, functionTableView.frame.origin.y,functionTableView.frame.size.width,totalHeight);
}
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
