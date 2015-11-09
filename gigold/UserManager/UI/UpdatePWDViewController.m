//
//  UpdatePWDViewController.m
//  gigold
//
//  Created by wsc on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "UpdatePWDViewController.h"
#import "PasswordRequest.h"

@interface UpdatePWDViewController ()

@end

@implementation UpdatePWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.passwordTextField1.delegate = self;
    [self.passwordTextField1 becomeFirstResponder];
    
    self.passwordTextField2.delegate = self;
    
    [self.nextBtn addTarget:self action:@selector(nextBtnPress) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn.enabled = NO;
    
    
    [self.eyeBtn addTarget:self action:@selector(eyeBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    self.shadowHeight1.constant = 0.5;
    self.shadowHeight2.constant = 0.5;
    self.shadowHeight3.constant = 0.5;
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark ---- UITextFieldDelegate --------
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString* textString = [NSMutableString stringWithString:textField.text];
    [textString replaceCharactersInRange:range withString:string];
    if ((textField == self.passwordTextField1 && self.passwordTextField2.text.length > 0) || (textField == self.passwordTextField2 && self.passwordTextField1.text.length > 0)) {
        if (textString.length  < 6) {
            self.nextBtn.backgroundColor = unable_tap_color;
            self.nextBtn.enabled = NO;
        }else{
            self.nextBtn.backgroundColor = theme_color;
            self.nextBtn.enabled = YES;
            if (textString.length > 20) {
                return NO;
            }
        }
    }else{
        self.nextBtn.backgroundColor = unable_tap_color;
        self.nextBtn.enabled = NO;
    }
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.passwordTextField1) {
        [self.passwordTextField2 becomeFirstResponder];
    }else{
        [self nextBtnPress];
    }
    return YES;
}

-(void)eyeBtnPress{
    if (self.passwordTextField2.secureTextEntry == YES) {
        [self.eyeBtn setImage:[UIImage imageNamed:@"password_eye_1"] forState:UIControlStateNormal];
    }else{
        [self.eyeBtn setImage:[UIImage imageNamed:@"password_eye_2"] forState:UIControlStateNormal];
    }
    UIFont* font = self.passwordTextField2.font;
    self.passwordTextField2.secureTextEntry = !self.passwordTextField2.secureTextEntry;
    
    self.passwordTextField2.font = font;

}

-(void)nextBtnPress{
    [self.passwordTextField1 resignFirstResponder];
    [self.passwordTextField2 resignFirstResponder];
    
    if (self.passwordTextField1.text.length == 0) {
        [[AppUtils shareAppUtils] showHUD:@"旧密码不能为空！" andView:self.view];
        [self.passwordTextField1 becomeFirstResponder];
        return;
    }
    
    
    if (self.passwordTextField2.text.length == 0) {
        [[AppUtils shareAppUtils] showHUD:@"新密码不能为空！" andView:self.view];
        [self.passwordTextField2 becomeFirstResponder];
        return;
    }else{
        if (![[AppUtils shareAppUtils] validateLoginPassword:self.passwordTextField2.text]) {
            [[AppUtils shareAppUtils] showHUD:@"登录密码格式不正确！" andView:self.view];
            [self.passwordTextField2 becomeFirstResponder];
            return;
        }
        
    }
    
    
    if (!loadView) {
        loadView = [LoadView showLoad:LoadViewTypeJump view:self.view];
        loadView.desc.text = @"修改登录密码中";
    }else{
        [loadView showDialog:self.view];
    }
    
    [[PasswordRequest sharedPasswordRequest] updateLoginPwd:self.passwordTextField1.text newLoginPwd:self.passwordTextField2.text success:^(AFHTTPRequestOperation * operation, id responseObject) {
        [loadView stopDialog];
        NSString* rspCd = [responseObject ObjectForKey:@"rspCd"];
        NSString* rspInf = [responseObject ObjectForKey:@"rspInf"];
        if ([rspCd isEqualToString:SUCCESS]){
            ResultShowView * resultShowView = [ResultShowView showResult:ResultTypeCorrect];
            resultShowView.desc.text = @"登录密码修改成功";
            resultShowView.desc.textColor = main_text_color;
            resultShowView.deleget = self;
            [resultShowView showDialog:self.view];
        }else{
            [[AppUtils shareAppUtils] showHUD:rspInf andView:self.view];
            if ([rspCd isEqualToString:SESSION_FAIL]){
                [self sessionFailure];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error, id responseObject) {
        [loadView stopDialog];
        [[AppUtils shareAppUtils] showHUD:@"登录密码修改失败" andView:self.view];
    }];
    
   
}

#pragma mark ---- ResultShowViewSureDeleget --------
-(void)sure{
    [self logoutRespond];
    [self.navigationController popViewControllerAnimated:YES];
    if ([self.delegate respondsToSelector:@selector(UIViewControllerBack:)]) {
        [self.delegate performSelector:@selector(UIViewControllerBack:) withObject:self];
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
