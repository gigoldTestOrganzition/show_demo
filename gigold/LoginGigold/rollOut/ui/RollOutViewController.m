//
//  RollOutViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "RollOutViewController.h"
#import "Colors.h"
#import "appliacation_attribute.h"
#import "RollOutResultViewController.h"
#import "PayPasswordViewController.h"
#import "StringUtil.h"
@interface RollOutViewController ()<UITextFieldDelegate>{
    //转出银行
    __weak IBOutlet UILabel *outBank;
    __weak IBOutlet UIView *selectBankView;
    //转出金额
    __weak IBOutlet UITextField *rollOutAmount;
    //下一步
    __weak IBOutlet UIButton *nextBtn;
}
@end

@implementation RollOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"转出";
    nextBtn.layer.cornerRadius = nextBtn.frame.size.height/2;
    //nextBtn.enabled = NO;
    [self initEvent];
    // Do any additional setup after loading the view.
}
//初始化事件
-(void)initEvent{
    UITapGestureRecognizer* selectBankRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBank)];
    selectBankView.userInteractionEnabled = YES;
    [selectBankView addGestureRecognizer:selectBankRecognizer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark －手势 
//选择银行
-(void)selectBank{
    NSLog(@"选择银行");
}

#pragma mark - xib链接
// 立即转出
- (IBAction)rollOutAction:(id)sender {
    PayPasswordViewController* payPasswordViewController = [[PayPasswordViewController alloc]init];
    payPasswordViewController.payPwdType = RollOutPayPwdType;
    NSMutableDictionary* params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSDate date],@"time",nil];
    payPasswordViewController.parames = params;
    payPasswordViewController.title = @"转出";
    [self.navigationController pushViewController:payPasswordViewController animated:YES];
    
}
#pragma mark -uitextfield 协议
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([StringUtil isEmpty:string]) {
        nextBtn.enabled = NO;
        nextBtn.backgroundColor = unable_tap_color;
    }else{
        nextBtn.enabled = YES;
        nextBtn.backgroundColor = theme_color;
    }
    NSInteger value = textField.text.length-range.length+string.length;
    if (value > 10) {
        return NO;
    }else{
        return YES;
    }
}
@end
