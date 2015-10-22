//
//  RegisterViewController.h
//  gigold
//
//  Created by wsc on 15/10/16.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController <UITextFieldDelegate>
{
    BOOL isAgree;
}

@property (weak, nonatomic) IBOutlet UIView *showView1;
@property (weak, nonatomic) IBOutlet UIView *showView2;
@property (weak, nonatomic) IBOutlet UITextField *loginPWDTextField;
@property (weak, nonatomic) IBOutlet UITextField *payPWDTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UILabel *serviceLabel;

@property (strong, nonatomic)NSString* account;

@end
