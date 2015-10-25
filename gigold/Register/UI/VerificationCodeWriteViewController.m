//
//  VerificationCodeWriteViewController.m
//  gigold
//
//  Created by wsc on 15/10/22.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "VerificationCodeWriteViewController.h"
#import "PasswordWriteViewController.h"
#import "PayPasswordViewController.h"

@interface VerificationCodeWriteViewController ()

@end

@implementation VerificationCodeWriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isAgree = YES;
    
    if (self.flowType == ResetPasswordType || self.flowType == UpdataPayPWDType) {
        self.serveTextView.hidden = YES;
        self.next_view_height.constant = 30;
    }
    
    self.validateTextField.delegate = self;
    [self.validateTextField becomeFirstResponder];
    
    [self.nextBtn addTarget:self action:@selector(nextBtnPress) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn.enabled = NO;
    
    UITapGestureRecognizer* sendPress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startTime)];
    [self.sendLabel addGestureRecognizer:sendPress];
    self.sendLabel.userInteractionEnabled = NO;
    
    [self startTime];
    
    [self.agreeBtn addTarget:self action:@selector(agreeBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    self.moblieLabel.text = [NSString stringWithFormat:@"已发送校验码到你的手机%@",[[AppUtils shareAppUtils] encryptMoblieNumber:self.moblieNum]];
    
    // Do any additional setup after loading the view from its nib.
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString* textString = [NSMutableString stringWithString:textField.text];
    [textString replaceCharactersInRange:range withString:string];
    if (textString.length == 0) {
        self.nextBtn.backgroundColor = [UIColor colorWithRed:206/255.0f green:206/255.f blue:206/255.f alpha:1];
        self.nextBtn.enabled = NO;
    }else{
        self.nextBtn.backgroundColor = [UIColor colorWithRed:74/255.0f green:202/255.f blue:226/255.f alpha:1];
        self.nextBtn.enabled = YES;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)startTime{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerValue) userInfo:nil repeats:YES];
    [self timerValue];
}

-(void)timerValue{
    self.sendLabel.text = [NSString stringWithFormat:@"%ld秒后重发",(long)TimeInterval-timeCount];
    timeCount ++;
    if (timeCount  == TimeInterval) {
        [self endTime];
        timeCount = 0;
        self.sendLabel.textColor = [UIColor colorWithRed:74/255.0f green:202/255.f blue:226/255.f alpha:1];
        self.sendLabel.text = @"重新发送";
        self.sendLabel.userInteractionEnabled = YES;
    }else{
        self.sendLabel.userInteractionEnabled = NO;
        self.sendLabel.textColor = [UIColor colorWithRed:214/255.0f green:214/255.f blue:214/255.f alpha:1];
    }
}

-(void)endTime{
    [timer invalidate];
    timer = nil;
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
    NSLog(@"下一步");
    if (self.flowType == UpdataPayPWDType) {
        PayPasswordViewController* payPasswordView = [[PayPasswordViewController alloc] init];
        payPasswordView.delegate = self;
        payPasswordView.title = self.title;
        [self.navigationController pushViewController:payPasswordView animated:YES];
        return;
    }
    
    if (isAgree) {
        PasswordWriteViewController* passwordWriteView = [[PasswordWriteViewController alloc] init];
        passwordWriteView.title = self.title;
        passwordWriteView.flowType = self.flowType;
        passwordWriteView.delegate = self;
        [self.navigationController pushViewController:passwordWriteView animated:YES];
    }else{
        [[AppUtils shareAppUtils] showHUD:@"请先同意服务条款！" andView:self.view];
    }
    
}

-(void)UIViewControllerBack:(BaseViewController *)baseViewController{
    if ([baseViewController isKindOfClass:[PasswordWriteViewController class]]) {
        PasswordWriteViewController* passwordWirteView = (PasswordWriteViewController*)baseViewController;
        self.backType = passwordWirteView.backType;
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
