//
//  LifeCell.h
//  gigold
//
//  Created by 单小萍 on 15/11/6.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberView.h"
@interface LifeCell : UITableViewCell
//业主数量
@property (weak, nonatomic) IBOutlet NumberView *businessOwnerNumberView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *businessOwnerNumberViewWidthLayoutConstraint;
@end
