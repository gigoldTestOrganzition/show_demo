//
//  OutView.m
//  gigold
//
//  Created by 单小萍 on 15/10/28.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "OutView.h"
@implementation OutView
@synthesize outBtn=_outBtn;
@synthesize cancle = _cancle;
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
        [self initEvent];
    }
    return self;
}

-(void)initUI{
    OutView* contentView = (OutView*)[[NSBundle mainBundle]loadNibNamed:@"OutView" owner:self options:nil][0];
    contentView.frame = CGRectMake(0, 0,mainScreenWidth, contentView.frame.size.height);
    self.outBtn = contentView.outBtn;
    self.cancle = contentView.cancle;
    self.showView = contentView;
}
-(void)initEvent{
    UITapGestureRecognizer* cancleGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stopDialog)];
    _cancle.userInteractionEnabled = YES;
    [_cancle addGestureRecognizer:cancleGestureRecognizer];
    
    UITapGestureRecognizer* sureGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sureOut)];
    _outBtn.userInteractionEnabled = YES;
    [_outBtn addGestureRecognizer:sureGestureRecognizer];
    
}
//确认退出
-(void)sureOut{
    if ([super clickDeleget]){
        [[super clickDeleget] click:OUT_APPLICATION_TAG];
    }
}

@end
