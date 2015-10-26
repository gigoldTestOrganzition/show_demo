//
//  PasswordWriteViewController.h
//  gigold
//
//  Created by wsc on 15/10/22.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"

@interface PasswordWriteViewController : BaseViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *eyeBtn;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelWidth;


@property (assign, nonatomic) FlowType flowType;
@property (assign, nonatomic) BackType backType;

@end
