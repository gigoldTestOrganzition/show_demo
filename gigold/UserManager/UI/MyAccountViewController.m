//
//  MyAccountViewController.m
//  gigold
//
//  Created by wsc on 15/10/12.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "MyAccountViewController.h"
#import "PasswordManagerViewController.h"
#import "BankCardManagerViewController.h"
#import "IncomeAEViewController.h"

@interface MyAccountViewController ()

@end

@implementation MyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataArray = [[NSMutableArray alloc] initWithObjects:@"吉高宝",@"账户余额",@"银行卡管理",@"密码管理", nil];
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    [self tableViewFooterViewCreat];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)tableViewFooterViewCreat{
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, 50)];
    
    UIButton* logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame = CGRectMake(40, 10, footerView.frame.size.width-2*40, 30);
    logoutBtn.layer.borderWidth = 1;
    logoutBtn.layer.borderColor = [UIColor blackColor].CGColor;
    logoutBtn.layer.cornerRadius = 5;
    [logoutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(logoutBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:logoutBtn];
    
    self.mTableView.tableFooterView = footerView;
}

-(void)logoutBtnPress{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showLoginView" object:nil];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.swipeController showLeft];
    if (indexPath.row == 0) {
        NSLog(@"去吉高宝");
    }else if (indexPath.row == 1){
        NSLog(@"去账户余额");
        IncomeAEViewController* incomeAEView = [[IncomeAEViewController alloc] init];
        [incomeAEView setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:incomeAEView animated:YES];
    }
    else if (indexPath.row == 2){
        NSLog(@"去银行卡管理");
        BankCardManagerViewController* bankCardView = [[BankCardManagerViewController alloc] init];
        [bankCardView setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:bankCardView animated:YES];
    }
    else if (indexPath.row == 3){
        PasswordManagerViewController* passwordManagerView = [[PasswordManagerViewController alloc] init];
        [passwordManagerView setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:passwordManagerView animated:YES];
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
