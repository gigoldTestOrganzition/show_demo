//
//  RegisterAgreementViewController.h
//  gigold
//
//  Created by MacPro on 15-10-10.
//  Copyright (c) 2015年wsc. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterAgreementViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray* titleArray;
    NSMutableArray* contenctArray;
}


@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end
