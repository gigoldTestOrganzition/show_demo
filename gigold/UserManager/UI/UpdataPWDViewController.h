//
//  UpdataPWDViewController.h
//  gigold
//
//  Created by wsc on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"

@interface UpdataPWDViewController : BaseViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *passwordLabel1;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField1;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel2;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField2;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *eyeBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shadowHeight1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shadowHeight2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shadowHeight3;

@end
