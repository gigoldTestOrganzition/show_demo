//
//  MoblieWriteViewController.m
//  gigold
//
//  Created by wsc on 15/10/22.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "MoblieWriteViewController.h"
#import "VerificationCodeWriteViewController.h"

@interface MoblieWriteViewController ()

@end

@implementation MoblieWriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.flowType == RegisterType) {
        self.title = @"用户注册";
    }else{
        self.title = @"重置登录密码";
    }
    
    self.shadowHeight1.constant = 0.5;
    self.shadowHeight2.constant = 0.5;
    
    self.mobileTextField.delegate = self;
    [self.mobileTextField becomeFirstResponder];
    self.mobileTextField.text = self.mobileNum;
    
    [self.nextBtn addTarget:self action:@selector(nextBtnPress) forControlEvents:UIControlEventTouchUpInside];

    if (self.mobileTextField.text.length != 11) {
        self.nextBtn.backgroundColor = unable_tap_color;
        self.nextBtn.enabled = NO;
    }else{
        self.nextBtn.backgroundColor = theme_color;
        self.nextBtn.enabled = YES;
    }
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark ---- UITextFieldDelegate --------
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString* textString = [NSMutableString stringWithString:textField.text];
    [textString replaceCharactersInRange:range withString:string];
    if (textString.length != 11) {
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

-(void)nextBtnPress{
    NSLog(@"下一步");
    
    if ([[AppUtils shareAppUtils] validateMobile:self.mobileTextField.text]) {
        if (!loadView) {
            if (self.flowType == ResetPasswordType) {
               loadView = [LoadView showLoad:LoadViewTypeSafeCheck view:self.view];
            }else{
                loadView = [LoadView showLoad:LoadViewTypeJump view:self.view];
                loadView.desc.text = @"发送验证码中";
            }
        }else{
            [loadView showDialog:self.view];
        }
        [[RegisterRequest sharedRegisterRequest] validateMoblieNum:self.mobileTextField.text BusinessType:self.flowType success:^(AFHTTPRequestOperation * operation, id responseObject) {
            [loadView stopDialog];
            NSString* rspCd = [responseObject objectForKey:@"rspCd"];
            NSString* rspInf = [responseObject objectForKey:@"rspInf"];
            if ([rspCd isEqualToString:@"00000"]) {
                [[AppUtils shareAppUtils] showHUD:rspInf andView:self.view];
                VerificationCodeWriteViewController* verificationCodeWriteView = [[VerificationCodeWriteViewController alloc] init];
                verificationCodeWriteView.title = self.title;
                verificationCodeWriteView.moblieNum = self.mobileTextField.text;
                verificationCodeWriteView.flowType = self.flowType;
                verificationCodeWriteView.delegate = self;
                [self.navigationController pushViewController:verificationCodeWriteView animated:YES];
            }else{
                [[AppUtils shareAppUtils] showHUD:rspInf andView:self.view];
            }
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error, id responseObject) {
            [loadView stopDialog];
            [[AppUtils shareAppUtils] showHUD:@"发送验证码失败" andView:self.view];
        }];
        
        
    }else{
        [[AppUtils shareAppUtils] showHUD:@"请输入正确的手机号码！" andView:self.view];
        [self.mobileTextField becomeFirstResponder];
    }
    
}

-(void)stopLoadView{
    [loadView stopDialog];
    VerificationCodeWriteViewController* verificationCodeWriteView = [[VerificationCodeWriteViewController alloc] init];
    verificationCodeWriteView.title = self.title;
    verificationCodeWriteView.moblieNum = self.mobileTextField.text;
    verificationCodeWriteView.flowType = self.flowType;
    verificationCodeWriteView.delegate = self;
    [self.navigationController pushViewController:verificationCodeWriteView animated:YES];
}

#pragma mark ---- BaseViewControllerDelegate --------

-(void)UIViewControllerBack:(BaseViewController *)baseViewController{
    if ([baseViewController isKindOfClass:[VerificationCodeWriteViewController class]]) {
        VerificationCodeWriteViewController* verificationCodeWriteView = (VerificationCodeWriteViewController*)baseViewController;
        self.backType = verificationCodeWriteView.backType;
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
