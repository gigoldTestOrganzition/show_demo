//
//  BankCell.m
//  gigold
//
//  Created by 单小萍 on 15/10/26.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BankCell.h"

@implementation BankCell
@synthesize img=_img;
@synthesize name=_name;
@synthesize blance=_blance;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
