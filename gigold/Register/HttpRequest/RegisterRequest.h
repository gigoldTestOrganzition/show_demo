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

#define MOBLIE_VALIDATE_URL  @"/sms/verifCode.do"

- (AFHTTPRequestOperation *)validateMoblieNum:(NSString*)mobileNum BusinessType:(NSInteger)businessType
                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure;
//检查短信验证码是否合法
//"smsCode":"" /*验证码*/
#define CODE_VALIDATE_URL  @"/sms/verifySmsCode.do"
- (AFHTTPRequestOperation *)validateSmsCode:(NSString*)smsCode BusinessType:(NSInteger)businessType
                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure;

//用户开户
//"mobileNum":"APP端只作长度校验，由后台验证手机号码的合法性" /*手机号*/,
//"loginPwd":"最少6位，而且必须为字母和数字的组合，第一位必须为字母" /*登录密码*/,
//"payPwd":"最少6位，而且必须为字母和数字的组合，第一位必须为字母" /*支付密码*/,
//"sign":"sign=MD5(loginPwd=abc123&mobileNum=13576543876&payPwd=reft876+MWD76D29KKAS8912SK)" /*签名*/

#define REGISTER_URL    @"/user/registerUser.do"

- (AFHTTPRequestOperation *)registerRequestMoblieNum:(NSString*)mobileNum loginPwd:(NSString*)loginPwd  payPwd:(NSString*)payPwd
                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure;

//校验用户是否存在
//"mobileNum":"" /*手机号，APP只得长度校难，后台作合法性校验*/

#define VALIDATE_UER_URL @"/user/verifyUser.do"
- (AFHTTPRequestOperation *)ValidateUserRequestMoblieNum:(NSString*)mobileNum
                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure;



@end
