//
//  BaseViewController.h
//  gigold
//
//  Created by wsc on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UIImageView+WebCache.h"
#import "AppUtils.h"
#import "AppDelegate.h"

@class BaseViewController;

@protocol BaseViewControllerDelegate <NSObject>

@optional

-(void)UIViewControllerBack:(BaseViewController *)baseViewController;

@end

@interface BaseViewController : UIViewController <BaseViewControllerDelegate>

@property (assign, nonatomic)id <BaseViewControllerDelegate>delegate;

@end