//
//  LoginViewController.m
//  gigold
//
//  Created by MacPro on 15-10-10.
//  Copyright (c) 2015年wsc. All rights reserved.
//

#import "LoginViewController.h"
#import "ValidateViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer* oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfViewPress)];
    
    [self.view addGestureRecognizer:oneTap];

    
    self.showView.backgroundColor = UIColorFromRGB(0xFFFFFF);
    self.showView.layer.cornerRadius = 5;
    self.showView.layer.borderWidth = 0.5;
    self.showView.layer.borderColor = UIColorFromRGB(0xE5E5E5).CGColor;
    
    self.shadowView.backgroundColor = UIColorFromRGB(0xE5E5E5);
    
    self.loginBtn.backgroundColor = UIColorFromRGB(0x66C2B0);
    self.loginBtn.layer.cornerRadius = 5;
    [self.loginBtn addTarget:self action:@selector(loginBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    [self.registerBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(registerBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    [self.forgetBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [self.forgetBtn addTarget:self action:@selector(forgetBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    self.accountTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    //测试数据
    self.accountTextField.text = @"12345678900";
    self.passwordTextField.text = @"1324";
    
    self.title = @"登录";
    
//    self.navigationControlle
    
    NSLog(@"md5%@",[[AppUtils shareAppUtils] md5:@"13511407383+yyyyyyyyy"]);
}


-(void)leftBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)selfViewPress{
    if ([self.accountTextField isFirstResponder]) {
        [self.accountTextField resignFirstResponder];
    }
    
    if ([self.passwordTextField isFirstResponder]) {
        [self.passwordTextField resignFirstResponder];
    }
}

//去找回密码
-(void)forgetBtnPress{
    NSLog(@"去找回密码");
    ValidateViewController* validateView = [[ValidateViewController alloc] init];
    validateView.validateType = ResetPWDValidate;
    [self.navigationController pushViewController:validateView animated:YES];
}

//去注册
-(void)registerBtnPress{
    NSLog(@"去注册");
    ValidateViewController* validateView = [[ValidateViewController alloc] init];
    validateView.validateType = RegisterValidate;
    [self.navigationController pushViewController:validateView animated:YES];
}

//去登录
-(void)loginBtnPress{
    NSLog(@"去登录");
    if (self.accountTextField.text.length == 0) {
        [[AppUtils shareAppUtils] showAlert:@"用户名不能为空！"];
        [self.accountTextField becomeFirstResponder];
        return;
    }else{
        if (![[AppUtils shareAppUtils] validateMobile:self.accountTextField.text]) {
            [[AppUtils shareAppUtils] showAlert:@"请输入正确的用户名"];
            [self.accountTextField becomeFirstResponder];
            return;
        }
    }
    
    if (self.passwordTextField.text.length == 0) {
        [[AppUtils shareAppUtils] showAlert:@"密码不能为空！"];
        [self.passwordTextField becomeFirstResponder];
        return;
    }
    
    [[LoginRequest sharedLoginRequest] loginRequestMobileNum:@"13511232" pwd:@"123"success:^(AFHTTPRequestOperation * operation, id responseObject) {
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error, id responseObject) {
        
    }];
    
    [[AppUtils shareAppUtils] saveIsLogin:YES];
    [[AppUtils shareAppUtils] saveAccount:self.accountTextField.text];
    [[AppUtils shareAppUtils] savePassword:self.passwordTextField.text];
    
    [[AppUtils shareAppUtils] saveHistoricalAccount:self.passwordTextField.text andKey:self.accountTextField.text];
    
    [[AppUtils shareAppUtils] showHUD:@"登录成功" andView:self.view];
    
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0f];
    
}

-(void)delayMethod{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showMainView" object:nil];
}

#pragma mark ---- LoginDelegate -----

-(void)LoginSuccessInData:(NSString*)message{
    NSLog(@"登录成功");
    
}
-(void)LoginFailInData:(NSString*)message{
    NSLog(@"登录失败，原因是:%@",message);
    [[AppUtils shareAppUtils] showHUD:message andView:self.view];
}

#pragma mark ---- textFieldDelegate -----

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.accountTextField){
        [self.passwordTextField becomeFirstResponder];
    }
    else{
        [self loginBtnPress];
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
