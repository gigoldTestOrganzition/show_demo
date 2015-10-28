//
//  AddBankCardViewController.m
//  gigold
//
//  Created by wsc on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "AddBankCardViewController.h"
#import "BankCardValidateViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface AddBankCardViewController ()

@end

@implementation AddBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加银行卡";
    
    self.shadowHeight1.constant = 0.5;
    self.shadowHeight2.constant = 0.5;
    self.shadowHeight3.constant = 0.5;
    
    self.nameTextField.delegate = self;
    self.cardNumTextField.delegate = self;
    
    [self.nextBtn addTarget:self action:@selector(nextBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark ---- UITextFieldDelegate --------
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString* textString = [NSMutableString stringWithString:textField.text];
    [textString replaceCharactersInRange:range withString:string];
    if ((textField == self.nameTextField && self.cardNumTextField.text.length > 0) || (textField == self.cardNumTextField && self.nameTextField.text.length > 0)) {
        if (textString.length == 0) {
            self.nextBtn.backgroundColor = unable_tap_color;
            self.nextBtn.enabled = NO;
        }else{
            self.nextBtn.backgroundColor = theme_color;
            self.nextBtn.enabled = YES;
        }
    }else{
        self.nextBtn.backgroundColor = unable_tap_color;
        self.nextBtn.enabled = NO;
    }
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.nameTextField) {
        [self.cardNumTextField becomeFirstResponder];
    }else{
        [self nextBtnPress];
    }
    return YES;
}


-(void)nextBtnPress{
    BankCardValidateViewController* bankCardValidateView = [[BankCardValidateViewController alloc] init];
    bankCardValidateView.title = self.title;
    bankCardValidateView.delegate = self;
    [self.navigationController pushViewController:bankCardValidateView animated:YES];
}

#pragma mark ---- BaseViewControllerDelegate --------

-(void)UIViewControllerBack:(BaseViewController *)baseViewController{
    if ([baseViewController isKindOfClass:[BankCardValidateViewController class]]) {
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
