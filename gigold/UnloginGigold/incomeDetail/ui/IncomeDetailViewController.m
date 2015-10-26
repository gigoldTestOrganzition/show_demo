//
//  IncomeDetailViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/22.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "IncomeDetailViewController.h"
#import "IncomeDetailCell.h"
#import "IncomeDetailData.h"
@interface IncomeDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    __weak IBOutlet UITableView *incomeDetailTableView;
    NSMutableArray* datas;
}

@end

@implementation IncomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.navigationItem.title=@"收益明细";
    incomeDetailTableView.tableFooterView = [UIView new];
    // Do any additional setup after loading the view.
}
//数据初始化
-(void)initData{
    datas = [NSMutableArray new];
    IncomeDetailData* data = [IncomeDetailData new];
    data.timeStr = @"2015-02-12";
    data.amountStr = @"100";
    
    IncomeDetailData* data2 = [IncomeDetailData new];
    data2.timeStr = @"2015-03-12";
    data2.amountStr = @"200";
    
    IncomeDetailData* data3 = [IncomeDetailData new];
    data3.timeStr = @"2015-05-11";
    data3.amountStr = @"1400";
    
    IncomeDetailData* data4 = [IncomeDetailData new];
    data4.timeStr = @"2015-05-12";
    data4.amountStr = @"200";
    
    IncomeDetailData* data5 = [IncomeDetailData new];
    data5.timeStr = @"2015-07-12";
    data5.amountStr = @"50";
    
    IncomeDetailData* data6 = [IncomeDetailData new];
    data6.timeStr = @"2015-08-12";
    data6.amountStr = @"80";
    [datas addObject:data];
    [datas addObject:data2];
    [datas addObject:data3];
    [datas addObject:data4];
    [datas addObject:data5];
    [datas addObject:data6];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [datas count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IncomeDetailCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    IncomeDetailData* data = datas[indexPath.row];
    cell.timeLable.text = data.timeStr;
    cell.amountLable.text = data.amountStr;
    return cell;
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
