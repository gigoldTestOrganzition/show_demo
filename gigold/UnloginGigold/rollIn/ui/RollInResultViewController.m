//
//  RollInResultViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "RollInResultViewController.h"

@interface RollInResultViewController ()

@end

@implementation RollInResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"转入结果";
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

#pragma mark -xib链接
//再次转入
- (IBAction)againRollIn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//返回首页
- (IBAction)backHome:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
