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
#import "MyAccountViewController.h"
#import "appliacation_attribute.h"
#import "MyViewController.h"
#import "RootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //创建Window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showMainViewNotification:)name:@"showMainView" object:nil];
    
    
    NSLog(@"%f %f",mainScreenWidth,mainScreenHeight);

    
    //设置NavigationBar背景颜色
    [[UINavigationBar appearance] setBarTintColor:theme_color];
//    [[UINavigationBar appearance] setBackgroundColor:theme_color];
    //@{}代表Dictionary
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:title_or_btn_font,
                                                           
                                                           NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self showMainView];
    
    //设置Window为主窗口并显示出来
    [self.window makeKeyAndVisible];
    
    return YES;
}

//接受显示主界面的通知
-(void)showMainViewNotification:(NSNotification *)notification{
    [self showMainView];
}

//进入新手指导
-(void)showHelpView{
    [[AppUtils shareAppUtils] saveIsFirstRun:NO];
    HelpViewController* helpView = [[HelpViewController alloc] init];
    self.window.rootViewController = helpView;
}

-(void)showMainView{
    RootViewController* rootView = [[RootViewController alloc] init];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:rootView];
    self.window.rootViewController = nav;
  
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
