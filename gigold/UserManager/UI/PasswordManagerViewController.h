//
//  PasswordManagerViewController.h
//  gigold
//
//  Created by wsc on 15/10/12.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"

@interface PasswordManagerViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end
