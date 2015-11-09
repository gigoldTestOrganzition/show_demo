//
//  NumberView.m
//  gigold
//
//  Created by 单小萍 on 15/11/9.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "NumberView.h"

@implementation NumberView
@synthesize drawBackGroundColor = _drawBackGroundColor;
@synthesize drawFontColor=_drawFontColor;
@synthesize drawWidth=_drawWidth;
@synthesize drawSpace=_drawSpace;
@synthesize drawFont=_drawFont;
@synthesize drawString = _drawString;
@synthesize drawRadius = _drawRadius;

-(instancetype)init{
    self = [super init];
    if (self) {
        self.drawBackGroundColor = theme_color;
        self.drawFontColor = [UIColor whiteColor];
        self.drawWidth = 10.f;
        self.drawSpace = 2.f;
        self.drawFont = auxiliary_small_font;
        self.drawRadius = 2.f;
    }
    return self;
}
-(void)draw{
    NSUInteger count = _drawString.length;
    CGRect frame = self.frame;
    frame.size.width = count*_drawWidth+(count-1)*_drawSpace;
    self.frame = frame;
    for (int i = 0; i < count; i++) {
        UILabel* itemLable = [[UILabel alloc]initWithFrame:CGRectMake(i*_drawWidth+i*_drawSpace,0.f,_drawWidth,self.frame.size.height)];
        itemLable.layer.masksToBounds = YES;
        itemLable.layer.cornerRadius=_drawRadius;
        itemLable.backgroundColor = _drawBackGroundColor;
        itemLable.textColor = _drawFontColor;
        itemLable.font = _drawFont;
        itemLable.textAlignment = NSTextAlignmentCenter;
        itemLable.text = [_drawString substringWithRange:NSMakeRange(i,1)];
        [self addSubview:itemLable];
    }
}
-(void)awakeFromNib{
    self.drawBackGroundColor = theme_color;
    self.drawFontColor = [UIColor whiteColor];
    self.drawWidth = 15.f;
    self.drawSpace = 3.f;
    self.drawFont = auxiliary_small_font;
    self.drawRadius = 2.f;

}
@end
