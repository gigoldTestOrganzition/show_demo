//
//  LoginRequest.m
//  gigold
//
//  Created by wsc on 15/10/14.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest

static LoginRequest *loginRequest = nil;

+ (instancetype)sharedLoginRequest
{
    if (loginRequest == nil){
        loginRequest = [[LoginRequest alloc] init];
    }
    return loginRequest;
}

//用户登录
//"sign":"签名算法:将参数按ASII码排序，然后加上密钥串进行MD5加密，例如：sign=MD5(mobileNum=13576543876&pwd=abc123+MWD76D29KKAS8912SK)" /*签名*/
- (AFHTTPRequestOperation *)loginRequestMobileNum:(NSString*)mobileNum pwd:(NSString*)pwd
                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure;
{
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:mobileNum,@"mobileNum",pwd,@"pwd", nil];
    
    return [[FMNetWorkManager sharedInstance] requestURL:LOGIN_URL httpMethod:@"POST" parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject) {
        success(operation, responseObject);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error, id responseObject) {
        failure(operation, error ,responseObject);
    }];
}

//用户退出登录
//"sign":"签名算法:将参数按ASII码排序，然后加上密钥串进行MD5加密，例如：sign=MD5(mobileNum=13576543876+MWD76D29KKAS8912SK)" /*签名*/
- (AFHTTPRequestOperation *)logoutRequestMobileNum:(NSString*)mobileNum
                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure{
    return [[FMNetWorkManager sharedInstance] requestURL:LOGOUT_URL httpMethod:@"POST" parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
        success(operation, responseObject);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error, id responseObject) {
        failure(operation, error ,responseObject);
    }];
}

@end
