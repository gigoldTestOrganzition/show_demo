//
//  PayPasswordViewController.m
//  gigold
//
//  Created by wsc on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "PayPasswordViewController.h"

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
    self.payView.layer.borderColor = [UIColor colorWithRed:199/255. green:199/255. blue:199/255. alpha:1].CGColor;
    
    UITapGestureRecognizer* oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textFieldResponder)];
    [self.payView addGestureRecognizer:oneTap];
    
    [self.nextBtn addTarget:self action:@selector(nextBtnPress) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn.enabled = NO;

    
    // Do any additional setup after loading the view from its nib.
}

-(void)textFieldResponder{
    if ([tempTextField isFirstResponder]) {
        [tempTextField resignFirstResponder];
    }else{
        [tempTextField becomeFirstResponder];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString* textString = [NSMutableString stringWithString:textField.text];
    [textString replaceCharactersInRange:range withString:string];
    if (textString.length >= 6) {
        self.nextBtn.backgroundColor = [UIColor colorWithRed:74/255.0f green:202/255.f blue:226/255.f alpha:1];
        self.nextBtn.enabled = YES;
    }else{
        self.nextBtn.backgroundColor = [UIColor colorWithRed:206/255.0f green:206/255.f blue:206/255.f alpha:1];
        self.nextBtn.enabled = NO;
    }
    
    [self showMarkView:string];
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
