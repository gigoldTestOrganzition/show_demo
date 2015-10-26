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
    
    self.mobileTextField.text = @"15111111111";
    self.mobileTextField.delegate = self;
    [self.mobileTextField becomeFirstResponder];
    
    [self.nextBtn addTarget:self action:@selector(nextBtnPress) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn.enabled = NO;
    
    // Do any additional setup after loading the view from its nib.
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

-(void)nextBtnPress{
    NSLog(@"下一步");
    
    if ([[AppUtils shareAppUtils] validateMobile:self.mobileTextField.text]) {
        VerificationCodeWriteViewController* verificationCodeWriteView = [[VerificationCodeWriteViewController alloc] init];
        verificationCodeWriteView.title = self.title;
        verificationCodeWriteView.moblieNum = self.mobileTextField.text;
        verificationCodeWriteView.flowType = self.flowType;
        verificationCodeWriteView.delegate = self;
        [self.navigationController pushViewController:verificationCodeWriteView animated:YES];
    }else{
        [[AppUtils shareAppUtils] showHUD:@"请输入正确的手机号码！" andView:self.view];
        [self.mobileTextField becomeFirstResponder];
    }
    
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
