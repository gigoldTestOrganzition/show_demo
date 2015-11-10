//
//  SenvenIncomeRateViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "SenvenIncomeRateViewController.h"
#import "SenvenIncomeRateCell.h"
#import "SenvenIncomeRateData.h"
#import "CustomerProgressLableView.h"
#import "StringUtil.h"
#import "MathUtil.h"
#import "CustomerView.h"
@interface SenvenIncomeRateViewController ()<UITableViewDataSource,UITableViewDelegate>{

    __weak IBOutlet UITableView *senvenIncomeRateTableView;
    
    __weak IBOutlet UILabel *desc;
    
    __weak IBOutlet UILabel *totalIncome;
    
    UIView* contentView;
    UILabel* titleLable;
    UIImageView* markImg;
    
    UITableView* selectShowTypeTableView;
    NSMutableDictionary* selectShowTypeDic;
    CustomerView* showTypeDialog;
    
    NSMutableArray* datas;
    
    
    
}
@end

@implementation SenvenIncomeRateViewController
@synthesize showType=_showType;
- (void)viewDidLoad {
    [super viewDidLoad];
    //分类型设置数据
    [self creatContentView];
    [self initDatas];
    [self calculateIncome];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //tableview
    senvenIncomeRateTableView.tableFooterView = [UIView new];
    senvenIncomeRateTableView.separatorColor = back_ground_color;
    senvenIncomeRateTableView.backgroundColor = back_ground_color;
    // Do any additional setup after loading the view.
}

-(void)creatSelectShowTypeTableView{
    if (!selectShowTypeTableView) {
        selectShowTypeDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"七日年化收益率",@"ico_statement_4",@"万份收益",@"ico_statement_5",nil];
        selectShowTypeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, mainScreenWidth,87.f)];
        selectShowTypeTableView.delegate = self;
        selectShowTypeTableView.dataSource = self;
        selectShowTypeTableView.tableFooterView = [UIView new];
        selectShowTypeTableView.scrollEnabled = NO;
        
    }
  
}

//创建显示titleView
-(void)creatContentView{
    if (!contentView) {
        contentView = [[UIView alloc]init];
        titleLable = [[UILabel alloc]init];
        titleLable.font = title_or_btn_font;
        titleLable.textColor = [UIColor whiteColor];
        switch (_showType) {
            case IRShowTypeSeven:{
                desc.text = @"近一月平均收益率";
                titleLable.text = @"七日年化收益率";
            }
                break;
            case IRShowTypeTenthousand:{
                desc.text = @"近一月平均万分收益（元）";
                titleLable.text = @"万分收益";
            }
            break;
        }
        CGFloat titleWidth = [StringUtil getStringWidth:titleLable.text font:titleLable.font size:CGSizeMake(mainScreenWidth-80, 44.f)];
        CGFloat titleHeight =  [StringUtil getStringHeight:titleLable.text font:titleLable.font size:CGSizeMake(mainScreenWidth-80, 44.f)];
        titleLable.frame = CGRectMake(0,0,titleWidth,titleHeight);
        [contentView addSubview:titleLable];
        
        markImg = [[UIImageView alloc]init];
        markImg.image = [UIImage imageNamed:@"top_menu_but_arrow.png"];
        markImg.frame = CGRectMake(titleLable.frame.origin.x+titleLable.frame.size.width+5.f,titleLable.center.y-10.f,20,20);
        [contentView addSubview:markImg];
        contentView.frame = CGRectMake(0,0.f,titleWidth+20.f,titleHeight+10);
        UITapGestureRecognizer* selectShowTypeGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectShowType)];
        contentView.userInteractionEnabled = YES;
        [contentView addGestureRecognizer:selectShowTypeGestureRecognizer];
        self.navigationItem.titleView = contentView;
    }

}
//选择查看类型
-(void)selectShowType{
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
        [showTypeDialog showDialogByBaseLine:0.f view:self.view];
    }

}
//旋转指示图标
-(void)rotatingMarkImg{
    static CGFloat transValue = 180;
    [self creatContentView];
    markImg.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(transValue));
    transValue+=180;
}
//改变标题
-(void)changeTitleStr{
    [self creatContentView];
    switch (_showType) {
        case IRShowTypeSeven:{
            desc.text = @"近一月平均收益率";
            titleLable.text = @"七日年化收益率";
        }
        break;
        case IRShowTypeTenthousand:{
            desc.text = @"近一月平均万分收益（元）";
            titleLable.text = @"万分收益";
        }
        break;
    }
    CGFloat titleWidth = [StringUtil getStringWidth:titleLable.text font:titleLable.font size:CGSizeMake(mainScreenWidth-80, 44.f)];
    CGFloat titleHeight =  [StringUtil getStringHeight:titleLable.text font:titleLable.font size:CGSizeMake(mainScreenWidth-80, 44.f)];
    titleLable.frame = CGRectMake(0,0,titleWidth,titleHeight);
    

    markImg.frame = CGRectMake(titleLable.frame.origin.x+titleLable.frame.size.width+5.f,titleLable.center.y-10.f,20,20);
    contentView.frame = CGRectMake(0.f,0.f,titleWidth+20.f,titleHeight+5);
    self.navigationItem.titleView = nil;
    self.navigationItem.titleView = contentView;
    
}

// 设置显示数据
-(void)setShowTypeData{
    [self changeTitleStr];
    [self rotatingMarkImg];
    [self initDatas];
    [self calculateIncome];
}
//计算收益
-(void)calculateIncome{
    CGFloat total = 0.f;
    for (SenvenIncomeRateData* data in datas) {
        total += data.rate;
    }
    totalIncome.text = [NSString stringWithFormat:@"%lf%@",total,@"%"];
}


//数据初始化
-(void)initDatas{
    if (!datas) {
        datas = [NSMutableArray new];
    }
    SenvenIncomeRateData* data = [SenvenIncomeRateData new];
    data.time=@"2015-08-01";
    data.rate = 3.9;
    
    SenvenIncomeRateData* data1 = [SenvenIncomeRateData new];
    data1.time=@"2014-04-01";
    data1.rate = 2.48;
    
    SenvenIncomeRateData* data2 = [SenvenIncomeRateData new];
    data2.time=@"2012-08-09";
    data2.rate = 3.48;
    
    SenvenIncomeRateData* data3 = [SenvenIncomeRateData new];
    data3.time=@"2015-09-01";
    data3.rate = 2.748;
    
    SenvenIncomeRateData* data4 = [SenvenIncomeRateData new];
    data4.time=@"2015-11-15";
    data4.rate = 2.548;
    
    SenvenIncomeRateData* data5 = [SenvenIncomeRateData new];
    data5.time=@"2015-06-28";
    data5.rate = 3.048;
    
    [datas addObject:data];
    [datas addObject:data1];

    [datas addObject:data2];

    [datas addObject:data3];

    [datas addObject:data4];

    [datas addObject:data5];
}

#pragma mark -tableview 协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == selectShowTypeTableView) {
        return 1;
    }else{
        return [datas count];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView != selectShowTypeTableView) {
        return 10.f;
    }else{
        return 0;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView!= selectShowTypeTableView) {
        UIView* headView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f,mainScreenWidth-20.f, 10.f)];
        headView.backgroundColor = back_ground_color;
        return headView;
    }else{
        return  nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == selectShowTypeTableView) {
        return [selectShowTypeDic count];
    }else{
        return 1;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == selectShowTypeTableView) {
        
        UITableViewCell* showTypeCell = [tableView dequeueReusableCellWithIdentifier:@"showCell"];
        if (!showTypeCell) {
            showTypeCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"showCell"];
        }
        NSString* key = [MathUtil getKeyForNSDictionary:selectShowTypeDic index:indexPath.row];
        NSString* value = [MathUtil getObjectForNSDictionary:selectShowTypeDic index:indexPath.row];
        showTypeCell.imageView.image = [UIImage imageNamed:key];
        showTypeCell.textLabel.text = value;
        showTypeCell.textLabel.textColor = main_text_color;
        showTypeCell.textLabel.font = main_font;
        showTypeCell.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
        return showTypeCell;
    }else{
        CustomerProgressLableView* cell = [[CustomerProgressLableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth-20.f,35.f)];
        SenvenIncomeRateData* data = datas[indexPath.section];
        if (indexPath.section == 0) {
            cell.progressColor = theme_color;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftlabelStr = data.time;
        cell.progressValue = data.rate;
        cell.maxValue = 4.0f;
        [cell drawProgress];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == selectShowTypeTableView) {
        [showTypeDialog stopDialog];
        switch (indexPath.row) {
            case 0:
                self.showType = IRShowTypeSeven;
                break;
                
            case 1:
                self.showType = IRShowTypeTenthousand;
                break;
        }
        [self setShowTypeData];
    }
}

@end
