//
//  PasswordRequest.h
//  gigold
//
//  Created by wsc on 15/10/29.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMNetWorkManager.h"

@interface PasswordRequest : NSObject

+ (instancetype)sharedPasswordRequest;

//重置登录密码
//"loginPwd" /*登录密码*/
//"moblie" /*手机号*/

#define RESET_LOGIN_PWD_URL  @"/user/resetLoginPwd.do"

- (AFHTTPRequestOperation *)resetLoginPwd:(NSString*)loginPwd mobileNum:(NSString*)moblie
                                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure;

//修改密码
//"oldPwd"    /*老密码*/
//"loginPwd"  /*新密码*/

#define UPDATE_LOGIN_PWD_URL  @"/user/updateLoginPwd.do"

- (AFHTTPRequestOperation *)updateLoginPwd:(NSString*)oldloginPwd newLoginPwd:(NSString*)newLoginPwd
                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure;

@end
