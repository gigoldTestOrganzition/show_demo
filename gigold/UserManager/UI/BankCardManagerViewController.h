//
//  BankCardManagerViewController.h
//  gigold
//
//  Created by wsc on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"
#import "BankCardTableViewCell.h"

@interface BankCardManagerViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* dataArray;
    
    UIButton* addNavBtn;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end
