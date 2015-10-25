//
//  SettingsViewController.h
//  gigold
//
//  Created by wsc on 15/10/24.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"

@interface SettingsViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* dataArray;
}
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end
