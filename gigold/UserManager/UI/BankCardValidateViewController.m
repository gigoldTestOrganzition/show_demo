//
//  BankCardValidateViewController.m
//  gigold
//
//  Created by wsc on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BankCardValidateViewController.h"
#import "VerificationCodeWriteViewController.h"
#import "ServiceTextViewController.h"

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
    
    UITapGestureRecognizer* oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goServeTextView)];
    [self.serveTextView addGestureRecognizer:oneTap];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)goServeTextView{
    NSLog(@"去看服务条款");
    
    if (!popView) {
        UIView* showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, 140)];
        showView.backgroundColor = self.view.backgroundColor;
        
        UIButton* btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.backgroundColor = [UIColor whiteColor];
        btn1.frame = CGRectMake(0, 0, showView.frame.size.width, 45);
        [btn1 setTitle:@"快捷支付服务协议" forState:UIControlStateNormal];
        btn1.titleLabel.font = dialog_font;
        [btn1 setTitleColor:main_text_color forState:UIControlStateNormal];
        [btn1 setTitleColor:main_text_color forState:UIControlStateHighlighted];
        [showView addSubview:btn1];
        
        UIView* shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, btn1.frame.size.height-0.5, btn1.frame.size.width, 0.5)];
        shadowView.backgroundColor = gray_diver_color;
        [btn1 addSubview:shadowView];
        
        UIButton* btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.backgroundColor = [UIColor whiteColor];
        btn2.frame = CGRectMake(0, 45, showView.frame.size.width, 45);
        [btn2 setTitle:@"招行快捷支付协议" forState:UIControlStateNormal];
        btn2.titleLabel.font = dialog_font;
        [btn2 setTitleColor:main_text_color forState:UIControlStateNormal];
        [btn2 setTitleColor:main_text_color forState:UIControlStateHighlighted];
        [showView addSubview:btn2];
        
        shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, btn2.frame.size.height-0.5, btn2.frame.size.width, 0.5)];
        shadowView.backgroundColor = gray_diver_color;
        [btn2 addSubview:shadowView];
        
        UIButton* btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn3.backgroundColor = [UIColor whiteColor];
        btn3.frame = CGRectMake(0, 95, showView.frame.size.width, 45);
        [btn3 setTitle:@"取消" forState:UIControlStateNormal];
        btn3.titleLabel.font = dialog_font;
        [btn3 setTitleColor:main_text_color forState:UIControlStateNormal];
        [btn3 setTitleColor:main_text_color forState:UIControlStateHighlighted];
        [showView addSubview:btn3];
        
        shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, btn3.frame.size.width, 0.5)];
        shadowView.backgroundColor = gray_diver_color;
        [btn3 addSubview:shadowView];
        
        [btn1 addTarget:self action:@selector(popBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 addTarget:self action:@selector(popBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [btn3 addTarget:self action:@selector(popBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        
        popView = [[CustomerView alloc] init];
        popView.showView = showView;
    }
    [popView showDialog:self.view];
}

-(void)popBtnPress:(UIButton*)btn{
    [popView stopDialog];
    if ([btn.titleLabel.text isEqualToString:@"取消"]) {
        
    }else{
        ServiceTextViewController* serviceTextView = [[ServiceTextViewController alloc] init];
        if ([btn.titleLabel.text isEqualToString:@"招行快捷支付协议"]) {
            serviceTextView.serviceTextType = Service_Bank_CMBType;
        }else if ([btn.titleLabel.text isEqualToString:@"快捷支付服务协议"]){
            serviceTextView.serviceTextType = Service_FastPayType;
        }
        [self.navigationController pushViewController:serviceTextView animated:YES];
    }
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

#pragma mark ---- UITextFieldDelegate --------
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
