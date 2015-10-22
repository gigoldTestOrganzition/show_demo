//
//  SetUpPasswordViewController.h
//  gigold
//
//  Created by wsc on 15/10/12.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"

@interface SetUpPasswordViewController : BaseViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *showView1;
@property (weak, nonatomic) IBOutlet UIView *showView2;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *valiteTextField;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (strong, nonatomic) NSString* account;

@end
