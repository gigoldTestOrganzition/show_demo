//
//  BankCardManagerViewController.m
//  gigold
//
//  Created by wsc on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BankCardManagerViewController.h"
#import "AddBankCardViewController.h"

@interface BankCardManagerViewController ()

@end

@implementation BankCardManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的银行卡";
    
    dataArray = [[NSMutableArray alloc] initWithObjects:@"吉高宝",@"账户余额",@"银行卡管理",@"密码管理", nil];
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    [self tableViewFooterViewCreat];
    // Do any additional setup after loading the view from its nib.
}

-(void)tableViewFooterViewCreat{
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, 50)];
    
    UIButton* addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(40, 10, footerView.frame.size.width-2*40, 30);
    addBtn.layer.borderWidth = 1;
    addBtn.layer.borderColor = [UIColor blackColor].CGColor;
    addBtn.layer.cornerRadius = 5;
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addBtn setTitle:@"添加新的银行卡" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:addBtn];
    
    self.mTableView.tableFooterView = footerView;
}

-(void)addBtnPress{
    AddBankCardViewController* addBankCardView = [[AddBankCardViewController alloc] init];
    addBankCardView.delegate = self;
    [self.navigationController pushViewController:addBankCardView animated:YES];
}

#pragma mark ---- UITableViewDataSource,UITableViewDelegate --------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellString = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark ---- BaseViewControllerDelegate --------

-(void)UIViewControllerBack:(BaseViewController *)baseViewController{
    if ([baseViewController isKindOfClass:[AddBankCardViewController class]]) {
        [dataArray addObject:@"新加一张银行卡"];
        [self.mTableView reloadData];
    }
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
