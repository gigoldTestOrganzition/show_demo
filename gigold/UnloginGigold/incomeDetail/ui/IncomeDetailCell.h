//
//  IncomeDetailCell.h
//  gigold
//
//  Created by 单小萍 on 15/10/22.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IncomeDetailCell : UITableViewCell
//时间
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
//金额
@property (weak, nonatomic) IBOutlet UILabel *amountLable;

@end
