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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:72/255. green:202/255. blue:226/255. alpha:1];
    
    titleArray = [[NSMutableArray alloc] initWithObjects:@"吉有钱",@"零钱",@"银行卡",@"交易记录",@"密码管理", nil];
    imageArray = [[NSMutableArray alloc] initWithObjects:@"user_menu_ico_1",@"user_menu_ico_2",@"user_menu_ico_3",@"user_menu_ico_4",@"user_menu_ico_5", nil];
    
    self.mTableView.backgroundColor = [UIColor colorWithRed:72/255. green:202/255. blue:226/255. alpha:1];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    // Do any additional setup after loading the view from its nib.
}

//-(void)logoutBtnPress{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"showLoginView" object:nil];
//}

#pragma mark ---- UITableViewDataSource,UITableViewDelegate --------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellString = @"MyAccountTableViewCell";
    MyAccountTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (!cell) {
        NSLog(@"%@",[[NSBundle mainBundle]loadNibNamed:@"MyAccountTableViewCell" owner:nil options:nil] );
        cell= [[[NSBundle mainBundle]loadNibNamed:@"MyAccountTableViewCell" owner:nil options:nil] firstObject];
    }
    cell.menuTitleLabel.text = [titleArray objectAtIndex:indexPath.row];
    cell.menuImageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
    cell.valueLabel.text = @"";

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.swipeController showLeft];
    NSString* menuTitle = [titleArray objectAtIndex:indexPath.row];
    NSLog(@"去%@",menuTitle);
    if ([menuTitle isEqualToString:@"吉有钱"]) {
    }else if ([menuTitle isEqualToString:@"交易记录"]){
        IncomeAEViewController* incomeAEView = [[IncomeAEViewController alloc] init];
        [incomeAEView setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:incomeAEView animated:YES];
    }
    else if ([menuTitle isEqualToString:@"银行卡"]){
        BankCardManagerViewController* bankCardView = [[BankCardManagerViewController alloc] init];
        [bankCardView setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:bankCardView animated:YES];
    }
    else if ([menuTitle isEqualToString:@"密码管理"]){
        PasswordManagerViewController* passwordManagerView = [[PasswordManagerViewController alloc] init];
        [passwordManagerView setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:passwordManagerView animated:YES];
    }else if ([menuTitle isEqualToString:@"零钱"]){
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
