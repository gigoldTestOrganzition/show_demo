//
//  BankCardManagerViewController.h
//  gigold
//
//  Created by wsc on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "MyViewController.h"

@interface BankCardManagerViewController : MyViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* dataArray;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end
