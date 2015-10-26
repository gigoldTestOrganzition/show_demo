//
//  IncomeAEViewController.h
//  gigold
//
//  Created by wsc on 15/10/22.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface IncomeAEViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* dataArray;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end
