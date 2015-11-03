//
//  LoginViewController.m
//  gigold
//
//  Created by MacPro on 15-10-10.
//  Copyright (c) 2015年wsc. All rights reserved.
//

#import "LoginViewController.h"
#import "MoblieWriteViewController.h"
#import "User.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [[AppUtils shareAppUtils] saveGID:@""];
    
    UITapGestureRecognizer* oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfViewPress)];
    
    [self.view addGestureRecognizer:oneTap];
    
    [self.backBtn addTarget:self action:@selector(topBtnPress) forControlEvents:UIControlEventTouchUpInside];

    [self.loginBtn addTarget:self action:@selector(loginBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    [self.registerBtn addTarget:self action:@selector(registerBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetBtn addTarget:self action:@selector(forgetBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    self.accountTextField.delegate = self;
    [self.accountTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.passwordTextField.delegate = self;
    [self.passwordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    //测试数据
    
    self.accountTextField.text = [[AppUtils shareAppUtils] getUserId];
    
    NSLog(@"md5%@",[[AppUtils shareAppUtils] md5:@"13511407383+yyyyyyyyy"]);
}


-(void)topBtnPress{
    [self dismissViewControllerAnimated:YES completion:^{}];
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
    MoblieWriteViewController* moblieWriteView = [[MoblieWriteViewController alloc] init];
    moblieWriteView.delegate = self;
    moblieWriteView.flowType = ResetPasswordType;
    [self.navigationController pushViewController:moblieWriteView animated:YES];
}

//去注册
-(void)registerBtnPress{
    NSLog(@"去注册");

    MoblieWriteViewController* moblieWriteView = [[MoblieWriteViewController alloc] init];
    moblieWriteView.delegate = self;
    moblieWriteView.flowType = RegisterType;
    [self.navigationController pushViewController:moblieWriteView animated:YES];
}

//去登录
-(void)loginBtnPress{
    NSLog(@"去登录");
    if (self.accountTextField.text.length == 0) {
        [[AppUtils shareAppUtils] showHUD:@"用户名不能为空！" andView:self.view];
        [self.accountTextField becomeFirstResponder];
        return;
    }else{
        if (![[AppUtils shareAppUtils] validateMobile:self.accountTextField.text]) {
            [[AppUtils shareAppUtils] showHUD:@"请输入正确的用户名！" andView:self.view];
            [self.accountTextField becomeFirstResponder];
            return;
        }
    }
    
    if (self.passwordTextField.text.length == 0) {
        [[AppUtils shareAppUtils] showHUD:@"登录密码不能为空！" andView:self.view];
        [self.passwordTextField becomeFirstResponder];
        return;
    }
    
    if (!loadView) {
        loadView = [LoadView showLoad:LoadViewTypeJump view:self.view];
        loadView.desc.text = @"登录中";
    }else{
        [loadView showDialog:self.view];
    }
    [[LoginRequest sharedLoginRequest] loginRequestMobileNum:self.accountTextField.text pwd:self.passwordTextField.text success:^(AFHTTPRequestOperation * operation, id responseObject) {
        [loadView stopDialog];
        NSString* rspCd = [responseObject objectForKey:@"rspCd"];
        NSString* rspInf = [responseObject objectForKey:@"rspInf"];
        if ([rspCd isEqualToString:SUCCESS]) {
            [self loginRespond];
            
            
            [[AppUtils shareAppUtils] showHUD:rspInf andView:self.view];
            
            [self performSelector:@selector(delayMethod) withObject:nil afterDelay:2.0f];
            
            User* user = [[User alloc] init];
            user.mobile = [responseObject objectForKey:@"mobile"];
            [[AppUtils shareAppUtils] saveUserId:user.mobile];
            [[AppUtils shareAppUtils] saveUserInfo:[responseObject objectForKey:@"userInfo"]];
            [self loginRespond];
            NSLog(@"user%@",user);
        }else{
            [[AppUtils shareAppUtils] showHUD:rspInf andView:self.view];
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error, id responseObject) {
        [loadView stopDialog];
        [[AppUtils shareAppUtils] showHUD:@"登录失败" andView:self.view];
    }];
    
}

-(void)delayMethod{
    [self dismissViewControllerAnimated:YES completion:^{}];
    if ([self.delegate respondsToSelector:@selector(UIViewControllerBack:)]) {
        [self.delegate performSelector:@selector(UIViewControllerBack:) withObject:self];
    }
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

#pragma mark ---- BaseViewControllerDelegate --------

-(void)UIViewControllerBack:(BaseViewController *)baseViewController{
    if ([baseViewController isKindOfClass:[MoblieWriteViewController class]]) {
        MoblieWriteViewController* moblieWriteView = (MoblieWriteViewController*)baseViewController;
        if (moblieWriteView.backType == FinishType && (moblieWriteView.flowType == RegisterType || moblieWriteView.flowType == LoginPasswordType)) {
            [self dismissViewControllerAnimated:NO completion:^{}];
            if ([self.delegate respondsToSelector:@selector(UIViewControllerBack:)]) {
                [self.delegate performSelector:@selector(UIViewControllerBack:) withObject:self];
            }
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
