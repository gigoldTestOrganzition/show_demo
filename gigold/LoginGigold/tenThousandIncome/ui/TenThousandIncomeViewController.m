//
//  TenThousandIncomeViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "TenThousandIncomeViewController.h"
#import "TenThousandCell.h"
#import "TenThousandData.h"

@interface TenThousandIncomeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    //万份收益
    __weak IBOutlet UITableView *tenThousandTableView;
    //数据
    NSMutableArray* datas;
}
@end

@implementation TenThousandIncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"万份收益";
    tenThousandTableView.tableFooterView = [UIView new];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化
-(void)initDatas{
    if (!datas) {
        datas = [NSMutableArray new];
    }
    TenThousandData* data = [TenThousandData new];
    data.time = @"2015-09-08";
    data.amountData = @"101";
    TenThousandData* data1 = [TenThousandData new];
    data1.time = @"2015-02-08";
    data1.amountData = @"500";
    TenThousandData* data2 = [TenThousandData new];
    data2.time = @"2015-11-08";
    data2.amountData = @"250";
    TenThousandData* data3 = [TenThousandData new];
    data3.time = @"2014-09-08";
    data3.amountData = @"200";
    TenThousandData* data4 = [TenThousandData new];
    data4.time = @"2015-03-01";
    data4.amountData = @"25";
    TenThousandData* data5 = [TenThousandData new];
    data5.time = @"2015-07-06";
    data5.amountData = @"35";
    TenThousandData* data6 = [TenThousandData new];
    data6.time = @"2015-10-08";
    data6.amountData = @"71";
    
    [datas addObject:data];
    [datas addObject:data1];
    [datas addObject:data2];
    [datas addObject:data3];
    [datas addObject:data4];
    [datas addObject:data5];
    [datas addObject:data6];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -tableView协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [datas count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TenThousandCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    TenThousandData* data = datas[indexPath.row];
    cell.time.text = data.time;
    cell.amountLable.text = [NSString stringWithFormat:@"%@%@",@"¥",data.amountData];
    return cell;
}
@end
