//
//  TradingCell.h
//  gigold
//
//  Created by 单小萍 on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradingCell : UITableViewCell
//交易类型
@property (weak, nonatomic) IBOutlet UILabel *type;
//交易时间
@property (weak, nonatomic) IBOutlet UILabel *time;
//交易金额
@property (weak, nonatomic) IBOutlet UILabel *amountLable;

@end
