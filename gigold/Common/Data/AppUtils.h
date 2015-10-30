//
//  AppUtils.h
//  鲜生
//
//  Created by liu.wei on 8/20/13.
//  Copyright (c) 2013 王 苏诚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import "User.h"


@interface AppUtils : NSObject<SKStoreProductViewControllerDelegate>

+ (AppUtils*)shareAppUtils;

- (void)saveUserId:(NSString*)obj;
- (NSString*)getUserId;

-(void)saveIsFirstRun:(BOOL)firstRun;
-(BOOL)getIsFirstRun;

-(void)saveIsLogin:(BOOL)login;
-(BOOL)getIsLogin;

//记录常用登录的账号
-(void)saveHistoricalAccount:(NSString *)obj andKey:(NSString*)key;
-(NSMutableDictionary*)getHistoricalAccount;

//保存登录的账号信息
-(void)saveUserData:(id)obj;
-(User*)getUserData;

//tokenId
-(void)saveTokenId:(NSString*)tokenId;
-(NSString*)getTokenId;

//GID
-(void)saveGID:(NSString*)GID;
-(NSString*)getGID;

- (NSString*)getVersion;
- (NSDate*)getYestoday;
- (NSDate*)getToday;
- (NSDate*)getTomorrow;
- (NSDate*)getFuture;
- (NSComparisonResult)compareDate:(NSDate*)date withOther:(NSDate*)other;
- (NSString*)getDateString:(NSDate*)date withFormat:(NSString*)format;
- (NSDate*)getDateWithString:(NSString*)string withFormat:(NSString*)format;
//日期获取
- (NSString *)getCalcDaysFromBegin:(NSDate *)inBegin;


- (void)showAlert:(NSString*)text;
- (void)showHUD:(NSString*)text andView:(UIView*)view;

- (void)openAppWithIdentifier:(NSString *)appId andOwner:(UIViewController*)vc;
- (void)openAppGoCommentWithAppId:(NSString*)appId andOwner:(UIViewController*)vc;

- (BOOL)validateEmail:(NSString *)candidate;
- (BOOL)validateMobile:(NSString *)mobileNum;
- (BOOL)validatePhone:(NSString *)phoneNum;

- (BOOL)cameraEnbled;
- (BOOL)AudioEnbled;

- (NSString *)md5:(NSString *)str;

//加密手机号码
- (NSString *)encryptMoblieNumber:(NSString*)str;

//登录密码验证
- (BOOL)validateLoginPassword:(NSString*)password;

//是否有设置支付密码 由服务器定
-(void)saveIsPayPwd:(BOOL)isPayPwd;
-(BOOL)getIsPayPwd;

@end
