//
//  LimitInstructionsViewController.m
//  gigold
//
//  Created by 单小萍 on 15/11/2.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "LimitInstructionsViewController.h"

@interface LimitInstructionsViewController (){

    __weak IBOutlet NSLayoutConstraint *topLayoutConstraint;
}

@end

@implementation LimitInstructionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"限额说明";
    NSDictionary* attributesDic = [NSDictionary dictionaryWithObjectsAndKeys:main_font,NSFontAttributeName,nil];
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributesDic forState:0];
    topLayoutConstraint.constant = 30.f;
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
}
//关闭
-(void)close{
    [self.navigationController popViewControllerAnimated:YES];
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
