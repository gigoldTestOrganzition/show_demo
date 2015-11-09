//
//  HomeViewController.m
//  gigold
//
//  Created by 单小萍 on 15/11/6.
//  Copyright © 2015年 wsc. All rights reserved.
//
#define LIFE_CELL @"life_cell"
#define BANK_CELL @"bank_cell"
#define AROUND_CELL @"around_cell"
#define ADVERTISING_HEIGHT 120.f
#import "HomeViewController.h"
#import "GigoldDeclaration.h"
#import "HomeAdvertisingView.h"
#import "GiglodsDeclarationView.h"
#import "ViewUtil.h"
#import "AroundData.h"
#import "AroundCell.h"
#import "StringUtil.h"
#import "BankingCell.h"
#import "ViewUtil.h"
#import "RuntimeContext.h"
#import "StringUtil.h"
#import "GigoldTreasureHomeViewController.h"
#import "OpenGigoldViewController.h"
#import "appliacation_attribute.h"
#import "RuntimeContext.h"
#import "UUChart.h"
#import "BillViewController.h"
#import "RuntimeContext.h"
#import "appliacation_attribute.h"
#import "StringUtil.h"
#import "OpenGigoldViewController.h"
#import "GigoldTreasureHomeViewController.h"
#import "TopUpViewController.h"
#import "LifeCell.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,UUChartDataSource>{
    //功能数据
    NSMutableArray* datas;
    NSMutableArray* merchantsDatas;
    __weak IBOutlet NSLayoutConstraint *topLayoutConstraint;
    //首页tableView
    __weak IBOutlet UITableView *homeTableView;
    HomeAdvertisingView* homeAdvertisingView;
    LifeCell* lifeView;
    BankingCell* bankingView;
    
    UIView* titleView;
    UILabel* titleLabel;
    UIImageView* markImg;
}
@end
@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
    [self initUI];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openGiyouqian) name:@"open" object:nil];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
 //self.hidesBottomBarWhenPushed = NO;

}
//开通吉有钱
-(void)openGiyouqian{
    [[RuntimeContext getInstane] putData:@"isOpen" forkey:@"open"];
    [self intoJiyouqian];
}
//初始化数据
-(void)initDatas{
    if (!datas) {
        datas = [[NSMutableArray alloc]init];
    }
    GigoldDeclaration* g1 = [[GigoldDeclaration alloc]init];
    g1.title = @"生活";
    g1.type = LIFE_CELL;
    g1.isLook = NO;
    [datas addObject:g1];
    
    GigoldDeclaration* g2 = [[GigoldDeclaration alloc]init];
    g2.title = @"金融";
    g2.type = BANK_CELL;
    g2.isLook = NO;
    [datas addObject:g2];
    
    GigoldDeclaration* g3 = [[GigoldDeclaration alloc]init];
    g3.title = @"周边";
    g3.type = AROUND_CELL;
    g3.isLook = NO;
    [datas addObject:g3];
    
    
    if (!merchantsDatas) {
        merchantsDatas = [[NSMutableArray alloc]init];
    }
    AroundData* around1 = [[AroundData alloc]init];
    around1.merchantName  = @"重庆千川渔火锅";
    around1.address  = @"德思勤·四季汇购物中心L4-37/38";
    around1.discount = @"9.8折";
    around1.distance = @"100";
    around1.evaluate = @"23";
    around1.sentWay = @"上门";
    [merchantsDatas addObject:around1];
    
    AroundData* around2 = [[AroundData alloc]init];
    around2.merchantName  = @"花果园鲜花水果店";
    around2.address  = @"德思勤城市广场A7-1008商铺";
    around2.discount = @"满50减5 满200减25";
    around2.distance = @"305";
    around2.evaluate = @"332";
    around2.sentWay = @"";
    [merchantsDatas addObject:around2];
    
    AroundData* around3 = [[AroundData alloc]init];
    around3.merchantName  = @"酷琪ktv量贩";
    around3.address  = @"湘府中路117号";
    around3.discount = @"8折";
    around3.distance = @"205";
    around3.evaluate = @"32";
    around3.sentWay = @"快递";
    [merchantsDatas addObject:around3];
    
}
//初始化UI
-(void)initUI{
    self.view.backgroundColor = back_ground_color;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置titleview
    [self setTitleView];
    //设置rightitem
    [self setRightItem];
    [self.view addSubview:[self getHomeAdvertisingView]];
    [homeAdvertisingView loopContent];
    topLayoutConstraint.constant = homeAdvertisingView.frame.size.height+homeAdvertisingView.frame.origin.y;
    homeTableView.estimatedRowHeight = 100.f;
    homeTableView.backgroundColor = back_ground_color;
    homeTableView.separatorColor = white_background_diver_color;
    homeTableView.tableFooterView = [UIView new];
}
-(void)setTitleView{
    titleView = [[UIView alloc]init];
    titleLabel = [[UILabel alloc]init];
    titleLabel.font = title_or_btn_font;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"御溪国际";
    CGFloat titleWidth = [StringUtil getStringWidth:titleLabel.text font:titleLabel.font size:CGSizeMake(mainScreenWidth-80, 44.f)];
    CGFloat titleHeight =  [StringUtil getStringHeight:titleLabel.text font:titleLabel.font size:CGSizeMake(mainScreenWidth-80, 44.f)];
    titleLabel.frame = CGRectMake(0,0,titleWidth,titleHeight);
    [titleView addSubview:titleLabel];
    
    markImg = [[UIImageView alloc]init];
    markImg.image = [UIImage imageNamed:@"top_menu_but_arrow.png"];
    markImg.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width+5.f,titleLabel.center.y-10.f,20,20);
    [titleView addSubview:markImg];
    titleView.frame = CGRectMake(0,0.f,titleWidth+20.f,titleHeight+10);
    UITapGestureRecognizer* selectShowTypeGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectRegion)];
    titleView.userInteractionEnabled = YES;
    [titleView addGestureRecognizer:selectShowTypeGestureRecognizer];
    self.navigationItem.titleView = titleView;
}
/*设置rightitem*/
-(void)setRightItem{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setImage:[UIImage imageNamed:@"main_top_bill_ico"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"main_top_bill_ico"] forState:UIControlStateHighlighted];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -30);
    [btn addTarget:self action:@selector(intoBill) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = item;
}
//进入账单
-(void)intoBill{
    BillViewController* billViewController = [[BillViewController alloc]init];
    [self.navigationController pushViewController:billViewController animated:YES];
}


//选择地区
-(void)selectRegion{
    [self rotatingMarkImg];
}

//旋转指示图标
-(void)rotatingMarkImg{
    static CGFloat transValue = 180;
    markImg.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(transValue));
    transValue+=180;
}
/*
 *获取advertisingView
 */
-(HomeAdvertisingView*)getHomeAdvertisingView{
    if (!homeAdvertisingView){
        homeAdvertisingView = [[HomeAdvertisingView alloc]init];
        [homeAdvertisingView updataFrame:CGRectMake(0.f,44.f+STATUSBAR_OFFSET,mainScreenWidth,ADVERTISING_HEIGHT)];
        homeAdvertisingView.imgArray = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"home_page_banner1.jpg"],[UIImage imageNamed:@"home_page_banner2.jpg"],[UIImage imageNamed:@"home_page_banner3.jpg"],nil];
    }
    return homeAdvertisingView;
}
/*
 * 获取生活信息
 */
-(LifeCell*)getLifeView{
    if (!lifeView) {
        lifeView = [[[NSBundle mainBundle]loadNibNamed:@"life_cell" owner:nil options:nil]firstObject];
        lifeView.businessOwnerNumberView.drawString = @"1123";
        [lifeView.businessOwnerNumberView draw];
       
        lifeView.businessOwnerNumberViewWidthLayoutConstraint.constant = lifeView.businessOwnerNumberView.frame.size.width;
    }
    return lifeView;
}
/*
 *获取bankingView
 */
-(BankingCell*)getBankingView{
    if (!bankingView) {
        bankingView = (BankingCell*)[[NSBundle mainBundle] loadNibNamed:@"bank_cell" owner:nil options:nil][0];
        UUChart* sevenRateChart = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(0.f, 0.f,mainScreenWidth/2-20.f,66.f) withSource:self withStyle:UUChartLineStyle];
        [sevenRateChart showInView:bankingView.rateChartView];

        [ViewUtil registerGestures:bankingView.jiyouqianView target:self action:@selector(intoJiyouqian)];
        [ViewUtil registerGestures:bankingView.smallChangeView target:self action:@selector(intoSmallChange)];
        [ViewUtil registerGestures:bankingView.costView target:self action:@selector(intoCost)];
    }
    return bankingView;
}
//进入吉有钱
-(void)intoJiyouqian{
   NSString* openMark =  [[RuntimeContext getInstane]getData:@"open"];
    if (![StringUtil isEmpty:openMark]) {
        GigoldTreasureHomeViewController* giyouqianViewController = storyboard_controller_identity(@"GigoldTreasureHome", @"home");
       //self.hidesBottomBarWhenPushed=YES;
       [self.navigationController pushViewController:giyouqianViewController animated:YES];
    }else{
        OpenGigoldViewController* openJiyouqianViewController = [[OpenGigoldViewController alloc]init];
        //self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:openJiyouqianViewController animated:YES];
    }
}
//进入零钱
-(void)intoSmallChange{
    TopUpViewController* topViewController = storyboard_controller_identity(@"topUpStoryboard",@"topup");
    [self.navigationController pushViewController:topViewController animated:YES];
    //NSLog(@"intoSmallChange");
}
//进入花费
-(void)intoCost{
     NSLog(@"intoCost");

}
//选择进入不同的tabar选项
-(void)selectTabBar:(id)sender{
   UITapGestureRecognizer* gestureRecognizer = sender;
   NSInteger index = gestureRecognizer.view.tag;
   self.tabBarController.selectedIndex = index;
    
}

#pragma mark -tableview 协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [datas count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == datas.count - 1) {
        return [merchantsDatas count];
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section > 0){
        return 45.f;
    }else{
        return 35.f;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    GiglodsDeclarationView* declarationView = [self getGiglodsDeclarationView];
    if (section > 0) {
        declarationView.topLayoutConstraint.constant = 10.f;
    }else{
        declarationView.topLayoutConstraint.constant = 0.f;
    }
    GigoldDeclaration* gigoldDeclaration = datas[section];
    declarationView.lookImg.image = [UIImage imageNamed:@"home_page_but_arrow.png"];
    declarationView.title.text = gigoldDeclaration.title;
    declarationView.tag = section+1;
    [ViewUtil registerGestures:declarationView target:self action:@selector(selectTabBar:)];
    return declarationView;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GigoldDeclaration* gigoldDeclaration = datas[indexPath.section];
    if (indexPath.section == datas.count-1) {
       AroundCell* aroundCell = [[[NSBundle mainBundle] loadNibNamed:gigoldDeclaration.type owner:nil options:nil]firstObject];
        AroundData* aroundData = merchantsDatas[indexPath.row];
        aroundCell.merchantsName.text = aroundData.merchantName;
        aroundCell.adress.text = aroundData.address;
        aroundCell.disCount.text = aroundData.discount;
        aroundCell.distance.text = [NSString stringWithFormat:@"%@m",aroundData.distance];
        aroundCell.evaluate.text = [NSString stringWithFormat:@"%@评价",aroundData.evaluate];
        if(indexPath.row == merchantsDatas.count-1){
            aroundCell.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
            aroundCell.layoutMargins = UIEdgeInsetsZero;
        }else{
            aroundCell.separatorInset = UIEdgeInsetsMake(0.f, 10.f, 0.f, 0.f);
        }
        return aroundCell;
    }else{
        UITableViewCell* cell;
        switch (indexPath.section) {
            case 0:
                
                cell =  [self getLifeView];
                break;
            case 1:
                cell =  [self getBankingView];
                break;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    return nil;
 }
/*
 *查看
 */
//-(void)look:(id)sender{
//    GiglodsDeclarationView* giglodsDeclarationView =(GiglodsDeclarationView*) ((UITapGestureRecognizer*)sender).view;
//    GigoldDeclaration* gigoldDeclaration = datas[giglodsDeclarationView.tag];
//    gigoldDeclaration.isLook  = !gigoldDeclaration.isLook;
//    [homeTableView reloadData];
//}
/*
 *获取giglodsDeclarationView
 */
-(GiglodsDeclarationView*)getGiglodsDeclarationView{
    GiglodsDeclarationView* giglodsDeclarationView = [[[NSBundle mainBundle] loadNibNamed:@"GiglodsDeclaration" owner:nil options:nil]firstObject];
    return giglodsDeclarationView;
}

#pragma mark - scorrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
if (scrollView == homeTableView) {
    CGFloat y = scrollView.contentOffset.y;
    if (y < 0) {
       [homeAdvertisingView updataFrame:CGRectMake(0.f,44.f+STATUSBAR_OFFSET, mainScreenWidth,ADVERTISING_HEIGHT+ABS(y))];
    }else{
       
        [homeAdvertisingView updataFrame:CGRectMake(0.f,44.f+STATUSBAR_OFFSET,mainScreenWidth,ADVERTISING_HEIGHT)];
    }
}
}

#pragma mark -UUChart协议
-(CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart{
    return CGRangeMake(7,1);
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
    return @[@"19",@"20",@"21",@"22",@"23",@"24",@"25"];
}
-(NSArray *)UUChart_yValueArray:(UUChart *)chart{
    return @[@[@"1.4",@"2.4",@"3.4",@"4.4",@"5.4",@"6",@"6.4"]];
}

@end
