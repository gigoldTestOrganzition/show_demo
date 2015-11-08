//
//  LifeItemCell.h
//  gigold
//
//  Created by 单小萍 on 15/11/7.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LifeItemCell : UICollectionViewCell
//显示
@property (weak, nonatomic) IBOutlet UIImageView *img;
//描述
@property (weak, nonatomic) IBOutlet UILabel *desc;
//间距
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distance;

@end
