//
//  LoginRequest.h
//  gigold
//
//  Created by wsc on 15/10/14.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMNetWorkManager.h"

@interface LoginRequest : NSObject

+ (instancetype)sharedLoginRequest;

//用户登录
//"mobileNum":"APP端只作长度校验，由后台验证手机号码的合法性" /*手机号*/,
//"pwd":"" /*登录密码|*/,
//"sign":"签名算法:将参数按ASII码排序，然后加上密钥串进行MD5加密，例如：sign=MD5(mobileNum=13576543876&pwd=abc123+MWD76D29KKAS8912SK)" /*签名*/

#define LOGIN_URL  @"/user/login.do"

- (AFHTTPRequestOperation *)loginRequestMobileNum:(NSString*)mobileNum pwd:(NSString*)pwd
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure;

//用户退出登录
//"mobileNum":"APP端只作长度校验，由后台验证手机号码的合法性" /*手机号*/,
//"sign":"签名算法:将参数按ASII码排序，然后加上密钥串进行MD5加密，例如：sign=MD5(mobileNum=13576543876+MWD76D29KKAS8912SK)" /*签名*/

#define LOGOUT_URL  @"/user/logout"

- (AFHTTPRequestOperation *)logoutRequestMobileNum:(NSString*)mobileNum
                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure;

@end
