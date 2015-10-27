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
@synthesize pullStyle=_pullStyle;
@synthesize showView=_showView;
-(instancetype)init{
    
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0,0,mainScreenHeight,mainScreenHeight);
        self.pullStyle = PullViewDown;
        self.backGroundColor = default_background;
    }
    return self;
}



-(void)showDialog:(UIView *)view{
    if (![self superview]) {
        self.backgroundColor = _backGroundColor;
        if (_showView&&![_showView superview]) {
            [self addContentView];
        }
        [view addSubview:self];
    }
    [self startPullAnimation];
}

-(void)stopDialog{
    [self startStopAnimation:^(BOOL finish) {
        [self removeFromSuperview];
    }];
}
//添加内容
-(void)addContentView{
    switch (_pullStyle) {
        case PullViewTop:
            _showView.frame = CGRectMake(_showView.frame.origin.x,0-_showView.frame.size.height, _showView.frame.size.width, _showView.frame.size.height);
            break;
        case PullViewDown:
            _showView.frame = CGRectMake(_showView.frame.origin.x,mainScreenHeight,_showView.frame.size.width, _showView.frame.size.height);
            break;
        default:
            _showView.frame = CGRectMake(_showView.frame.origin.x,mainScreenHeight,_showView.frame.size.width, _showView.frame.size.height);
            break;
    }
    _showView.alpha = 0.0f;
    [self addSubview:_showView];
}
/*开启pull动画*/
-(void)startPullAnimation{
    [UIView animateWithDuration:0.5f animations:^{
        switch (_pullStyle) {
            case PullViewTop:
                _showView.frame = CGRectMake(_showView.frame.origin.x,0,_showView.frame.size.width, _showView.frame.size.height);
                break;
            case PullViewDown:
                _showView.frame = CGRectMake(_showView.frame.origin.x,mainScreenHeight-_showView.frame.size.height, _showView.frame.size.width, _showView.frame.size.height);
                break;
            default:
                _showView.frame = CGRectMake(_showView.frame.origin.x,mainScreenHeight-_showView.frame.size.height,_showView.frame.size.width, _showView.frame.size.height);
                break;
        }
        _showView.alpha = 1.0f;
        
        
    }];
}
/*开启结束动画*/
-(void)startStopAnimation:(void(^)(BOOL finish))complete{
    [UIView animateWithDuration:0.5f animations:^{
        
            switch (_pullStyle) {
                case PullViewTop:
                    _showView.frame = CGRectMake(_showView.frame.origin.x,0-_showView.frame.size.height, _showView.frame.size.width, _showView.frame.size.height);
                    break;
                case PullViewDown:
                    _showView.frame = CGRectMake(_showView.frame.origin.x,mainScreenHeight,_showView.frame.size.width, _showView.frame.size.height);
                    break;
                default:
                    _showView.frame = CGRectMake(_showView.frame.origin.x,mainScreenHeight,_showView.frame.size.width,_showView.frame.size.height);
                    break;
            }
            _showView.alpha = 0.0f;
     
        } completion:complete];
}
@end
