//
//  BankCell.h
//  gigold
//
//  Created by 单小萍 on 15/11/6.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankingCell : UITableViewCell
//吉有钱
@property (weak, nonatomic) IBOutlet UIView *jiyouqianView;
//零钱
@property (weak, nonatomic) IBOutlet UIView *smallChangeView;
//花费
@property (weak, nonatomic) IBOutlet UIView *costView;

@property (weak, nonatomic) IBOutlet UIView *rateChartView;
@end
