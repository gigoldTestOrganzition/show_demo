//
//  BankCardManagerViewController.h
//  gigold
//
//  Created by wsc on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"
#import "BankCardTableViewCell.h"
#import "CustomerView.h"

@interface BankCardManagerViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* dataArray;
    
    UIButton* addNavBtn;
    
    CustomerView* popView;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end
