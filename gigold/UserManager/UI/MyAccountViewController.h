//
//  MyAccountViewController.h
//  gigold
//
//  Created by wsc on 15/10/12.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"
#import "MyAccountTableViewCell.h"
#import "User.h"

@interface MyAccountViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* titleArray;
    NSMutableArray* imageArray;
    
    UIImageView* headImageView;
    UILabel* loginLabel;
    UILabel* moblieLabel;
    UILabel* markLabel;
    
    NSDictionary* myUser;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;

@end
