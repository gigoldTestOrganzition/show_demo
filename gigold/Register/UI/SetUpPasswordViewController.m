//
//  SetUpPasswordViewController.m
//  gigold
//
//  Created by wsc on 15/10/12.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "SetUpPasswordViewController.h"

@interface SetUpPasswordViewController ()

@end

@implementation SetUpPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer* oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfViewPress)];
    
    [self.view addGestureRecognizer:oneTap];
    
    [self.leftBtn addTarget:self action:@selector(leftBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    self.showView1.backgroundColor = [UIColor clearColor];
    self.showView1.layer.borderWidth = 1;
    self.showView1.layer.borderColor = UIColorFromRGB(0xAFC875).CGColor;
    
    self.showView2.backgroundColor = [UIColor clearColor];
    self.showView2.layer.borderWidth = 1;
    self.showView2.layer.borderColor = UIColorFromRGB(0xAFC875).CGColor;

    
    [self.sureBtn addTarget:self action:@selector(sureBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    self.valiteTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
}

-(void)selfViewPress{
    if ([self.valiteTextField isFirstResponder]) {
        [self.valiteTextField resignFirstResponder];
    }
    if ([self.passwordTextField isFirstResponder]) {
        [self.passwordTextField resignFirstResponder];
    }
}

-(void)leftBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}


//去设置密码
-(void)sureBtnPress{
    if (self.passwordTextField.text.length == 0) {
        [[AppUtils shareAppUtils] showAlert:@"密码不能为空！"];
        [self.passwordTextField becomeFirstResponder];
        return;
    }else{
       //验证密码正确性
    }
    
    if (self.valiteTextField.text.length == 0) {
        [[AppUtils shareAppUtils] showAlert:@"确认密码不能为空！"];
        [self.valiteTextField becomeFirstResponder];
        return;
    }else{
        if (![self.valiteTextField.text isEqualToString:self.passwordTextField.text]) {
            [[AppUtils shareAppUtils] showAlert:@"两个输入的密码不一致！"];
            [self.valiteTextField becomeFirstResponder];
            return;
        }
    }
    
    [[AppUtils shareAppUtils] saveIsLogin:YES];
    [[AppUtils shareAppUtils] saveAccount:self.account];
    [[AppUtils shareAppUtils] savePassword:self.passwordTextField.text];
    [[AppUtils shareAppUtils] saveHistoricalAccount:self.passwordTextField.text andKey:self.account];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"showMainView" object:nil];
}


#pragma mark ---- textFieldDelegate -----

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.passwordTextField){
        [self.valiteTextField becomeFirstResponder];
    }
    else if (textField == self.valiteTextField){
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
