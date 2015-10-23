//
//  VerificationCodeWriteViewController.h
//  gigold
//
//  Created by wsc on 15/10/22.
//  Copyright © 2015年 wsc. All rights reserved.
//

#define TimeInterval 5

#import "BaseViewController.h"

@interface VerificationCodeWriteViewController : BaseViewController <UITextFieldDelegate>
{
    NSTimer* timer;
    NSInteger timeCount;
    
    BOOL isAgree;
}
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *moblieLabel;
@property (weak, nonatomic) IBOutlet UITextField *validateTextField;
@property (weak, nonatomic) IBOutlet UILabel *sendLabel;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UILabel *serveTextLabel;
@property (weak, nonatomic) IBOutlet UIView *serveTextView;
//输入界面和nextBtn的间隔
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *next_view_height;

@property (assign, nonatomic) FlowType flowType;

//用于显示手机号码
@property (strong,nonatomic) NSString* moblieNum;

@end
