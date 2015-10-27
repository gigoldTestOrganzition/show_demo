//
//  ResultShowView.m
//  gigold
//
//  Created by 单小萍 on 15/10/27.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "ResultShowView.h"
#import "ResultShowView.h"
#import "AutomaticArcView.h"
@interface ResultShowView()<AutomaticArcViewDeleget>{
    AutomaticArcView* automaticArcView;
}
@end
@implementation ResultShowView
@synthesize showImg=_showImg;
@synthesize desc=_desc;
@synthesize actionBtn = _actionBtn;
@synthesize deleget =_deleget;
@synthesize addAutomicView = _addAutomicView;
-(instancetype)init{
    self = [super init];
    if (self) {
        [self initUI];
        [self initEvent];
    }
    return self;
}
//初始化UI
-(void)initUI{
    
    ResultShowView* resultShowView = [[NSBundle mainBundle]loadNibNamed:@"ResultShowView" owner:self options:nil][0];
    resultShowView.frame = CGRectMake(0,0, mainScreenWidth, resultShowView.frame.size.height);
    
    self.showImg = resultShowView.showImg;
    self.desc = resultShowView.desc;
    self.actionBtn = resultShowView.actionBtn;
    self.showView = resultShowView;
    
    self.addAutomicView = resultShowView.addAutomicView;
    automaticArcView = [[AutomaticArcView alloc]initWithFrame:_addAutomicView.bounds];
    automaticArcView.deleget =  self;
    [_addAutomicView addSubview:automaticArcView];
    
    _showImg.hidden = YES;
    _desc.hidden = YES;

}
-(void)initEvent{
    UITapGestureRecognizer* actionRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sureAction)];
    _actionBtn.userInteractionEnabled = YES;
    [_actionBtn addGestureRecognizer:actionRecognizer];
}
-(void)sureAction{
    [self stopDialog];
    if(_deleget) {
        [_deleget sure];
    }
}
-(void)showDialog:(UIView *)view{
    _showImg.hidden = YES;
    _desc.hidden = YES;
    [super showDialog:view];
    dispatch_async(dispatch_get_main_queue(), ^{
        [automaticArcView showAnimation];
    });
}
#pragma mark -AutomaticArcViewDeleget 协议 
-(void)automaticArcViewEndDraw{
    _showImg.hidden = NO;
    _desc.hidden = NO;
}
@end
