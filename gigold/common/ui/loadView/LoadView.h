//
//  LoadView.h
//  gigold
//
//  Created by 单小萍 on 15/10/28.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "CustomerView.h"
typedef NS_ENUM(NSInteger,LoadViewType){
    //安全检查
    LoadViewTypeSafeCheck,
    //跳转
    LoadViewTypeJump
};
@interface LoadView : CustomerView
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIImageView *loadImg;
+(LoadView*)showLoad:(LoadViewType)loadViewType view:(UIView*)view;
@end
