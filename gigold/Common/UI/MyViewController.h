//
//  MyViewController.h
//  水果糖
//
//  Created by MacPro on 15-7-7.
//  Copyright (c) 2015年wsc. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UIImageView+WebCache.h"
#import "AppUtils.h"
#import "AppDelegate.h"

@class MyViewController;

@protocol MyViewControllerDelegate <NSObject>

@optional

-(void)UIViewControllerBack:(MyViewController *)myViewController;

@end

@interface MyViewController : UIViewController <MyViewControllerDelegate>

@property (assign, nonatomic)id <MyViewControllerDelegate>delegate;

@end
