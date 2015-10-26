//
//  PayPasswordViewController.h
//  gigold
//
//  Created by wsc on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

//登录功能
typedef enum _PayPwdType
{
    SetOldPayPwdType = 0,
    SetNewPayPwdType,
    ValidatePayPwdType,
    
} PayPwdType;

#import "BaseViewController.h"


@interface PayPasswordViewController : BaseViewController <UITextFieldDelegate>
{
    UITextField* tempTextField;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *payView;
@property (weak, nonatomic) IBOutlet UIView *pwd1;
@property (weak, nonatomic) IBOutlet UIView *pwd2;
@property (weak, nonatomic) IBOutlet UIView *pwd3;
@property (weak, nonatomic) IBOutlet UIView *pwd4;
@property (weak, nonatomic) IBOutlet UIView *pwd5;
@property (weak, nonatomic) IBOutlet UIView *pwd6;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (strong, nonatomic) NSString* newpayPwd;
@property (assign, nonatomic) PayPwdType payPwdType;

@end
