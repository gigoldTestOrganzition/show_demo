//
//  LoginViewController.h
//  gigold
//
//  Created by MacPro on 15-10-10.
//  Copyright (c) 2015年wsc. All rights reserved.
//

#import "MyViewController.h"

@interface LoginViewController : MyViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;

@property (retain,nonatomic)NSString* typeString;

@end
