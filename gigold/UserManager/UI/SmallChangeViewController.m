//
//  SmallChangeViewController.m
//  gigold
//
//  Created by wsc on 15/10/27.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "SmallChangeViewController.h"
#import "SmallChangeTableViewCell.h"

@interface SmallChangeViewController ()

@end

@implementation SmallChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收支明细";
    
    NSDictionary* dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"2015-10-10",@"time",@"账户充值",@"style",@"80",@"smallChange",@"+80",@"money", nil];
    NSDictionary* dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"2015-10-11",@"time",@"账户充值",@"style",@"160",@"smallChange",@"+80",@"money", nil];
    NSDictionary* dict3 = [NSDictionary dictionaryWithObjectsAndKeys:@"2015-10-12",@"time",@"账户充值",@"style",@"360",@"smallChange",@"+200",@"money", nil];
    NSDictionary* dict4 = [NSDictionary dictionaryWithObjectsAndKeys:@"2015-10-13",@"time",@"提现",@"style",@"260",@"smallChange",@"-100",@"money", nil];
    NSDictionary* dict5 = [NSDictionary dictionaryWithObjectsAndKeys:@"2015-10-15",@"time",@"商品消费",@"style",@"140",@"smallChange",@"-120",@"money", nil];
    
    dataArray = [[NSMutableArray alloc] initWithObjects:dict5,dict4,dict3,dict2,dict1, nil];
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    self.noneView.hidden = YES;
    self.mTableView.hidden = NO;
    // Do any additional setup after loading the view from its nib.
}

#pragma mark ---- UITableViewDataSource,UITableViewDelegate --------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellString = @"SmallChangeTableViewCell";
    SmallChangeTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (!cell) {
        cell= [[[NSBundle mainBundle]loadNibNamed:@"SmallChangeTableViewCell" owner:nil options:nil] firstObject];
    }
    
    cell.styleLabel.text = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"style"];
    cell.timeLabel.text = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"time"];
    cell.smallChangeLabel.text = [NSString stringWithFormat:@"余额：%@",[[dataArray objectAtIndex:indexPath.row] objectForKey:@"smallChange"]];
    cell.moneyLabel.text = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"money"];;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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

@end
