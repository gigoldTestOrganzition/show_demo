//
//  ContentViewController.m
//  gigold
//
//  Created by 单小萍 on 15/11/6.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "ContentViewController.h"
#import "HomeViewController.h"
#import "LifeViewController.h"
#import "BankViewController.h"
#import "AroundViewController.h"
@interface ContentViewController (){
    HomeViewController* homeViewController;
    LifeViewController* lifeViewController;
    BankViewController* bankViewController;
    AroundViewController* aroundViewController;
}
@end

@implementation ContentViewController

#pragma mark - 系统函数
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initTabBarController];
       // Do any additional setup after loading the view.
}


/*
 *初始化ui
 */
-(void)initUI{
    self.tabBar.barTintColor = [UIColor whiteColor];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:white_auxiliary_color,NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:theme_color,NSForegroundColorAttributeName,nil]forState:UIControlStateSelected];
    

}
/*
 *初始bar控制器
 */
-(void)initTabBarController{
    //首页
    homeViewController = [[HomeViewController alloc]init];
    homeViewController.tabBarItem.title = @"首页";
    homeViewController.tabBarItem.image = [[UIImage imageNamed:@"main_menu_ico1_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"main_menu_ico1_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //[self addChildViewController:homeViewController];
    //生活
    lifeViewController  = [[LifeViewController alloc]init];
    lifeViewController.tabBarItem.title = @"生活";
    lifeViewController.tabBarItem.image = [[UIImage imageNamed:@"main_menu_ico2_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    lifeViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"main_menu_ico2_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     //[self addChildViewController:lifeViewController];
    
    //金融
    bankViewController = [[BankViewController alloc]init];
    bankViewController.tabBarItem.title = @"金融";
    bankViewController.tabBarItem.image = [[UIImage imageNamed:@"main_menu_ico3_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    bankViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"main_menu_ico3_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //[self addChildViewController:bankViewController];
    
    //周边
    aroundViewController = [[AroundViewController alloc]init];
    aroundViewController.tabBarItem.title = @"周边";
    aroundViewController.tabBarItem.image = [[UIImage imageNamed:@"main_menu_ico4_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    aroundViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"main_menu_ico4_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //[self addChildViewController:aroundViewController];
    
    self.viewControllers = @[[[UINavigationController alloc]initWithRootViewController:homeViewController],[[UINavigationController alloc]initWithRootViewController:lifeViewController],[[UINavigationController alloc]initWithRootViewController:bankViewController],[[UINavigationController alloc]initWithRootViewController:aroundViewController]];
}
@end
