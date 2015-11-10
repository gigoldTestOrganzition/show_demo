//
//  BankCell.m
//  gigold
//
//  Created by 单小萍 on 15/11/6.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BankingCell.h"
@interface BankingCell(){

    __weak IBOutlet NSLayoutConstraint *line2;
    __weak IBOutlet NSLayoutConstraint *line1;
    
    __weak IBOutlet NSLayoutConstraint *line3;
    
}
@end
@implementation BankingCell
@synthesize jiyouqianView=_jiyouqianView;
@synthesize smallChangeView=_smallChangeView;
@synthesize costView=_costView;
- (void)awakeFromNib{
    line1.constant = 0.5;
    line2.constant = 0.5;
    line3.constant = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
