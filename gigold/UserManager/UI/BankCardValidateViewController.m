//
//  BankCardValidateViewController.m
//  gigold
//
//  Created by wsc on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BankCardValidateViewController.h"
#import "VerificationCodeWriteViewController.h"

@interface BankCardValidateViewController ()

@end

@implementation BankCardValidateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shadowHeight1.constant = 0.5;
    self.shadowHeight2.constant = 0.5;
    self.shadowHeight3.constant = 0.5;
    
    isAgree = YES;
    
    self.moblieNumTextField.delegate = self;
    
    [self.agreeBtn addTarget:self action:@selector(agreeBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    [self.nextBtn addTarget:self action:@selector(nextBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)agreeBtnPress{
    isAgree = !isAgree;
    if (isAgree) {
        [self.agreeBtn setImage:[UIImage imageNamed:@"protocol_but_1"] forState:UIControlStateNormal];
    }else{
        [self.agreeBtn setImage:[UIImage imageNamed:@"protocol_but_2"] forState:UIControlStateNormal];
    }
}

-(void)nextBtnPress{
    if ([[AppUtils shareAppUtils] validateMobile:self.moblieNumTextField.text]){
        VerificationCodeWriteViewController* verificationCodeWriteView = [[VerificationCodeWriteViewController alloc] init];
        verificationCodeWriteView.title = self.title;
        verificationCodeWriteView.moblieNum = self.moblieNumTextField.text;
        verificationCodeWriteView.flowType = AddBankCardType;
        verificationCodeWriteView.delegate = self;
        [self.navigationController pushViewController:verificationCodeWriteView animated:YES];
    }else{
        [[AppUtils shareAppUtils] showHUD:@"请输入正确的手机号码！" andView:self.view];
        [self.moblieNumTextField becomeFirstResponder];
    }
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString* textString = [NSMutableString stringWithString:textField.text];
    [textString replaceCharactersInRange:range withString:string];
    if (textString.length == 0) {
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

#pragma mark ---- BaseViewControllerDelegate --------

-(void)UIViewControllerBack:(BaseViewController *)baseViewController{
    if ([baseViewController isKindOfClass:[VerificationCodeWriteViewController class]]) {
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
