//
//  CustomerView.m
//  gigold
//
//  Created by 单小萍 on 15/10/26.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "CustomerView.h"

@implementation CustomerView
@synthesize backGroundColor=_backGroundColor;
@synthesize pullStyle = _pullStyle;
@synthesize showView = _showView;
@synthesize clickDeleget = _clickDeleget;
@synthesize baseLineValue = _baseLineValue;
@synthesize animationTime = _animationTime;
-(instancetype)init{
    
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0,0,mainScreenWidth,mainScreenHeight-44.f-STATUSBAR_OFFSET);
        self.layer.masksToBounds = YES;
        self.animationTime = 0.5f;
        self.baseLineValue = 0.f;
        self.pullStyle = PullViewDown;
        self.backGroundColor = default_background;
    }
    return self;
}

-(BOOL)isShow{
    if ([self superview]) {
        return YES;
    }
    return NO;
}

-(void)showDialog:(UIView *)view{
    [self showDialogByBaseLine:0 view:view];
}
-(void)showDialogByBaseLine:(CGFloat)baseLineValue view:(UIView *)view{
    self.baseLineValue = baseLineValue;
    if (![self superview]) {
        self.backgroundColor = _backGroundColor;
        if (_showView&&![_showView superview]) {
            [self addContentView];
        }
        [view addSubview:self];
    }
    [self startPullAnimation];
}
-(void)showDialogByViewBottom:(UIView *)view{
    self.pullStyle = PullViewTop;
    CGFloat baseLine = view.frame.size.height+view.frame.origin.y;
    [self showDialogByBaseLine:baseLine view:[view superview]];
}
-(void)showDialogByViewTop:(UIView *)view{
    self.pullStyle = PullViewDown;
    CGFloat baseLine = view.frame.origin.y;
    [self showDialogByBaseLine:baseLine view:[view superview]];
}
-(void)showDialogByViewLeft:(UIView *)view{
    self.pullStyle = PullviewRight;
    CGFloat baseLine = view.frame.origin.x;
    [self showDialogByBaseLine:baseLine view:view];
}
-(void)showDialogByViewRight:(UIView *)view{
    self.pullStyle = PullViewLeft;
    CGFloat baseLine = view.frame.origin.x+view.frame.size.width;
    [self showDialogByBaseLine:baseLine view:view];
}

-(void)stopDialog{
    [self startStopAnimation:^(BOOL finish) {
        [self removeFromSuperview];
        [_showView removeFromSuperview];
    }];
}
//添加内容
-(void)addContentView{
    
    [self initContentView];
    [self addSubview:_showView];
}
-(void)initContentView{
    switch (_pullStyle){
        case PullViewTop:{
            if (_baseLineValue!=0) {
                self.frame =
                CGRectMake(0,_baseLineValue,mainScreenWidth,mainScreenHeight-_baseLineValue-44.f-STATUSBAR_OFFSET);
            }else{
                self.frame =
                CGRectMake(0,0,mainScreenWidth,mainScreenHeight-44.f-STATUSBAR_OFFSET);
                
            }
            _showView.frame = CGRectMake(_showView.frame.origin.x,0 -_showView.frame.size.height, _showView.frame.size.width,_showView.frame.size.height);
        }
            break;
        case PullViewDown:{
            if (_baseLineValue!=0) {
                self.frame =
                CGRectMake(0,0,mainScreenWidth,_baseLineValue);
            }else{
                self.frame =
                CGRectMake(0,0,mainScreenWidth,mainScreenHeight-44.f-STATUSBAR_OFFSET);
                
            }
            _showView.frame = CGRectMake(_showView.frame.origin.x,self.frame.size.height,_showView.frame.size.width,_showView.frame.size.height);
        }
            break;
        case PullViewCenter:
            _showView.center = CGPointMake(mainScreenWidth/2,(mainScreenHeight-44.f-STATUSBAR_OFFSET)/2);
            break;
        case PullViewLeft:{
            if (_baseLineValue != 0){
                self.frame =
                CGRectMake(_baseLineValue,0,mainScreenWidth-_baseLineValue,mainScreenHeight-44.f-STATUSBAR_OFFSET);
            }else{
                self.frame =
                CGRectMake(0,0,mainScreenWidth,mainScreenHeight-44.f-STATUSBAR_OFFSET);
                
            }
            _showView.frame = CGRectMake(0-_showView.frame.size.width,_showView.frame.origin.y,_showView.frame.size.width,_showView.frame.size.height);
        }
            break;
        case PullviewRight:{
            if (_baseLineValue != 0){
                self.frame =
                CGRectMake(0,0,_baseLineValue,mainScreenHeight-44.f-STATUSBAR_OFFSET);
            }else{
                self.frame =
                CGRectMake(0,0,mainScreenWidth,mainScreenHeight-44.f-STATUSBAR_OFFSET);
                
            }
            _showView.frame = CGRectMake(self.frame.size.width,_showView.frame.origin.y,_showView.frame.size.width,_showView.frame.size.height);
        }
            break;
        default:{
            if (_baseLineValue!=0) {
                self.frame =
                CGRectMake(0,0,mainScreenWidth,_baseLineValue);
            }else{
                self.frame =
                CGRectMake(0,0,mainScreenWidth,mainScreenHeight-44.f-STATUSBAR_OFFSET);
            
            }
            _showView.frame = CGRectMake(_showView.frame.origin.x,self.frame.size.height,_showView.frame.size.width,_showView.frame.size.height);
        }
        break;
    }
    _showView.alpha = 0.0f;
}
/*开启pull动画*/
-(void)startPullAnimation{
    [UIView animateWithDuration:_animationTime animations:^{
        switch (_pullStyle) {
            case PullViewTop:
                _showView.frame = CGRectMake(_showView.frame.origin.x,0,_showView.frame.size.width, _showView.frame.size.height);
                break;
            case PullViewDown:
                _showView.frame = CGRectMake(_showView.frame.origin.x,self.frame.size.height-_showView.frame.size.height, _showView.frame.size.width,_showView.frame.size.height);
                break;
            case PullViewCenter:
                break;
            case PullViewLeft:
                _showView.frame = CGRectMake(0,_showView.frame.origin.y,_showView.frame.size.width,_showView.frame.size.height);
                break;
            case PullviewRight:
                _showView.frame = CGRectMake(self.frame.size.width-_showView.frame.size.width,_showView.frame.origin.y,_showView.frame.size.width,_showView.frame.size.height);
                break;
            default:
                _showView.frame = CGRectMake(_showView.frame.origin.x,self.frame.size.height-_showView.frame.size.height, _showView.frame.size.width,_showView.frame.size.height);
                break;
        }
        _showView.alpha = 1.0f;
        
        
    }];
}
/*开启结束动画*/
-(void)startStopAnimation:(void(^)(BOOL finish))complete{
    [UIView animateWithDuration:_animationTime animations:^{
        [self initContentView];
     } completion:complete];
}

@end
