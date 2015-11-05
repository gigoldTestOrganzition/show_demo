//
//  OpenBankCardSelectView.h
//  gigold
//
//  Created by 单小萍 on 15/11/5.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenBankCardSelectView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *limitInstructions;
@property (weak, nonatomic) IBOutlet UITableView *selectTableView;

@end
