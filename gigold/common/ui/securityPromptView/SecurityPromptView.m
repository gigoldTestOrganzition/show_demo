//
//  SecurityPromptView.m
//  gigold
//
//  Created by 单小萍 on 15/10/28.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "SecurityPromptView.h"

@implementation SecurityPromptView
@synthesize img = _img;
@synthesize desc = _desc;
@synthesize reson = _reson;
@synthesize setBtn = _setBtn;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init{
    self = [super init];
    if (self) {
        [self initUI];
        [self initEvent];
    }
    return self;
}
-(void)initUI{
   SecurityPromptView*  securityPromptView = (SecurityPromptView*)[[NSBundle mainBundle] loadNibNamed:@"SecurityPromptView" owner:self options:nil][0];
    securityPromptView.frame = CGRectMake(0, 0, mainScreenWidth, securityPromptView.frame.size.height);
    self.img = securityPromptView.img;
    self.desc = securityPromptView.desc;
    self.reson = securityPromptView.reson;
    self.setBtn = securityPromptView.setBtn;
    self.showView = securityPromptView;
}
-(void)initEvent{
    UITapGestureRecognizer* setBtnGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setSetPwd)];
    _setBtn.userInteractionEnabled = YES;
    [_setBtn addGestureRecognizer:setBtnGestureRecognizer];
}
//设置支付密码
-(void)setSetPwd{
    [self stopDialog];
    if ([super clickDeleget]) {
        [[super clickDeleget] click:SET_PAYPWD_TAG];
    }
}
@end
