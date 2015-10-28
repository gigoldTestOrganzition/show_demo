//
//  VerificationCodeWriteViewController.m
//  gigold
//
//  Created by wsc on 15/10/22.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "VerificationCodeWriteViewController.h"
#import "PasswordWriteViewController.h"
#import "PayPasswordViewController.h"
#import "ServiceTextViewController.h"

@interface VerificationCodeWriteViewController ()

@end

@implementation VerificationCodeWriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isAgree = YES;
    
    self.shadowHeight1.constant = 0.5;
    self.shadowHeight2.constant = 0.5;
    self.shadowWidth3.constant = 0.5;
    
    if (self.flowType == ResetPasswordType || self.flowType == UpdataPayPWDType || self.flowType == SetPayPWDType || self.flowType == AddBankCardType) {
        self.serveTextView.hidden = YES;
        self.next_view_height.constant = 30;
    }
    
    self.validateTextField.delegate = self;
    [self.validateTextField becomeFirstResponder];
    
    [self.nextBtn addTarget:self action:@selector(nextBtnPress) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn.enabled = NO;
    if (self.flowType == AddBankCardType) {
        [self.nextBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
    
    UITapGestureRecognizer* sendPress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startTime)];
    [self.sendLabel addGestureRecognizer:sendPress];
    self.sendLabel.userInteractionEnabled = NO;
    
    [self startTime];
    
    [self.agreeBtn addTarget:self action:@selector(agreeBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    self.moblieLabel.text = [NSString stringWithFormat:@"已发送校验码到你的手机%@",[[AppUtils shareAppUtils] encryptMoblieNumber:self.moblieNum]];
    
    UITapGestureRecognizer* serveTextViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goServeTextView)];
    [self.serveTextView addGestureRecognizer:serveTextViewTap];
    
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark ---- UITextFieldDelegate --------
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString* textString = [NSMutableString stringWithString:textField.text];
    [textString replaceCharactersInRange:range withString:string];
    if (textString.length == 0) {
        self.nextBtn.backgroundColor = unable_tap_color;
        self.nextBtn.enabled = NO;
    }else{
        self.nextBtn.backgroundColor = theme_color;
        self.nextBtn.enabled = YES;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)startTime{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerValue) userInfo:nil repeats:YES];
    [self timerValue];
}

-(void)timerValue{
    self.sendLabel.text = [NSString stringWithFormat:@"%ld秒后重发",(long)TimeInterval-timeCount];
    timeCount ++;
    if (timeCount  == TimeInterval) {
        [self endTime];
        timeCount = 0;
        self.sendLabel.textColor = theme_color;
        self.sendLabel.text = @"重新发送";
        self.sendLabel.userInteractionEnabled = YES;
    }else{
        self.sendLabel.userInteractionEnabled = NO;
        self.sendLabel.textColor = input_hint_color;
    }
}

-(void)endTime{
    [timer invalidate];
    timer = nil;
}

-(void)goServeTextView{
    NSLog(@"去看服务条款");
    ServiceTextViewController* serviceTextView = [[ServiceTextViewController alloc] init];
    serviceTextView.serviceTextType = Service_GigoldType;
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:serviceTextView];
    [self presentViewController:nav animated:YES completion:^{}];
}

-(void)agreeBtnPress{
    isAgree = !isAgree;
    if (isAgree) {
        [self.agreeBtn setImage:[UIImage imageNamed:@"protocol_but_1"] forState:UIControlStateNormal];
    }else{
        [self.agreeBtn setImage:[UIImage imageNamed:@"protocol_but_2"] forState:UIControlStateNormal];
    }
}

-(void)nextBtnPress{
    NSLog(@"下一步");
    [self.validateTextField resignFirstResponder];
    if (self.flowType == UpdataPayPWDType) {
        PayPasswordViewController* payPasswordView = [[PayPasswordViewController alloc] init];
        payPasswordView.delegate = self;
        payPasswordView.payPwdType = SetOldPayPwdType;
        payPasswordView.title = self.title;
        [self.navigationController pushViewController:payPasswordView animated:YES];
        return;
    }
    
    if (self.flowType == SetPayPWDType) {
        PayPasswordViewController* payPasswordView = [[PayPasswordViewController alloc] init];
        payPasswordView.delegate = self;
        payPasswordView.payPwdType = SetNewPayPwdType;
        payPasswordView.title = self.title;
        [self.navigationController pushViewController:payPasswordView animated:YES];
        return;
    }
    
    if (self.flowType == AddBankCardType) {
        NSLog(@"成功");
        ResultShowView * resultShowView = [ResultShowView showResult:ResultTypeCorrect];
        resultShowView.desc.text = @"快捷支付开通成功";
        resultShowView.desc.textColor = main_text_color;
        resultShowView.deleget = self;
        [resultShowView showDialog:self.view];
        return;
        
    }
    
    if (isAgree) {
        PasswordWriteViewController* passwordWriteView = [[PasswordWriteViewController alloc] init];
        passwordWriteView.title = self.title;
        passwordWriteView.flowType = self.flowType;
        passwordWriteView.delegate = self;
        passwordWriteView.moblieNum = self.moblieNum;
        [self.navigationController pushViewController:passwordWriteView animated:YES];
    }else{
        [[AppUtils shareAppUtils] showHUD:@"请先同意服务条款！" andView:self.view];
    }
    
}

#pragma mark ---- ResultShowViewSureDeleget --------
-(void)sure{
    [self.navigationController popViewControllerAnimated:NO];
    if ([self.delegate respondsToSelector:@selector(UIViewControllerBack:)]) {
        [self.delegate performSelector:@selector(UIViewControllerBack:) withObject:self];
    }
}

#pragma mark ---- BaseViewControllerDelegate --------

-(void)UIViewControllerBack:(BaseViewController *)baseViewController{
    if ([baseViewController isKindOfClass:[PasswordWriteViewController class]]) {
        PasswordWriteViewController* passwordWirteView = (PasswordWriteViewController*)baseViewController;
        self.backType = passwordWirteView.backType;
        passwordWirteView.moblieNum = self.moblieNum;
        [self.navigationController popViewControllerAnimated:NO];
        if ([self.delegate respondsToSelector:@selector(UIViewControllerBack:)]) {
            [self.delegate performSelector:@selector(UIViewControllerBack:) withObject:self];
        }
    }
    else if ([baseViewController isKindOfClass:[PayPasswordViewController class]]){
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
