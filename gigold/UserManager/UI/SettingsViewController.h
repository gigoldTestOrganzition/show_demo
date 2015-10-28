//
//  SettingsViewController.h
//  gigold
//
//  Created by wsc on 15/10/24.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomerView.h"

@interface SettingsViewController : BaseViewController <UITableViewDataSource>
{
    NSMutableArray* dataArray;
    
    CustomerView* popView;
}
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end
