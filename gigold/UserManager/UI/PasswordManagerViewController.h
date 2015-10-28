//
//  PasswordManagerViewController.h
//  gigold
//
//  Created by wsc on 15/10/12.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"
#import "LoadView.h"

@interface PasswordManagerViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* dataArray;
    LoadView* loadView;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end
