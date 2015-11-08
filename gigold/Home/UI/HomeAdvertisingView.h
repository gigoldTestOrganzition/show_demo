//
//  HomeAdvertisingView.h
//  gigold
//
//  Created by 单小萍 on 15/11/6.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeAdvertisingView : UIView
//展示的广告数组
@property(nonatomic,strong)NSArray* imgArray;
//滑动
@property (strong, nonatomic) UIScrollView *imageScrollView;
@property (strong, nonatomic) UIPageControl *pageController;
//更新frame
-(void)updataFrame:(CGRect)frame;
@end
