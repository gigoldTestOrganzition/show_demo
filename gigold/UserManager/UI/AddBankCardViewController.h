//
//  AddBankCardViewController.h
//  gigold
//
//  Created by wsc on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"

@interface AddBankCardViewController : BaseViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *cardNumTextField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shadowHeight1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shadowHeight2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shadowHeight3;


@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end
