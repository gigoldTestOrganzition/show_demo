//
//  ResultShowView.h
//  gigold
//
//  Created by 单小萍 on 15/10/27.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutomaticArcView.h"
#import "CustomerView.h"

typedef NS_ENUM(NSInteger,ResultType){
    ResultTypeCorrect = 1 << 0,
    ResultTypeError = 1 << 1
};
@protocol ResultShowViewSureDeleget <NSObject>
-(void)sure;
@end

@interface ResultShowView : CustomerView
@property (weak, nonatomic) IBOutlet UIView *addAutomicView;
//显示img
@property (weak, nonatomic) IBOutlet UIImageView *showImg;
//描述
@property (weak, nonatomic) IBOutlet UILabel *desc;
//响应按钮
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;
//代理响应
@property (weak, nonatomic) id<ResultShowViewSureDeleget> deleget;
//绘制时间
@property (assign,nonatomic)CGFloat drawTime;
@property (strong,nonatomic)AutomaticArcView* automaticArcView;

//显示
+(ResultShowView*)showResult:(ResultType)resultType;
@end
