//
//  PayPwdValidateViewController.h
//  gigold
//
//  Created by wsc on 15/10/28.
//  Copyright © 2015年 wsc. All rights reserved.
//

typedef enum _PayPwdValiteType
{
    V_Set_PayPwdType = 0,
    V_Updata_PayPwdType,
    V_Delete_BankCardType,
} PayPwdValiteType;

#import "BaseViewController.h"
#import "ResultShowView.h"

@interface PayPwdValidateViewController : BaseViewController <UITextFieldDelegate,ResultShowViewSureDeleget>
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
@property (assign, nonatomic) PayPwdValiteType payPwdValiteType;

@end
