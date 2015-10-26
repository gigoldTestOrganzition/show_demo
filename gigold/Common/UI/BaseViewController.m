//
//  BaseViewController.m
//  gigold
//
//  Created by wsc on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setImage:[UIImage imageNamed:@"top_return_but_1"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"top_return_but_2"] forState:UIControlStateHighlighted];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
//    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
    
    
//    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
//    backItem.title=@"hhh";
//    backItem.image=[UIImage imageNamed:@"top_return_but_1"];
//    self.navigationItem.backBarButtonItem=backItem;
    
//    自定义返回按钮
//    UIImage *backButtonImage = [[UIImage imageNamed:@"top_return_but_1"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    //将返回按钮的文字position设置不在屏幕上显示
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
////
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
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
- (void)loginRespond:(NSString*)account andPassword:(NSString*)pwd{
    //保存登录信息
    [[AppUtils shareAppUtils] saveIsLogin:YES];
    [[AppUtils shareAppUtils] saveAccount:account];
    [[AppUtils shareAppUtils] savePassword:pwd];
    
    //保存登录过的账号记录
    [[AppUtils shareAppUtils] saveHistoricalAccount:pwd andKey:account];
    
    //通知状态改变
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginStateChange" object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
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

@end
