//
//  AppDelegate.m
//  gigold
//
//  Created by wsc on 15/10/10.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "AppDelegate.h"
#import "HelpViewController.h"
#import "LoginViewController.h"
#import "SetUpPasswordViewController.h"
#import "ResetPasswordViewController.h"
#import "MyAccountViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //创建Window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showMainViewNotification:)name:@"showMainView" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showLoginViewNotification:)name:@"showLoginView" object:nil];
    
    
    NSLog(@"%f %f",mainScreenWidth,mainScreenHeight);
    
    //设置NavigationBar背景颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    //@{}代表Dictionary
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
//    [self showHelpView];
    if ([[AppUtils shareAppUtils] getIsFirstRun]) {
        [self showHelpView];
    }else{
        [self showLoginView];
    }
    
    //设置Window为主窗口并显示出来
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)showLoginView{
    LoginViewController* loginView = [[LoginViewController alloc] init];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:loginView];
    [self.window setRootViewController:nav];
}

//接受显示主界面的通知
-(void)showMainViewNotification:(NSNotification *)notification{
    [self showMainView];
}

-(void)showLoginViewNotification:(NSNotification *)notification{
    [self showLoginView];
}

//进入新手指导
-(void)showHelpView{
    [[AppUtils shareAppUtils] saveIsFirstRun:NO];
    HelpViewController* helpView = [[HelpViewController alloc] init];
    self.window.rootViewController = helpView;
}



-(void)showMainView{
    
    
    
    
    //a.初始化一个tabBar控制器
    UITabBarController *tb= [[UITabBarController alloc]init];
    tb.tabBar.selectedImageTintColor = UIColorFromRGB(0xFFFFFF);
    tb.tabBar.barTintColor = UIColorFromRGB(0x65BECB);
    
    // this will give selected icons and text your apps tint color
    tb.tabBar.tintColor = [UIColor whiteColor]; // appTintColor is a UIColor *
    
//    [[UITabBarItem appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      [UIColor whiteColor], UITextAttributeTextColor,
//      [UIFont fontWithName:@"ProximaNova-Semibold" size:20.0], UITextAttributeFont,
//      nil]
//                                             forState:UIControlStateNormal];
    
    //    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, 49)];
    //    backView.backgroundColor = UIColorFromRGB(0x65BECB);
    //    [tb.tabBar insertSubview:backView atIndex:0];
    //    tb.tabBar.opaque = YES;
    
    tb.tabBar.translucent = NO;
    
    //b.创建子控制器
    MyViewController *c1 = [[MyViewController alloc]init];
    c1.view.backgroundColor = [UIColor grayColor];
    c1.title = @"社区生活";
    c1.tabBarItem.image = [UIImage imageNamed:@"Home"];
    
    
    MyViewController *c2 = [[MyViewController alloc]init];
    c2.view.backgroundColor = [UIColor redColor];
    c2.title = @"消息";
    c2.tabBarItem.image = [UIImage imageNamed:@"HomeShoppingCenter"];
    c2.tabBarItem.badgeValue = @"10";
    
    
    MyAccountViewController *c3 = [[MyAccountViewController alloc]init];
    c3.title = @"我的账户";
    c3.tabBarItem.image = [UIImage imageNamed:@"HomeShoppingCart"];
    
    UINavigationController* nav1 = [[UINavigationController alloc] initWithRootViewController:c1];
    UINavigationController* nav2 = [[UINavigationController alloc] initWithRootViewController:c2];
    UINavigationController* nav3 = [[UINavigationController alloc] initWithRootViewController:c3];
    
    tb.viewControllers=@[nav1,nav2,nav3];
    
    
    self.window.rootViewController = tb;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
