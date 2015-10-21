//
//  ResetPasswordViewController.h
//  gigold
//
//  Created by wsc on 15/10/12.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "MyViewController.h"

@interface ResetPasswordViewController : MyViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *showView1;
@property (weak, nonatomic) IBOutlet UIView *showView2;
@property (weak, nonatomic) IBOutlet UIView *showView3;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UITextField *oldpasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *newpasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *validateTextField;

@end
