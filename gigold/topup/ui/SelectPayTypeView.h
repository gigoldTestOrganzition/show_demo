//
//  SelectPayTypeView.h
//  gigold
//
//  Created by 单小萍 on 15/10/26.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "CustomerView.h"
#import <UIKit/UIKit.h>

@interface SelectPayTypeView : CustomerView
@property (weak, nonatomic) IBOutlet UITableView *selectPayTypeTableView;
@property (weak, nonatomic) IBOutlet UIImageView *cancleImg;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property(nonatomic,weak)id<UITableViewDelegate> delegate;
@property(nonatomic,weak)id<UITableViewDataSource> dataSource;
@property(nonatomic,copy)NSString* titleStr;
@end
