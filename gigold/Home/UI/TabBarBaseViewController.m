//
//  TabBarBaseViewController.m
//  gigold
//
//  Created by 单小萍 on 15/11/8.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "TabBarBaseViewController.h"
#import "RootViewController.h"
@interface TabBarBaseViewController ()

@end

@implementation TabBarBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setImage:[UIImage imageNamed:@"main_top_user_ico"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"main_top_user_ico"] forState:UIControlStateHighlighted];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [btn addTarget:self action:@selector(backSlideMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = item;
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
}
-(void)viewWillDisappear:(BOOL)animated{
}

/*
 *返回滑动菜单
 */
-(void)backSlideMenu{
   [[RootViewController shareInstance]showLeft];
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
