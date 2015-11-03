//
//  IncomeDetailCell.m
//  gigold
//
//  Created by 单小萍 on 15/10/22.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "OrderlCell.h"

@implementation OrderlCell
@synthesize orderType=_orderType;
@synthesize timeLable=_timeLable;
@synthesize amountLable=_amountLable;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
