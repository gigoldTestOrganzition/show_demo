//
//  ValidateViewController.m
//  gigold
//
//  Created by wsc on 15/10/14.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "ValidateViewController.h"
#import "SetUpPasswordViewController.h"
#import "RegisterViewController.h"

@interface ValidateViewController ()

@end

@implementation ValidateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"短信验证";
    
    UITapGestureRecognizer* oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfViewPress)];
    
    [self.view addGestureRecognizer:oneTap];
    
    self.showView.backgroundColor = UIColorFromRGB(0xFFFFFF);
    self.showView.layer.cornerRadius = 5;
    self.showView.layer.borderWidth = 0.5;
    self.showView.layer.borderColor = UIColorFromRGB(0xE5E5E5).CGColor;
    
    self.shadowView.backgroundColor = UIColorFromRGB(0xE5E5E5);
    
    self.validateBtn.layer.cornerRadius = self.validateBtn.frame.size.height/2;
    [self.validateBtn addTarget:self action:@selector(validateBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    self.sureBtn.backgroundColor = UIColorFromRGB(0xE4521C);
    [self.sureBtn addTarget:self action:@selector(sureBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    self.accountTextField.delegate = self;
    self.validateTextField.delegate = self;
    
    self.accountTextField.text = @"15111407383";
    // Do any additional setup after loading the view from its nib.
}

-(void)selfViewPress{
    if ([self.accountTextField isFirstResponder]) {
        [self.accountTextField resignFirstResponder];
    }
    
    if ([self.validateTextField isFirstResponder]) {
        [self.validateTextField resignFirstResponder];
    }
}

-(void)leftBtnPress{
    [timer invalidate];
    timer = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

//发送验证
-(void)validateBtnPress{
    NSLog(@"去发送验证");
    if (self.accountTextField.text.length == 0) {
        [[AppUtils shareAppUtils] showAlert:@"手机号不能为空！"];
    }else{
        if (![[AppUtils shareAppUtils] validateMobile:self.accountTextField.text]) {
            [[AppUtils shareAppUtils] showAlert:@"请输入正确的手机号码！"];
        }
    }
    self.validateBtn.enabled = NO;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerValue) userInfo:nil repeats:YES];
    [self timerValue];
//    [[RegisterRequest sharedRegisterRequest] testHttp];
    [[RegisterRequest sharedRegisterRequest] validateMoblieNum:self.accountTextField.text
                                                       success:^(AFHTTPRequestOperation * operation, id responseObject){
                                                           
                                                       }failure:^(AFHTTPRequestOperation *operation, NSError *error, id responseObject) {
                                                           NSLog(@"Error: %@", error);
                                                       }];
}

//进行计算时间
-(void)timerValue{
    
    [self.validateBtn setTitle:[NSString stringWithFormat:@"等待(%ld)",(long)60-timeCount] forState:UIControlStateNormal];
    timeCount ++;
    if (timeCount  == 60) {
        [timer invalidate];
        timer = nil;
        timeCount = 0;
        self.validateBtn.enabled = YES;
        [self.validateBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

//去找回密码
-(void)sureBtnPress{
    NSLog(@"去找回密码");
    if (self.accountTextField.text.length == 0) {
        [[AppUtils shareAppUtils] showAlert:@"手机号码不能为空！"];
        [self.accountTextField becomeFirstResponder];
        return;
    }else{
        if (![[AppUtils shareAppUtils] validateMobile:self.accountTextField.text]) {
            [[AppUtils shareAppUtils] showAlert:@"请输入正确的手机号码！"];
            [self.accountTextField becomeFirstResponder];
            return;
        }
    }
    
    if (self.validateTextField.text.length == 0) {
        [[AppUtils shareAppUtils] showAlert:@"验证码不能为空！"];
        [self.validateTextField becomeFirstResponder];
        return;
    }
    
    if (self.validateType == ResetPWDValidate) {
        SetUpPasswordViewController* setUpPasswordView = [[SetUpPasswordViewController alloc] init];
        setUpPasswordView.account = self.accountTextField.text;
        setUpPasswordView.delegate = self;
        [self.navigationController pushViewController:setUpPasswordView animated:YES];
    }
    else if (self.validateType == RegisterValidate){
        RegisterViewController* registerView = [[RegisterViewController alloc] init];
        registerView.account = self.accountTextField.text;
        [self.navigationController pushViewController:registerView animated:YES];
    }
}

#pragma mark ---- textFieldDelegate -----

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.accountTextField){
        [self.validateTextField becomeFirstResponder];
    }
    else{
        [self sureBtnPress];
    }
    return YES;
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
