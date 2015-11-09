//
//  LifeCell.m
//  gigold
//
//  Created by 单小萍 on 15/11/6.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "LifeCell.h"

@implementation LifeCell
@synthesize businessOwnerNumberView=_businessOwnerNumberView;
@synthesize businessOwnerNumberViewWidthLayoutConstraint=_businessOwnerNumberViewWidthLayoutConstraint;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
