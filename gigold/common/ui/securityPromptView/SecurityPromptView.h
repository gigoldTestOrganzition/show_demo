//
//  SecurityPromptView.h
//  gigold
//
//  Created by 单小萍 on 15/10/28.
//  Copyright © 2015年 wsc. All rights reserved.

//设置支付密码
#define SET_PAYPWD_TAG @"setPayPwd"
#import "CustomerView.h"

@interface SecurityPromptView : CustomerView
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *reson;
@property (weak, nonatomic) IBOutlet UIButton *setBtn;
@end
