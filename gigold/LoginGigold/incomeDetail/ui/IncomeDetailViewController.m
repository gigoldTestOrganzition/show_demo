//
//  IncomeDetailViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/22.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "IncomeDetailViewController.h"
#import "OrderlCell.h"
#import "Order.h"
#import "StringUtil.h"
#import "CustomerView.h"
#import "MathUtil.h"
#import "appliacation_attribute.h"
#import "RollInDetailViewController.h"
#import "RollOutDetailViewController.h"
@interface IncomeDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    //数据
    NSMutableArray* allDatas;
    NSMutableArray* currenDatas;
    NSString* titleStr;
    //视图
    __weak IBOutlet UIView *incomeView;
    
    __weak IBOutlet UITableView *incomeDetailTableView;
    
    UIView* contentView;
    UILabel* titleLable;
    UIImageView* markImg;
    
    UITableView* selectShowTypeTableView;
    NSMutableArray* titleArray;
    NSMutableArray* imageArray;
    CustomerView* showTypeDialog;
    
    
    __weak IBOutlet NSLayoutConstraint *tableViewTotopLayoutConstraint;
    
    __weak IBOutlet NSLayoutConstraint *tableViewToincomeLayoutConstraint;
}

@end

@implementation IncomeDetailViewController
@synthesize checkType=_checkType;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCurrentDatas];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatContentView];
    incomeDetailTableView.tableFooterView = [UIView new];
    // Do any additional setup after loading the view.
}
//数据初始化
-(void)initData{
    allDatas = [NSMutableArray new];
    Order* data = [Order new];
    data.timeStr = @"2015-02-12 12:34:11";
    data.amountStr = @"100";
    data.orderType = OrderTypeNomalRollIn;
    data.rollFlowProcess = RollFlowProcessStart;
    
    Order* data2 = [Order new];
    data2.timeStr = @"2015-03-12 11:34:11";
    data2.amountStr = @"200";
    data2.orderType = OrderTypeNomalRollIn;
    data2.rollFlowProcess = RollFlowProcessEnd;
    
    
    Order* data3 = [Order new];
    data3.timeStr = @"2015-05-11 10:34:11";
    data3.amountStr = @"1400";
    data3.orderType = OrderTypeFastRollOut;
    data3.rollFlowProcess = RollFlowProcessStart;
    
    Order* data4 = [Order new];
    data4.timeStr = @"2015-05-12 12:54:11";
    data4.amountStr = @"200";
    data4.orderType = OrderTypeIncome;
    
    Order* data5 = [Order new];
    data5.timeStr = @"2015-07-12 09:34:11";
    data5.amountStr = @"50";
    data5.orderType = OrderTypeFastRollIn;
    data5.rollFlowProcess = RollFlowProcessCalculate;
    
    Order* data6 = [Order new];
    data6.timeStr = @"2015-08-12 08:34:11";
    data6.amountStr = @"80";
    data6.orderType = OrderTypeIncome;
    
    
    Order* data7 = [Order new];
    data7.timeStr = @"2015-08-12 05:34:01";
    data7.amountStr = @"80";
    data7.orderType = OrderTypeFastRollIn;
    data7.rollFlowProcess = RollFlowProcessCalculate;

    
    Order* data8 = [Order new];
    data8.timeStr = @"2015-08-12 07:34:11";
    data8.amountStr = @"80";
    data8.orderType = OrderTypeNomalRollOut;
    data8.rollFlowProcess = RollFlowProcessEnd;

    
    Order* data9 = [Order new];
    data9.timeStr = @"2015-08-12 12:03:11";
    data9.amountStr = @"80";
    data9.orderType = OrderTypeIncome;

    
    Order* data10 = [Order new];
    data10.timeStr = @"2015-08-12 02:34:11";
    data10.amountStr = @"80";
    data10.orderType = OrderTypeFastRollOut;
    data10.rollFlowProcess = RollFlowProcessEnd;

    [allDatas addObject:data];
    [allDatas addObject:data2];
    [allDatas addObject:data3];
    [allDatas addObject:data4];
    [allDatas addObject:data5];
    [allDatas addObject:data6];
    [allDatas addObject:data7];
    [allDatas addObject:data8];
    [allDatas addObject:data9];
    [allDatas addObject:data10];
}
/*
 *获得当前datas
 */
-(void)getCurrentDatas{
    if (!allDatas) {
        [self initData];
    }
    if (!currenDatas) {
        currenDatas = [NSMutableArray new];
    }
    [currenDatas removeAllObjects];
    for (Order* order in allDatas){
        switch (_checkType) {
            case CheckTypeRollIn:
                if (order.orderType == OrderTypeFastRollIn||order.orderType == OrderTypeNomalRollIn) {
                    [currenDatas addObject:order];
                }
                break;
                
            case CheckTypeRollOut:
                if (order.orderType == OrderTypeFastRollOut||order.orderType == OrderTypeNomalRollOut) {
                    [currenDatas addObject:order];
                }
                
                break;
            case CheckTypeRollInOut:
                if (order.orderType == OrderTypeFastRollOut||order.orderType == OrderTypeNomalRollOut||order.orderType == OrderTypeFastRollIn||order.orderType == OrderTypeNomalRollIn) {
                    [currenDatas addObject:order];
                }

                break;
            case CheckTypeInCome:
                if (order.orderType == OrderTypeIncome) {
                    [currenDatas addObject:order];
                }
                break;
        }
    }
}
/*
 *收益隐藏操作
 */
-(void)setIncomeViewhidden:(BOOL)hidden{
    incomeView.hidden = hidden;
    if (hidden) {
        tableViewTotopLayoutConstraint.priority = 750;
        tableViewToincomeLayoutConstraint.priority = 250;
    }else{
        tableViewTotopLayoutConstraint.priority = 250;
        tableViewToincomeLayoutConstraint.priority = 750;
    }

}
/*
 *获取枚举描述
 */
-(NSString*)getOrderDesc:(OrderType)orderType{
    switch (orderType) {
        case OrderTypeNomalRollIn:
            return @"普通转入";
        case OrderTypeFastRollIn:
            return @"快速转入";
        case OrderTypeNomalRollOut:
            return @"普通转出";
        case OrderTypeFastRollOut:
            return @"快速转出";
        case OrderTypeIncome:
            return @"收益";
    }
    return @"";
}
/*
 *设置查看类型
 */
-(void)setCheckType:(CheckType)checkType{
    _checkType = checkType;
    switch (_checkType) {
        case CheckTypeRollIn:
            titleStr = @"转入";
            [self setIncomeViewhidden:YES];
            break;
        case CheckTypeRollOut:
            titleStr = @"转出";
            [self setIncomeViewhidden:YES];
            break;
        case CheckTypeRollInOut:
            titleStr = @"转入转出";
            [self setIncomeViewhidden:YES];
            break;
        case CheckTypeInCome:
            titleStr = @"收益明细";
            [self setIncomeViewhidden:NO];
            break;
    }
}
//创建显示titleView
-(void)creatContentView{
    if (!contentView) {
        contentView = [[UIView alloc]init];
        titleLable = [[UILabel alloc]init];
        titleLable.font = title_or_btn_font;
        titleLable.textColor = [UIColor whiteColor];
        titleLable.text = titleStr;
        CGFloat titleWidth = [StringUtil getStringWidth:titleLable.text font:titleLable.font size:CGSizeMake(mainScreenWidth-80, 44.f)];
        CGFloat titleHeight =  [StringUtil getStringHeight:titleLable.text font:titleLable.font size:CGSizeMake(mainScreenWidth-80, 44.f)];
        titleLable.frame = CGRectMake(0,0,titleWidth,titleHeight);
        [contentView addSubview:titleLable];
        
        markImg = [[UIImageView alloc]init];
        markImg.image = [UIImage imageNamed:@"top_menu_but_arrow.png"];
        markImg.frame = CGRectMake(titleLable.frame.origin.x+titleLable.frame.size.width+5.f,titleLable.center.y-10.f,20,20);
        [contentView addSubview:markImg];
        contentView.frame = CGRectMake(0,0.f,titleWidth+20.f,titleHeight+10);
        UITapGestureRecognizer* selectShowTypeGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectCheckType)];
        contentView.userInteractionEnabled = YES;
        [contentView addGestureRecognizer:selectShowTypeGestureRecognizer];
        self.navigationItem.titleView = contentView;
    }
    
}

//改变标题
-(void)changeTitleItem{
    [self creatContentView];
    titleLable.text = titleStr;
    CGFloat titleWidth = [StringUtil getStringWidth:titleLable.text font:titleLable.font size:CGSizeMake(mainScreenWidth-80, 44.f)];
    CGFloat titleHeight =  [StringUtil getStringHeight:titleLable.text font:titleLable.font size:CGSizeMake(mainScreenWidth-80, 44.f)];
    titleLable.frame = CGRectMake(0,0,titleWidth,titleHeight);
    markImg.frame = CGRectMake(titleLable.frame.origin.x+titleLable.frame.size.width+5.f,titleLable.center.y-10.f,20,20);
    contentView.frame = CGRectMake(0.f,0.f,titleWidth+20.f,titleHeight+5);
    self.navigationItem.titleView = nil;
    self.navigationItem.titleView = contentView;
    
}

//旋转指示图标
-(void)rotatingMarkImg{
    [self creatContentView];
    static CGFloat transValue = 180;
    markImg.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(transValue));
    transValue+=180;
}

-(void)creatSelectShowTypeTableView{
    if (!selectShowTypeTableView) {
        titleArray = [[NSMutableArray alloc]
                  initWithObjects:@"转入转出",@"转出",@"转入",@"收益明细",nil];
        imageArray = [[NSMutableArray alloc]initWithObjects:@"ico_statement_6",@"ico_statement_3",@"ico_statement_2",@"ico_statement_1",nil];
        selectShowTypeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, mainScreenWidth,174.f)];
        selectShowTypeTableView.delegate = self;
        selectShowTypeTableView.dataSource = self;
        selectShowTypeTableView.tableFooterView = [UIView new];
        selectShowTypeTableView.scrollEnabled = NO;
    }
    
}

//选择查看类型
-(void)selectCheckType{
    if (!showTypeDialog) {
        showTypeDialog = [[CustomerView alloc]init];
        [self creatSelectShowTypeTableView];
        showTypeDialog.showView = selectShowTypeTableView;
        showTypeDialog.pullStyle = PullViewTop;
    }
    [self rotatingMarkImg];
    if ([showTypeDialog isShow]) {
        [showTypeDialog stopDialog];
    }else{
        [showTypeDialog showDialogByBaseLine:44.f+STATUSBAR_OFFSET view:self.view];
    }
}


#pragma mark - UITableView 协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == selectShowTypeTableView) {
        return [titleArray count];
    }else{
        return [currenDatas count];
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == selectShowTypeTableView) {
        
        UITableViewCell* showTypeCell = [tableView dequeueReusableCellWithIdentifier:@"showCell"];
        if (!showTypeCell) {
            showTypeCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"showCell"];
        }
        
        showTypeCell.imageView.image = [UIImage imageNamed:imageArray[indexPath.row]];
        showTypeCell.textLabel.text = titleArray[indexPath.row];
        showTypeCell.textLabel.textColor = main_text_color;
        showTypeCell.textLabel.font = main_font;
        showTypeCell.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
        return showTypeCell;
    }else{
        OrderlCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        Order* data = currenDatas[indexPath.row];
        cell.orderType.text = [self getOrderDesc:data.orderType];
        cell.timeLable.text = data.timeStr;
        cell.amountLable.textColor = [self getAmountColor:data.orderType];
        cell.amountLable.text = [self getAmountDesc:data.orderType amount:data.amountStr];
        if (data.orderType == OrderTypeIncome) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }
}
//获得订单金额描述
-(NSString*)getAmountDesc:(OrderType)orderType amount:(NSString*)amountStr{
    switch (orderType) {
        case OrderTypeIncome:
        case OrderTypeFastRollIn:
        case OrderTypeNomalRollIn:
            return [NSString stringWithFormat:@"+%@",amountStr];
        case OrderTypeFastRollOut:
        case OrderTypeNomalRollOut:
            return [NSString stringWithFormat:@"-%@",amountStr];
    }
    return amountStr;
}
/*
 *获得金额颜色
 */
-(UIColor*)getAmountColor:(OrderType)orderType{
    switch (orderType) {
        case OrderTypeIncome:
        case OrderTypeFastRollIn:
        case OrderTypeNomalRollIn:
            return theme_color;
        case OrderTypeFastRollOut:
        case OrderTypeNomalRollOut:
            return warning_red_color;
    }
    return theme_color;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == selectShowTypeTableView) {
        [showTypeDialog stopDialog];
        switch (indexPath.row){
            case 0:
                self.checkType = CheckTypeRollInOut;
                break;
                
            case 1:
                self.checkType = CheckTypeRollOut;
                break;
            case 2:
                self.checkType = CheckTypeRollIn;
                break;
            case 3:
                self.checkType = CheckTypeInCome;
                break;
        }
        [self changeTitleItem];
        [self rotatingMarkImg];
        [self getCurrentDatas];
        [incomeDetailTableView reloadData];
    }else{
        Order* order = currenDatas[indexPath.row];
        if (order.orderType!=OrderTypeIncome) {
            [self intoDetail:order];
        }
    }
}
/*
 *进入详情
 */
-(void)intoDetail:(Order*)order{
    switch (order.orderType) {
        case OrderTypeFastRollIn:
        case OrderTypeNomalRollIn:{
            RollInDetailViewController* rollInDetailViewController = storyboard_controller_identity(@"GigoldTreasureHome",@"rollInDetail");
            rollInDetailViewController.order=order;
            [self.navigationController pushViewController:rollInDetailViewController animated:YES];
        }
        break;
        case OrderTypeFastRollOut:
        case OrderTypeNomalRollOut:{
            RollOutDetailViewController* rollOutDetailViewController = storyboard_controller_identity(@"GigoldTreasureHome", @"rollOutDetail");
            rollOutDetailViewController.order = order;
            [self.navigationController pushViewController:rollOutDetailViewController animated:YES];
        }
        case OrderTypeIncome:
        break;
    }
}


@end
