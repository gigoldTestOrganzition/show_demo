//
//  BaseViewController.m
//  gigold
//
//  Created by wsc on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"
#import "PasswordManagerViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}


-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)backBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

//登出响应
- (void)logoutRespond{
    //修改保存信息
    [[AppUtils shareAppUtils] saveIsLogin:NO];
    //通知状态改变
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginStateChange" object:nil];
}
//登录响应
- (void)loginRespond{
    //保存登录信息
    [[AppUtils shareAppUtils] saveIsLogin:YES];
    //通知状态改变
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginStateChange" object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = back_ground_color;
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setImage:[UIImage imageNamed:@"top_return_but_1"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"top_return_but_2"] forState:UIControlStateHighlighted];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [btn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // Do any additional setup after loading the view.
}

- (void)showLoginView:(LoginType)loginType{
    NSLog(@"跳转loginView");
    LoginViewController* loginView = [[LoginViewController alloc] init];
    loginView.delegate = self;
    loginView.loginType = loginType;
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:loginView];
    [self presentViewController:nav animated:YES completion:^{}];
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
