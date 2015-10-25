//
//  MoblieWriteViewController.h
//  gigold
//
//  Created by wsc on 15/10/22.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"

@interface MoblieWriteViewController : BaseViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (assign, nonatomic) FlowType flowType;
@property (assign, nonatomic) BackType backType;

@end
