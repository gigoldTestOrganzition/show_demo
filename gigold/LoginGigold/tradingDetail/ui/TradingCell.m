//
//  TradingCell.m
//  gigold
//
//  Created by 单小萍 on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "TradingCell.h"

@implementation TradingCell
@synthesize type=_type;
@synthesize time=_time;
@synthesize amountLable=_amountLable;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
