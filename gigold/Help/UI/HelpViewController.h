//
//  HelpViewController.h
//  gigold
//
//  Created by wsc on 15/10/14.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"
#import "LaunchViewController.h"

@interface HelpViewController : BaseViewController <BaseViewControllerDelegate>
{
    NSArray* images;
    LaunchViewController* launchView;
}

@property (nonatomic, assign) BOOL isShowLaunchView;

@end
