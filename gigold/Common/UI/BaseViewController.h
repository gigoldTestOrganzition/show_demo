//
//  BaseViewController.h
//  gigold
//
//  Created by wsc on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "AppUtils.h"
#import "AppDelegate.h"
#import "UIViewController+RNSwipeViewController.h"


@class BaseViewController;

@protocol BaseViewControllerDelegate <NSObject>

@optional

-(void)UIViewControllerBack:(BaseViewController *)baseViewController;

@end

//登录功能
typedef enum _LoginType
{
    OnlyLogin = 0,
    UpdataPassword,
    GoPasswordManager,
    GoBankCardManager,
    GoIncomeAE,
    
} LoginType;

//注册和重置密码界面共用
typedef enum FlowType
{
    RegisterType = 0,
    ResetPasswordType,
    UpdataPayPWDType,
    SetPayPWDType
} FlowType;

//判断返回状态值
typedef enum BackType
{
    NoneType = 0,
    FinishType,
    cancelType,
} BackType;

@interface BaseViewController : UIViewController <BaseViewControllerDelegate>

@property (assign, nonatomic)id <BaseViewControllerDelegate>delegate;

- (void)backBtnPress;

//登出响应
- (void)logoutRespond;
//登录响应
- (void)loginRespond:(NSString*)account andPassword:(NSString*)pwd;

- (void)showLoginView:(LoginType)loginType;

@end
