//
//  OutView.h
//  gigold
//
//  Created by 单小萍 on 15/10/28.
//  Copyright © 2015年 wsc. All rights reserved.
//
// 退出程序
#define OUT_APPLICATION_TAG @"outApplication"
#import "CustomerView.h"

@interface OutView : CustomerView
@property (weak, nonatomic) IBOutlet UIButton *outBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancle;
@end
