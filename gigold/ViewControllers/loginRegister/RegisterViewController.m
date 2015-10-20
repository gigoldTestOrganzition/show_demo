//
//  RegisterViewController.m
//  gigold
//
//  Created by wsc on 15/10/16.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isAgree = YES;
    
    UITapGestureRecognizer* oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfViewPress)];
    
    [self.view addGestureRecognizer:oneTap];
    
    [self.leftBtn addTarget:self action:@selector(leftBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    self.showView1.backgroundColor = [UIColor clearColor];
    self.showView1.layer.borderWidth = 1;
    self.showView1.layer.borderColor = UIColorFromRGB(0xAFC875).CGColor;
    
    self.showView2.backgroundColor = [UIColor clearColor];
    self.showView2.layer.borderWidth = 1;
    self.showView2.layer.borderColor = UIColorFromRGB(0xAFC875).CGColor;
    
    
    [self.registerBtn addTarget:self action:@selector(registerBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.agreeBtn addTarget:self action:@selector(agreeBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer* serviceTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goServiceView)];
    [self.serviceLabel addGestureRecognizer:serviceTap];
    
    self.loginPWDTextField.delegate = self;
    self.payPWDTextField.delegate = self;

    // Do any additional setup after loading the view from its nib.
}

-(void)selfViewPress{
    if ([self.loginPWDTextField isFirstResponder]) {
        [self.loginPWDTextField resignFirstResponder];
    }
    if ([self.payPWDTextField isFirstResponder]) {
        [self.payPWDTextField resignFirstResponder];
    }
}

-(void)leftBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}


//去注册
-(void)registerBtnPress{
    if (self.loginPWDTextField.text.length == 0) {
        [[AppUtils shareAppUtils] showAlert:@"登录密码不能为空！"];
        [self.loginPWDTextField becomeFirstResponder];
        return;
    }
    
    if (self.payPWDTextField.text.length == 0) {
        [[AppUtils shareAppUtils] showAlert:@"支付密码不能为空！"];
        [self.payPWDTextField becomeFirstResponder];
        return;
    }
    
    if (!isAgree) {
        [[AppUtils shareAppUtils] showAlert:@"请先同意服务条款！"];
        return;
    }
    //    1、 phone   电话
    //    2、 pwd     密码
    //    3、 verify    验证码
    
    [[AppUtils shareAppUtils] saveIsLogin:YES];
    [[AppUtils shareAppUtils] saveAccount:self.account];
    [[AppUtils shareAppUtils] savePassword:self.loginPWDTextField.text];
    
    [[AppUtils shareAppUtils] saveHistoricalAccount:self.account andKey:self.loginPWDTextField.text];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"showMainView" object:nil];
    return;
}


//勾选与取消勾选
-(void)agreeBtnPress{
//    isAgree = !isAgree;
//    if (isMark) {
//        [self.agreeBtn setImage:[UIImage imageNamed:@"register_ture.png"] forState:UIControlStateNormal];
//    }else{
//        [self.agreeBtn setImage:[UIImage imageNamed:@"register_false.png"] forState:UIControlStateNormal];
//    }
//    
}

//去服务条款界面
-(void)goServiceView{
//    NSLog(@"去服务界面");
//    RegisterAgreementViewController* registerAgreementView = [[RegisterAgreementViewController alloc] init];
//    [self.navigationController pushViewController:registerAgreementView animated:YES];
}

#pragma mark ---- textFieldDelegate -----

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.loginPWDTextField){
        [self.payPWDTextField becomeFirstResponder];
    }
    else if (textField == self.payPWDTextField){
        [self.payPWDTextField resignFirstResponder];
        [self registerBtnPress];
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
