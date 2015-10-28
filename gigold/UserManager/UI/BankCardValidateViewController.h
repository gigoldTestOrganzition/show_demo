//
//  BankCardValidateViewController.h
//  gigold
//
//  Created by wsc on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomerView.h"

@interface BankCardValidateViewController : BaseViewController <UITextFieldDelegate>
{
    BOOL isAgree;
    
    CustomerView* popView;
}

@property (weak, nonatomic) IBOutlet UIImageView* bankCardImageView;
@property (weak, nonatomic) IBOutlet UILabel* bankCardLabel;
@property (weak, nonatomic) IBOutlet UITextField* moblieNumTextField;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UILabel *serveTextLabel;
@property (weak, nonatomic) IBOutlet UIView *serveTextView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shadowHeight1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shadowHeight2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shadowHeight3;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;


@end
