//
//  RollInViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "RollInViewController.h"
#import "PayPasswordViewController.h"
#import "appliacation_attribute.h"
#import "StringUtil.h"
#import "TimeUtil.h"
#import "StringUtil.h"
#import "LimitInstructionsViewController.h"
@interface RollInViewController ()<UITextFieldDelegate>{
   // 转入银行
    __weak IBOutlet UILabel *rollInBank;
    // 银行标记
    __weak IBOutlet UIImageView *bankSelectMark;
    // 转入金额
    __weak IBOutlet UITextField *rollInAmount;
    //下一步
    __weak IBOutlet UIButton *next;
}
@end

@implementation RollInViewController
@synthesize amountStr=_amountStr;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"转入";
    NSDictionary* attributesDic = [NSDictionary dictionaryWithObjectsAndKeys:main_font,NSFontAttributeName,nil];
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributesDic forState:0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"限额说明" style:UIBarButtonItemStyleDone target:self action:@selector(limitInstructions)];
    
    if (![StringUtil isEmpty:_amountStr]) {
        rollInAmount.text = _amountStr;
        next.backgroundColor = theme_color;
        next.enabled = YES;
    }else{
        next.backgroundColor = unable_tap_color;
        next.enabled = NO;
    }
    next.layer.cornerRadius = next.frame.size.height/2;
    [self initEvent];
    
    // Do any additional setup after loading the view.
}
//额度说明
-(void)limitInstructions{
    LimitInstructionsViewController* limitInstructionsViewController = [[LimitInstructionsViewController alloc]init];
    [self.navigationController pushViewController:limitInstructionsViewController animated:YES];

}
//初始化事件
-(void)initEvent{
    UITapGestureRecognizer* selectBankRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBank)];
    rollInBank.userInteractionEnabled = YES;
    [rollInBank addGestureRecognizer:selectBankRecognizer];
}
//选择银行
-(void)selectBank{
    NSLog(@"选择银行");
}

//立即转入
- (IBAction)rollInAction:(id)sender {
    NSLog(@"立即转入");
    PayPasswordViewController* payPasswordViewController = [[PayPasswordViewController alloc]init];
    payPasswordViewController.title = @"转入";
    payPasswordViewController.titleLabel.text = @"请输入6位数字支付密码";
    payPasswordViewController.payPwdType = RollInPayPwdType;
    NSMutableDictionary* parames = [[NSMutableDictionary alloc]init];
    [parames setValue:rollInAmount.text forKey:@"amount"];
    [parames setValue:[NSDate date] forKey:@"time"];
    payPasswordViewController.parames = parames;
    [self.navigationController pushViewController:payPasswordViewController animated:YES];
}

#pragma mark -UITextfield
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSInteger value = textField.text.length-range.length+string.length;
    if (value > 0) {
        next.enabled = YES;
        next.backgroundColor = theme_color;
    }else{
        next.enabled = NO;
        next.backgroundColor = unable_tap_color;
    }
    if (value > 11) {
        return NO;
    }else{
        return YES;
    }
}



@end
