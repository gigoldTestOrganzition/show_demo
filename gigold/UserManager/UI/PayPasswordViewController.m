//
//  PayPasswordViewController.m
//  gigold
//
//  Created by wsc on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "PayPasswordViewController.h"
#import "PayPwdValidateViewController.h"
#import "appliacation_attribute.h"
#import "RollInResultViewController.h"
@interface PayPasswordViewController ()

@end

@implementation PayPasswordViewController

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
    
    if (self.payPwdType == SetOldPayPwdType) {
        if ([self.title isEqualToString:@"设置支付密码"]) {
        }else{
            self.titleLabel.text = @"请输入6位数字旧支付密码";
        }
    }else if(self.payPwdType != RollInPayPwdType&&self.payPwdType != RollOutPayPwdType){
        if ([self.title isEqualToString:@"设置支付密码"]) {
            self.titleLabel.text = @"请输入6位数字支付密码";
        }else{
            self.titleLabel.text = @"请输入新的6位数字支付密码";
        }
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
    
    if (textString.length == 6){
        if (self.payPwdType == SetOldPayPwdType){
            PayPasswordViewController* payPasswordView = [[PayPasswordViewController alloc] init];
            payPasswordView.delegate = self;
            payPasswordView.title = self.title;
            payPasswordView.payPwdType = SetNewPayPwdType;
            [self.navigationController pushViewController:payPasswordView animated:YES];
        }else if(self.payPwdType == RollInPayPwdType){
            RollInResultViewController* rollInResultViewController = storyboard_controller_identity(@"GigoldTreasureHome", @"rollInResult");
            rollInResultViewController.parames = self.parames;
            [self.navigationController pushViewController:rollInResultViewController animated:YES];
        }else if(self.payPwdType ==  RollOutPayPwdType){
            RollInResultViewController* rollInResultViewController = storyboard_controller_identity(@"GigoldTreasureHome", @"rollOutResult");
            rollInResultViewController.parames = self.parames;
            [self.navigationController pushViewController:rollInResultViewController animated:YES];
            
        }else{
            PayPwdValidateViewController* payValiteView = [[PayPwdValidateViewController alloc] init];
            payValiteView.delegate = self;
            payValiteView.title = self.title;
            if ([self.title isEqualToString:@"设置支付密码"]) {
                payValiteView.payPwdValiteType = V_Set_PayPwdType;
            }else{
                payValiteView.payPwdValiteType = V_Update_PayPwdType;
            }
            payValiteView.newpayPwd = textString;
            [self.navigationController pushViewController:payValiteView animated:YES];
        }
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


-(void)clearPassword{
    tempTextField.text = @"";
    self.pwd1.hidden = YES;
    self.pwd2.hidden = YES;
    self.pwd3.hidden = YES;
    self.pwd4.hidden = YES;
    self.pwd5.hidden = YES;
    self.pwd6.hidden = YES;
    [tempTextField becomeFirstResponder];
}

#pragma mark ---- BaseViewControllerDelegate --------

-(void)UIViewControllerBack:(BaseViewController *)baseViewController{
    if ([baseViewController isKindOfClass:[PayPasswordViewController class]]) {
        [self.navigationController popViewControllerAnimated:NO];
        if ([self.delegate respondsToSelector:@selector(UIViewControllerBack:)]) {
            [self.delegate performSelector:@selector(UIViewControllerBack:) withObject:self];
        }
    }else if ([baseViewController isKindOfClass:[PayPwdValidateViewController class]]){
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
