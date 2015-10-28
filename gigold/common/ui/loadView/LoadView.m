//
//  LoadView.m
//  gigold
//
//  Created by 单小萍 on 15/10/28.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "LoadView.h"
@interface LoadView(){
    int currentDegree;
}
@end
@implementation LoadView
@synthesize img = _img;
@synthesize desc = _desc;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
       [self initUI];
    }
    return self;
}
//初始化ui
-(void)initUI{
    
    LoadView* loadView = (LoadView*) [[NSBundle mainBundle] loadNibNamed:@"LoadView" owner:self options:nil][0];
    loadView.layer.cornerRadius = 10;
    self.backGroundColor = [UIColor clearColor];
    self.loadImg = loadView.loadImg;
    self.img = loadView.img;
    self.desc = loadView.desc;
    self.pullStyle = PullViewCenter;
    self.animationTime = 0.f;
    currentDegree = 10;
    self.showView  = loadView;
}
+(LoadView *)showLoad:(LoadViewType)loadViewType view:(UIView *)view{
    LoadView* loadView = [[LoadView alloc]init];
    switch (loadViewType) {
        case LoadViewTypeSafeCheck:{
            loadView.img.hidden = NO;
            loadView.img.image = [UIImage imageNamed:@"pop_safe_ico_1"];
            loadView.desc.text = @"安全检查中";
            loadView.loadImg.image = [UIImage imageNamed:@"pop_safe_ico_2"];
        }
            break;
        case LoadViewTypeJump:{
            loadView.img.hidden = YES;
            loadView.desc.text = @"跳转支付中";
            loadView.loadImg.image = [UIImage imageNamed:@"pop_loading_pci"];
            
        }
        break;
    }
    
    [loadView showDialog:view];
    [loadView startLoadAnimation];
    return loadView;
}
//开启加载动画特效
-(void)startLoadAnimation{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.05f animations:^{
            _loadImg.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(currentDegree));
            currentDegree+=10;
            if (currentDegree>360) {
                currentDegree = 10;
            }

        } completion:^(BOOL finished) {
            [self startLoadAnimation];
        }];
    });
}
@end
