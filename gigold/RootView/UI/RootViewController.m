//
//  RootViewController.m
//  gigold
//
//  Created by wsc on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "RootViewController.h"
#import <UIKit/UIKit.h>
#import "appliacation_attribute.h"
#import "ContentViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController
@synthesize isShowLauchView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];

    
    
    self.centerViewController = [ContentViewController new];
   
    
    
    MyAccountViewController* myAccountView1= [[MyAccountViewController alloc] init];
    self.leftViewController = myAccountView1;
    self.leftVisibleWidth = self.view.bounds.size.width -50;
    
    if (isShowLauchView){
        self.canShowLeft = NO;
        [self showCustomLaunchView];
    }
    
    
    // Do any additional setup after loading the view.
}

-(void)showCustomLaunchView{
    launchView = [[LaunchViewController alloc] init];
    launchView.delegate = self;
    launchView.view.frame = CGRectMake(0, 0, mainScreenWidth, mainScreenHeight);
    [self.view addSubview:launchView.view];
}


-(void)UIViewControllerBack:(BaseViewController *)baseViewController{
    [launchView.view removeFromSuperview];
    self.canShowLeft = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+(RootViewController *)shareInstance{
    static RootViewController* rootViewController=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        rootViewController = [RootViewController new];
    });
    return rootViewController;
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
