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
#import "PageTableviewdragloading.h"

@interface SmallChangeViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate,PulRefreshdelegate,PageTableViewdragdelegate>
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
    
    // 上拉加载
    PageTableviewdragloading   *pagetabledrag;
    
    UIView* noneView;
    
    NSInteger queryType;
    
    NSInteger pageNum; //当前的页码数
    
    NSInteger pages;//总页码
    
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end
