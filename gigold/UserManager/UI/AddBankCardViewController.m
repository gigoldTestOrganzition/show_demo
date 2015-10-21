//
//  AddBankCardViewController.m
//  gigold
//
//  Created by wsc on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "AddBankCardViewController.h"
#import "BankCardValidateViewController.h"

@interface AddBankCardViewController ()

@end

@implementation AddBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加银行卡";
    
    self.nextBtn.layer.borderWidth = 0.5;
    self.nextBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.nextBtn.layer.cornerRadius = 5;
    [self.nextBtn addTarget:self action:@selector(nextBtnPress) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}

-(void)nextBtnPress{
    BankCardValidateViewController* bankCardValidateView = [[BankCardValidateViewController alloc] init];
    [self.navigationController pushViewController:bankCardValidateView animated:YES];
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
