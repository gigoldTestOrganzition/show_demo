//
//  TradingDetailViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/22.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "TradingDetailViewController.h"
#import "TradingData.h"
#import "TradingCell.h"
#import "MathUtil.h"
#import "TimeUtil.h"

@interface TradingDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    //tableview
    __weak IBOutlet UITableView *tradingTableView;
    //数据
    NSMutableDictionary* datasDic;

}
@end

@implementation TradingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
    self.navigationItem.title = @"交易明细";
    tradingTableView.tableFooterView = [UIView new];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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
//初始化数据
-(void)initDatas{
    TradingData* data = [TradingData new];
    data.type = @"普通转出";
    data.time = @"2015-09-11 12:30:11";
    data.amountData = @"100";
    
    TradingData* data1 = [TradingData new];
    data1.type = @"信用卡还款";
    data1.time = @"2015-09-13 10:30:11";
    data1.amountData = @"110";

    
    TradingData* data2 = [TradingData new];
    data2.type = @"转入";
    data2.time = @"2015-12-13 12:35:11";
    data2.amountData = @"90";

    
    TradingData* data3 = [TradingData new];
    data3.type = @"提现";
    data3.time = @"2015-07-11 12:50:11";
    data3.amountData = @"130";

    
    [self addTradingData:data];
    [self addTradingData:data1];
    [self addTradingData:data2];
    [self addTradingData:data3];
}
//添加数据
-(void)addTradingData:(TradingData*)tradingData{
    if (!datasDic) {
        datasDic = [NSMutableDictionary new];
    }
    NSString* timeKey = [TimeUtil stringToString:tradingData.time sourceFormat:DATA1 toFormat:DATA5];
    NSMutableArray* dataArray = datasDic[timeKey];
    if (!dataArray) {
        dataArray = [NSMutableArray new];
        [datasDic setValue:dataArray forKey:timeKey];
    }
    [dataArray addObject:tradingData];
}

#pragma mark - tableView 协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [datasDic count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray* datasArray = [MathUtil getObjectForNSDictionary:datasDic index:section];
    if (datasArray) {
        return [datasArray count];
    }else{
        return 0;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TradingCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSMutableArray* dataArray = [MathUtil getObjectForNSDictionary:datasDic index:indexPath.section];
    TradingData* data = dataArray[indexPath.row];
    cell.type.text = data.type;
    cell.time.text = data.time;
    cell.amountLable.text = [NSString stringWithFormat:@"%@%@",@"¥",data.amountData];
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [MathUtil getKeyForNSDictionary:datasDic index:section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.f;
}
@end
