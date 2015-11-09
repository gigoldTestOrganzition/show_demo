//
//  RootViewController.h
//  gigold
//
//  Created by wsc on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "RNSwipeViewController.h"
#import "MyAccountViewController.h"
#import "LaunchViewController.h"

@class BaseViewController;

@interface RootViewController : RNSwipeViewController <BaseViewControllerDelegate>
{
    LaunchViewController* launchView;
}

@end
