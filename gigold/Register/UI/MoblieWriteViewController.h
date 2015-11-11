//
//  MoblieWriteViewController.h
//  gigold
//
//  Created by wsc on 15/10/22.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"
#import "LoadView.h"
#import "RegisterRequest.h"

@interface MoblieWriteViewController : BaseViewController <UITextFieldDelegate>
{
    LoadView* loadView;
}
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shadowHeight1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shadowHeight2;
@property (strong, nonatomic) NSString* mobileNum;


@property (assign, nonatomic) FlowType flowType;
@property (assign, nonatomic) BackType backType;

@end
