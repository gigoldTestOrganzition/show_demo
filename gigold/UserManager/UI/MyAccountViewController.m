//
//  MyAccountViewController.m
//  gigold
//
//  Created by wsc on 15/10/12.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "MyAccountViewController.h"
#import "PasswordManagerViewController.h"


@interface MyAccountViewController ()

@end

@implementation MyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    [self tableViewFooterViewCreat];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)tableViewFooterViewCreat{
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, 50)];
    
    UIButton* logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame = CGRectMake(40, 10, footerView.frame.size.width-2*40, 30);
    logoutBtn.backgroundColor = [UIColor grayColor];
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
    return 3;
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
    
    cell.textLabel.text = @"密码管理";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PasswordManagerViewController* passwordManagerView = [[PasswordManagerViewController alloc] init];
    [passwordManagerView setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:passwordManagerView animated:YES];
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
