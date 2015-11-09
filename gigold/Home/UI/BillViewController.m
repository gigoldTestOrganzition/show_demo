//
//  BillViewController.m
//  gigold
//
//  Created by 单小萍 on 15/11/9.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BillViewController.h"
#import "Order.h"
#import "OrderlCell.h"
#import "RollOutDetailViewController.h"
#import "appliacation_attribute.h"
@interface BillViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray* billDatas;
    __weak IBOutlet UITableView *billTableView;
}
@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账单详情";
    [self initBills];
    
    billTableView.estimatedRowHeight = 60.f;
    billTableView.tableFooterView = [UIView new];
    billTableView.backgroundColor = back_ground_color;
    billTableView.separatorColor = white_background_diver_color;
    UINib * nib = [UINib nibWithNibName:@"OrderCell" bundle:nil];
    [billTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    // Do any additional setup after loading the view from its nib.
}
//初始化数据
-(void)initBills{
    if (!billDatas) {
        billDatas = [[NSMutableArray alloc]init];
    }
    Order* order1 = [[Order alloc]init];
    order1.orderType = OrderTypeProperty;
    order1.timeStr = @"2015-10-11 12:30:11";
    order1.desc = @"等待付款";
    order1.amountStr = @"100";
    order1.rollFlowProcess = RollFlowProcessStart;
    [billDatas addObject:order1];
    
    Order* order2 = [[Order alloc]init];
    order2.orderType = OrderTypeStopCarfees;
    order2.timeStr = @"2015-09-15 12:30:11";
    //order2.desc = @"等待付款";
    order2.amountStr = @"200";
    order2.rollFlowProcess = RollFlowProcessEnd;
    [billDatas addObject:order2];
    
    
    Order* order3 = [[Order alloc]init];
    order3.orderType = OrderTypeElectricityfees;
    order3.timeStr = @"2015-11-23 08:25:11";
    //order3.desc = @"等待付款";
    order3.amountStr = @"58";
    order3.rollFlowProcess = RollFlowProcessStart;
    [billDatas addObject:order3];
    
    
    Order* order4 = [[Order alloc]init];
    order4.orderType = OrderTypeWaterfees;
    order4.timeStr = @"2015-06-09 09:13:27";
    //order4.desc = @"等待付款";
    order4.amountStr = @"47";
    order4.rollFlowProcess = RollFlowProcessEnd;
    [billDatas addObject:order4];
    
    Order* order5 = [[Order alloc]init];
    order5.orderType = OrderTypeTransferAccounts;
    order5.timeStr = @"2015-12-13 15:37:46";
    //order5.desc = @"等待付款";
    order5.amountStr = @"100";
    order5.rollFlowProcess = RollFlowProcessStart;
    [billDatas addObject:order5];
}
#pragma mark -uitableview 协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return billDatas.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        OrderlCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        Order* data = billDatas[indexPath.row];
        cell.orderType.text = [Order getOrderTypeDesc:data.orderType];
        if (data.desc) {
            cell.timeLable.text = data.desc;
            cell.timeLable.textColor = status_dec_yellow_color;
        }else{
            cell.timeLable.textColor = white_auxiliary_color;
            cell.timeLable.text = data.timeStr;
        }
        cell.amountLable.textColor = [self getAmountColor:data.orderType];
        cell.amountLable.text = [self getAmountDesc:data.orderType amount:data.amountStr];
        if (data.orderType == OrderTypeIncome) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == billDatas.count - 1) {
        cell.layoutMargins = cell.separatorInset = UIEdgeInsetsZero;
    }else{
        cell.layoutMargins = cell.separatorInset = UIEdgeInsetsMake(0.f,10.f,0.f,0.f);
    }
    return cell;
}
//获得订单金额描述
-(NSString*)getAmountDesc:(OrderType)orderType amount:(NSString*)amountStr{
    switch (orderType) {
        case OrderTypeIncome:
        case OrderTypeFastRollIn:
        case OrderTypeNomalRollIn:
        case OrderTypeTransferAccounts:
             return [NSString stringWithFormat:@"+%@",amountStr];
        case OrderTypeFastRollOut:
        case OrderTypeNomalRollOut:
        case OrderTypeProperty:
        case OrderTypeStopCarfees:
        case OrderTypeElectricityfees:
        case OrderTypeWaterfees:
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
        case OrderTypeTransferAccounts:
            return theme_color;
        case OrderTypeFastRollOut:
        case OrderTypeNomalRollOut:
        case OrderTypeProperty:
        case OrderTypeStopCarfees:
        case OrderTypeElectricityfees:
        case OrderTypeWaterfees:
            return warning_red_color;
    }
    return theme_color;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Order* order = billDatas[indexPath.row];
    [self intoDetail:order];
}
/*
 *进入详情
 */
-(void)intoDetail:(Order*)order{
    RollOutDetailViewController* rollOutDetailViewController = storyboard_controller_identity(@"GigoldTreasureHome", @"rollOutDetail");
    rollOutDetailViewController.order = order;
    [self.navigationController pushViewController:rollOutDetailViewController animated:YES];
}
@end
