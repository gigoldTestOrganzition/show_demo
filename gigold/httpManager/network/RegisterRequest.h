//
//  RegisterRequest.h
//  gigold
//
//  Created by wsc on 15/10/15.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMNetWorkManager.h"

@interface RegisterRequest : NSObject

+ (instancetype)sharedRegisterRequest;

//获取短信验证码
//"mobileNum":"APP端只作长度校验，由后台验证手机号码的合法性" /*手机号*/,
//"sign":"签名算法:将参数按ASII码排序，然后加上密钥串进行MD5加密，例如：sign=MD5(mobileNum=13576543876+MWD76D29KKAS8912SK)" /*签名*/

#define MOBLIE_VALIDATE_URL  @"/sms/verifCode"

- (AFHTTPRequestOperation *)validateMoblieNum:(NSString*)mobileNum
                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure;

//用户开户
//"mobileNum":"APP端只作长度校验，由后台验证手机号码的合法性" /*手机号*/,
//"loginPwd":"最少6位，而且必须为字母和数字的组合，第一位必须为字母" /*登录密码*/,
//"payPwd":"最少6位，而且必须为字母和数字的组合，第一位必须为字母" /*支付密码*/,
//"sign":"sign=MD5(loginPwd=abc123&mobileNum=13576543876&payPwd=reft876+MWD76D29KKAS8912SK)" /*签名*/

#define REGISTER_URL    @"/user/register"

- (AFHTTPRequestOperation *)registerRequestMoblieNum:(NSString*)mobileNum loginPwd:(NSString*)loginPwd  payPwd:(NSString*)payPwd
                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure;


@end
