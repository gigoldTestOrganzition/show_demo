//
//  PayPwdValidateViewController.m
//  gigold
//
//  Created by wsc on 15/10/28.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "PayPwdValidateViewController.h"

@interface PayPwdValidateViewController ()

@end

@implementation PayPwdValidateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tempTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    tempTextField.delegate = self;
    tempTextField.keyboardType = UIKeyboardTypeNumberPad;
    [tempTextField becomeFirstResponder];
    [self.view addSubview:tempTextField];
    
    self.payView.backgroundColor = [UIColor whiteColor];
    self.payView.layer.borderWidth = 0.5;
    self.payView.layer.borderColor = gray_diver_color.CGColor;
    
    UITapGestureRecognizer* oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textFieldResponder)];
    [self.payView addGestureRecognizer:oneTap];
    
    [self.nextBtn addTarget:self action:@selector(nextBtnPress) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn.enabled = NO;
    
    if (self.payPwdValiteType == V_Set_PayPwdType) {
        self.titleLabel.text = @"请再次输入支付密码";
    }else if (self.payPwdValiteType == V_Updata_PayPwdType){
        self.titleLabel.text = @"请再次输入新的支付密码";
    }
    // Do any additional setup after loading the view from its nib.
}

-(void)textFieldResponder{
    if ([tempTextField isFirstResponder]) {
        [tempTextField resignFirstResponder];
    }else{
        [tempTextField becomeFirstResponder];
    }
}

#pragma mark ---- UITextFieldDelegate --------
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString* textString = [NSMutableString stringWithString:textField.text];
    [textString replaceCharactersInRange:range withString:string];
    
    [self showMarkView:string];
    
    if (textString.length >= 6) {
        self.nextBtn.backgroundColor = theme_color;
        self.nextBtn.enabled = YES;
    }else{
        self.nextBtn.backgroundColor = unable_tap_color;
        self.nextBtn.enabled = NO;
    }
        
    if (textString.length > 6) {
        return NO;
    }
    
    return YES;
}

-(void)showMarkView:(NSString*)string{
    //加
    if (string.length > 0) {
        if (self.pwd1.hidden) {
            self.pwd1.hidden = NO;
        }else{
            if (self.pwd2.hidden) {
                self.pwd2.hidden = NO;
            }else{
                if (self.pwd3.hidden) {
                    self.pwd3.hidden = NO;
                }else{
                    if (self.pwd4.hidden) {
                        self.pwd4.hidden = NO;
                    }else{
                        if (self.pwd5.hidden) {
                            self.pwd5.hidden = NO;
                        }else{
                            if (self.pwd6.hidden) {
                                self.pwd6.hidden = NO;
                            }
                        }
                    }
                }
            }
        }
    }
    else{ //减
        if (!self.pwd6.hidden) {
            self.pwd6.hidden = YES;
        }else{
            if (!self.pwd5.hidden) {
                self.pwd5.hidden = YES;
            }else{
                if (!self.pwd4.hidden) {
                    self.pwd4.hidden = YES;
                }else{
                    if (!self.pwd3.hidden) {
                        self.pwd3.hidden = YES;
                    }else{
                        if (!self.pwd2.hidden) {
                            self.pwd2.hidden = YES;
                        }else{
                            if (!self.pwd1.hidden) {
                                self.pwd1.hidden = YES;
                            }else{
                                
                            }
                        }
                    }
                }
            }
        }
    }
}

-(void)nextBtnPress{
    [tempTextField  resignFirstResponder];
    if (self.payPwdValiteType == V_Set_PayPwdType || self.payPwdValiteType == V_Updata_PayPwdType) {
        if (![tempTextField.text isEqualToString:self.newpayPwd]){
            [[AppUtils shareAppUtils] showHUD:@"您两次输入的支付密码不一致" andView:self.view];
            [self clearPassword];
            return;
        }
        
        if ([self.title isEqualToString:@"设置支付密码"]) {
            [[AppUtils shareAppUtils] saveIsPayPwd:YES];
        }
    }
    
    
    ResultShowView * resultShowView = [ResultShowView showResult:ResultTypeCorrect];
    if (self.payPwdValiteType == V_Set_PayPwdType) {
        resultShowView.desc.text = @"支付密码设置成功";
    }
    else if (self.payPwdValiteType == V_Updata_PayPwdType){
        resultShowView.desc.text = @"支付密码修改成功";
    }
    else if (self.payPwdValiteType == V_Delete_BankCardType){
        resultShowView.desc.text = @"解除绑定成功";
    }
    resultShowView.desc.textColor = main_text_color;
    resultShowView.deleget = self;
    [resultShowView showDialog:self.view];
    
}

#pragma mark ---- ResultShowViewSureDeleget --------
-(void)sure{
    [self.navigationController popViewControllerAnimated:NO];
    if ([self.delegate respondsToSelector:@selector(UIViewControllerBack:)]) {
        [self.delegate performSelector:@selector(UIViewControllerBack:) withObject:self];
    }
}

-(void)clearPassword{
    tempTextField.text = @"";
    self.pwd1.hidden = YES;
    self.pwd2.hidden = YES;
    self.pwd3.hidden = YES;
    self.pwd4.hidden = YES;
    self.pwd5.hidden = YES;
    self.pwd6.hidden = YES;
    self.nextBtn.enabled = NO;
    self.nextBtn.backgroundColor = unable_tap_color;
    [tempTextField becomeFirstResponder];
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
