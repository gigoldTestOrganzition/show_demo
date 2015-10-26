//
//  CustomerView.h
//  gigold
//
//  Created by 单小萍 on 15/10/26.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#define default_background kColorWithRGB(0.f,0.f,0.f,0.4)
/*自定义view弹出方式*/
typedef NS_ENUM(NSInteger,PullViewStyle){
    PullViewDown = 1 << 0,
    PullViewTop = 1 << 1
};
@interface CustomerView : UIView
@property(nonatomic,assign)PullViewStyle pullStyle;
@property(nonatomic,strong)UIColor* backGroundColor;
@property(nonatomic,strong)UIView* showView;
-(void)showDialog:(UIView*)view;
-(void)stopDialog;
@end
