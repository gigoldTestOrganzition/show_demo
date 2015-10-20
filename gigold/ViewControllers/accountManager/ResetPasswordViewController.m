//
//  ResetPasswordViewController.m
//  gigold
//
//  Created by wsc on 15/10/12.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "ResetPasswordViewController.h"

@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

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
    
    self.showView3.backgroundColor = [UIColor clearColor];
    self.showView3.layer.borderWidth = 1;
    self.showView3.layer.borderColor = UIColorFromRGB(0xAFC875).CGColor;
    
    
    [self.sureBtn addTarget:self action:@selector(sureBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.oldpasswordTextField.delegate = self;
    self.validateTextField.delegate = self;
    self.newpasswordTextField.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
}

-(void)selfViewPress{
    if ([self.oldpasswordTextField isFirstResponder]) {
        [self.oldpasswordTextField resignFirstResponder];
    }
    if ([self.newpasswordTextField isFirstResponder]) {
        [self.newpasswordTextField resignFirstResponder];
    }
    if ([self.validateTextField isFirstResponder]) {
        [self.validateTextField resignFirstResponder];
    }
}

-(void)leftBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}


//去设置密码
-(void)sureBtnPress{
    if (self.oldpasswordTextField.text.length == 0) {
        [[AppUtils shareAppUtils] showAlert:@"原密码不能为空！"];
        [self.oldpasswordTextField becomeFirstResponder];
        return;
    }else{
        //验证密码正确性
    }
    
    if (self.newpasswordTextField.text.length == 0) {
        [[AppUtils shareAppUtils] showAlert:@"新密码不能为空！"];
        [self.newpasswordTextField becomeFirstResponder];
        return;
    }else{
        //验证密码正确性
    }
    
    if (self.validateTextField.text.length == 0) {
        [[AppUtils shareAppUtils] showAlert:@"确认密码不能为空！"];
        [self.validateTextField becomeFirstResponder];
        return;
    }else{
        if (![self.validateTextField.text isEqualToString:self.newpasswordTextField.text]) {
            [[AppUtils shareAppUtils] showAlert:@"两个输入的密码不一致！"];
            [self.validateTextField becomeFirstResponder];
            return;
        }
    }
}


#pragma mark ---- textFieldDelegate -----

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.oldpasswordTextField){
        [self.newpasswordTextField becomeFirstResponder];
    }
    else if (textField == self.newpasswordTextField){
        [self.validateTextField becomeFirstResponder];
    }
    else if (textField == self.validateTextField){
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
