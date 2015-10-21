//
//  BankCardCell.h
//  gigold
//
//  Created by 单小萍 on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankCardCell : UITableViewCell
//银行图片
@property (weak, nonatomic) IBOutlet UIImageView *bankImg;
//银行姓名
@property (weak, nonatomic) IBOutlet UILabel *name;
//账户额度
@property (weak, nonatomic) IBOutlet UILabel *amount;

@end
