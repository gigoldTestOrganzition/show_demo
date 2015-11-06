//
//  SmallChangeViewController.h
//  gigold
//
//  Created by wsc on 15/10/27.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomerView.h"
#import "PulRefresh.h"

@interface SmallChangeViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate,PulRefreshdelegate>
{
    NSMutableArray* dataArray;
    
    UIView* navTitleView;
    UILabel* titleLabel;
    UIImageView* markImageView;
    
    NSMutableArray* menuImages;
    NSMutableArray* menuTitles;
    
    CustomerView* popView;
    
    PulRefresh     *pullfresh;
    BOOL _reloading;
    
    UIView* noneView;
    
    NSInteger queryType;
    
    NSInteger pageNum; //当前的页码数
    
    NSInteger pages;//总页码
    
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end
