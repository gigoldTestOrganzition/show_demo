//
//  AroundCell.h
//  gigold
//
//  Created by 单小萍 on 15/11/6.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AroundCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *merchantImg;
@property (weak, nonatomic) IBOutlet UILabel *merchantsName;
@property (weak, nonatomic) IBOutlet UILabel *adress;

@property (weak, nonatomic) IBOutlet UILabel *disCount;

@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *evaluate;

@end
