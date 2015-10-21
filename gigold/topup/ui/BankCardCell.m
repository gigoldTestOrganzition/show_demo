//
//  BankCardCell.m
//  gigold
//
//  Created by 单小萍 on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BankCardCell.h"

@implementation BankCardCell
@synthesize bankImg=_bankImg;
@synthesize name=_name;
@synthesize amount=_amount;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
