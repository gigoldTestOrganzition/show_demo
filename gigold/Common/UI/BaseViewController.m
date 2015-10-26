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
