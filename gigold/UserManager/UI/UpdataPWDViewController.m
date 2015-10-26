//
//  UpdataPWDViewController.m
//  gigold
//
//  Created by wsc on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "UpdataPWDViewController.h"

@interface UpdataPWDViewController ()

@end

@implementation UpdataPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.passwordTextField1.delegate = self;
    [self.passwordTextField1 becomeFirstResponder];
    
    self.passwordTextField2.delegate = self;
    
    [self.nextBtn addTarget:self action:@selector(nextBtnPress) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn.enabled = NO;
    
    
    [self.eyeBtn addTarget:self action:@selector(eyeBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view from its nib.
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString* textString = [NSMutableString stringWithString:textField.text];
    [textString replaceCharactersInRange:range withString:string];
    if ((textField == self.passwordTextField1 && self.passwordTextField2.text.length > 0) || (textField == self.passwordTextField2 && self.passwordTextField1.text.length > 0)) {
        if (textString.length == 0) {
            self.nextBtn.backgroundColor = [UIColor colorWithRed:206/255.0f green:206/255.f blue:206/255.f alpha:1];
            self.nextBtn.enabled = NO;
        }else{
            self.nextBtn.backgroundColor = [UIColor colorWithRed:74/255.0f green:202/255.f blue:226/255.f alpha:1];
            self.nextBtn.enabled = YES;
        }
    }else{
        self.nextBtn.backgroundColor = [UIColor colorWithRed:206/255.0f green:206/255.f blue:206/255.f alpha:1];
        self.nextBtn.enabled = NO;
    }
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
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
    [self.navigationController popViewControllerAnimated:NO];
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
