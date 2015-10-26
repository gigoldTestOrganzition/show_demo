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

@interface SenvenIncomeRateViewController ()<UITableViewDataSource,UITableViewDelegate>{

    __weak IBOutlet UITableView *senvenIncomeRateTableView;
    
    NSMutableArray* datas;
}
@end

@implementation SenvenIncomeRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
    self.navigationItem.title=@"七年内年化收益率";
    senvenIncomeRateTableView.tableFooterView = [UIView new];
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
//数据初始化
-(void)initDatas{
    if (!datas) {
        datas = [NSMutableArray new];
    }
    SenvenIncomeRateData* data = [SenvenIncomeRateData new];
    data.time=@"2015-08-01";
    data.rate = @"20";
    
    SenvenIncomeRateData* data1 = [SenvenIncomeRateData new];
    data1.time=@"2014-04-01";
    data1.rate = @"20";
    
    SenvenIncomeRateData* data2 = [SenvenIncomeRateData new];
    data2.time=@"2012-08-09";
    data2.rate = @"20";
    
    SenvenIncomeRateData* data3 = [SenvenIncomeRateData new];
    data3.time=@"2015-09-01";
    data3.rate = @"20";
    
    SenvenIncomeRateData* data4 = [SenvenIncomeRateData new];
    data4.time=@"2015-11-15";
    data4.rate = @"20";
    
    SenvenIncomeRateData* data5 = [SenvenIncomeRateData new];
    data5.time=@"2015-06-28";
    data5.rate = @"20";
    
    [datas addObject:data];
    [datas addObject:data1];

    [datas addObject:data2];

    [datas addObject:data3];

    [datas addObject:data4];

    [datas addObject:data5];

}
#pragma mark -tableview 协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [datas count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SenvenIncomeRateCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    SenvenIncomeRateData* data = datas[indexPath.row];
    cell.time.text = data.time;
    cell.rate.text = [NSString stringWithFormat:@"%@%@",data.rate,@"%"];
    return cell;
}
@end
