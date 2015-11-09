//
//  NumberView.h
//  gigold
//
//  Created by 单小萍 on 15/11/9.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 *自定义number绘制
 */
@interface NumberView : UIView
/*绘制背景颜色*/
@property(nonatomic,strong)UIColor* drawBackGroundColor;
/*绘制的字体颜色*/
@property(nonatomic,strong)UIColor* drawFontColor;
/*绘制字符串*/
@property(nonatomic,copy)NSString* drawString;
/*每个字符串绘制的宽*/
@property(nonatomic,assign)CGFloat drawWidth;
/*绘制的间隔*/
@property(nonatomic,assign)CGFloat drawSpace;
/*绘制的字体*/
@property(nonatomic,strong)UIFont* drawFont;
/*绘制的弧度*/
@property(nonatomic,assign)CGFloat drawRadius;
//绘制
-(void)draw;
@end
