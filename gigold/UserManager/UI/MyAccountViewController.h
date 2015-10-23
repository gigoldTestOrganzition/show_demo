//
//  MyAccountViewController.h
//  gigold
//
//  Created by wsc on 15/10/12.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"
#import "MyAccountTableViewCell.h"

@interface MyAccountViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* titleArray;
    NSMutableArray* imageArray;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end
