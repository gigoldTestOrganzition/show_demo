//
//  ValidateViewController.h
//  gigold
//
//  Created by wsc on 15/10/14.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"
#import "RegisterRequest.h"

typedef enum _ValidateType
{
    ResetPWDValidate = 0,
    RegisterValidate
} ValidateType;

@interface ValidateViewController : BaseViewController<UITextFieldDelegate>
{
    NSTimer* timer;
    NSInteger timeCount;
}
@property (weak, nonatomic) IBOutlet UIButton *validateBtn;
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *validateTextField;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (assign, nonatomic)ValidateType validateType;

@end
