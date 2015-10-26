//
//  PasswordWriteViewController.m
//  gigold
//
//  Created by wsc on 15/10/22.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "PasswordWriteViewController.h"

@interface PasswordWriteViewController ()

@end

@implementation PasswordWriteViewController

-(void)viewWillAppear:(BOOL)animated{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    //    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
}

-(void)backBtnPress{
    [self.navigationController popViewControllerAnimated:NO];
    self.backType = cancelType;
    if ([self.delegate respondsToSelector:@selector(UIViewControllerBack:)]) {
        [self.delegate performSelector:@selector(UIViewControllerBack:) withObject:self];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.flowType == ResetPasswordType){
        self.markLabel.hidden = YES;
        self.titleLabel.text = @"新密码";
        self.titleLabelWidth.constant = 45;
    }
    
    self.passwordTextField.delegate = self;
    [self.passwordTextField becomeFirstResponder];
    
    [self.nextBtn addTarget:self action:@selector(nextBtnPress) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn.enabled = NO;
    
    
    [self.eyeBtn addTarget:self action:@selector(eyeBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
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



-(void)eyeBtnPress{
    if (self.passwordTextField.secureTextEntry == YES) {
        [self.eyeBtn setImage:[UIImage imageNamed:@"password_eye_1"] forState:UIControlStateNormal];
    }else{
        [self.eyeBtn setImage:[UIImage imageNamed:@"password_eye_2"] forState:UIControlStateNormal];
    }
    self.passwordTextField.secureTextEntry = !self.passwordTextField.secureTextEntry;
}

-(void)nextBtnPress{
    if ([[AppUtils shareAppUtils] validateLoginPassword:self.passwordTextField.text]) {
         NSLog(@"成功");
        [self.navigationController popViewControllerAnimated:NO];
        self.backType = FinishType;
        if (self.flowType == RegisterType) {
            [self loginRespond:self.moblieNum andPassword:self.passwordTextField.text];
        }
        if ([self.delegate respondsToSelector:@selector(UIViewControllerBack:)]) {
            [self.delegate performSelector:@selector(UIViewControllerBack:) withObject:self];
        }
    }else{
        [[AppUtils shareAppUtils] showHUD:@"请输入正确的密码！" andView:self.view];
        [self.passwordTextField becomeFirstResponder];
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
