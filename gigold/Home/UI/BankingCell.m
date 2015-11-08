//
//  BankCell.m
//  gigold
//
//  Created by 单小萍 on 15/11/6.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BankingCell.h"

@implementation BankingCell
@synthesize jiyouqianView=_jiyouqianView;
@synthesize smallChangeView=_smallChangeView;
@synthesize costView=_costView;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
