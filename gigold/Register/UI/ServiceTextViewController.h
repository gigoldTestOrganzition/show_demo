//
//  ServiceTextViewController.h
//  gigold
//
//  Created by wsc on 15/10/27.
//  Copyright © 2015年 wsc. All rights reserved.
//

typedef enum _ServiceTextType
{
    Service_GigoldType = 0,
    Service_FastPayType,
    Service_Bank_CMBType,
} ServiceTextType;

#import "BaseViewController.h"

@interface ServiceTextViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (assign, nonatomic) ServiceTextType serviceTextType;

@end
