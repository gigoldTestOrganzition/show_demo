//
//  PayPasswordViewController.h
//  gigold
//
//  Created by wsc on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

//
typedef enum _PayPwdType
{
    SetOldPayPwdType = 1 << 0,
    SetNewPayPwdType = 1 << 1,
    RollInPayPwdType = 1 << 2,
    RollOutPayPwdType = 1 << 3
    
    
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

@property (strong, nonatomic) NSString* newpayPwd;
@property (assign, nonatomic) PayPwdType payPwdType;
//带来的参数
@property (nonatomic,strong)NSMutableDictionary* parames;

@end
