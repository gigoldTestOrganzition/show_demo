//
//  OpenGigoldHeadView.h
//  gigold
//
//  Created by 单小萍 on 15/11/5.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenGigoldHeadView : UITableViewCell
//万分收益lable
@property (weak, nonatomic) IBOutlet UILabel *tenThousandLabel;
//万分收益view
@property (weak, nonatomic) IBOutlet UIView *tenThousandView;
//收益试算
@property (weak, nonatomic) IBOutlet UIView *incomeCalculate;
@end
