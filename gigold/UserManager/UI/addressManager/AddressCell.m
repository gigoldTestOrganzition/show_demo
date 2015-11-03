//
//  AddressCell.m
//  gigold
//
//  Created by 单小萍 on 15/10/29.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell
@synthesize estimatedAddress=_estimatedAddress;
@synthesize detailAddress=_detailAddress;
@synthesize ctView=_ctView;

- (void)awakeFromNib {
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
