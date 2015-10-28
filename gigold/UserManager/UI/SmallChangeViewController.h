//
//  SmallChangeViewController.h
//  gigold
//
//  Created by wsc on 15/10/27.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"

@interface SmallChangeViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* dataArray;
}
@property (weak, nonatomic) IBOutlet UIView *noneView;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end
