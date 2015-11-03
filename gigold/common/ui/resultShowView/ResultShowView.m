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

}
@end
@implementation ResultShowView
@synthesize showImg=_showImg;
@synthesize desc=_desc;
@synthesize actionBtn = _actionBtn;
@synthesize deleget =_deleget;
@synthesize addAutomicView = _addAutomicView;
@synthesize drawTime = _drawTime;
@synthesize automaticArcView = _automaticArcView;
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
    _automaticArcView = [[AutomaticArcView alloc]initWithFrame:_addAutomicView.bounds];
    _automaticArcView.deleget =  self;
    [_addAutomicView addSubview:_automaticArcView];
    
    _showImg.hidden = YES;
    _desc.hidden = YES;

}
-(void)setDrawTime:(CGFloat)drawTime{
    _automaticArcView.drawTime = drawTime;
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

-(void)showDialogByBaseLine:(CGFloat)baseLineValue view:(UIView *)view{
    _showImg.hidden = YES;
    _desc.hidden = YES;
    [super showDialogByBaseLine:baseLineValue view:view];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_automaticArcView showAnimation];
    });
}
+(ResultShowView *)showResult:(ResultType)resultType{
    ResultShowView* resultShowView = [[ResultShowView alloc]init];
    switch (resultType) {
        case ResultTypeCorrect:
            resultShowView.showImg.image = [UIImage imageNamed:@"main_correct_ico2"];
            resultShowView.automaticArcView.strokeColor = UIColorFromRGB(0x84CC34);
            break;
        case ResultTypeError:
            resultShowView.showImg.image = [UIImage imageNamed:@"main_error_ico2"];
            resultShowView.automaticArcView.strokeColor = UIColorFromRGB(0xE56767);
            break;
        default:
            resultShowView.showImg.image = [UIImage imageNamed:@"main_correct_ico2"];
            break;
    }
    return resultShowView;
}

#pragma mark -AutomaticArcViewDeleget 协议 
-(void)automaticArcViewEndDraw{
    _showImg.hidden = NO;
    _desc.hidden = NO;
}
@end
