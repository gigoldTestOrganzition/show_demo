//
//  BankCardValidateViewController.m
//  gigold
//
//  Created by wsc on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BankCardValidateViewController.h"
#import "MoblieValidateViewController.h"

@interface BankCardValidateViewController ()

@end

@implementation BankCardValidateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"安全验证";
    
    self.nextBtn.layer.borderWidth = 0.5;
    self.nextBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.nextBtn.layer.cornerRadius = 5;
    [self.nextBtn addTarget:self action:@selector(nextBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)nextBtnPress{
    MoblieValidateViewController* moblieValidateView = [[MoblieValidateViewController alloc] init];
    moblieValidateView.delegate = self;
    moblieValidateView.title = @"安全验证";
    [self.navigationController pushViewController:moblieValidateView animated:YES];
}

#pragma mark ---- BaseViewControllerDelegate --------

-(void)UIViewControllerBack:(BaseViewController *)baseViewController{
    if ([baseViewController isKindOfClass:[MoblieValidateViewController class]]) {
        [self.navigationController popViewControllerAnimated:NO];
        if ([self.delegate respondsToSelector:@selector(UIViewControllerBack:)]) {
            [self.delegate performSelector:@selector(UIViewControllerBack:) withObject:self];
        }
        
    }
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
