//
//  PasswordRequest.m
//  gigold
//
//  Created by wsc on 15/10/29.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "PasswordRequest.h"

@implementation PasswordRequest

static PasswordRequest *passwordRequest = nil;

+ (instancetype)sharedPasswordRequest
{
    if (passwordRequest == nil){
        passwordRequest = [[PasswordRequest alloc] init];
    }
    return passwordRequest;
}

//重置登录密码
//"loginPwd" /*登录密码*/
//"moblie" /*手机号*/

- (AFHTTPRequestOperation *)resetLoginPwd:(NSString*)loginPwd mobileNum:(NSString*)mobile
                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure{
    
    NSDictionary* user = [NSDictionary dictionaryWithObjectsAndKeys:loginPwd,@"loginPwd",mobile,@"mobile", nil];
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:user,@"user",nil];
    
    return [[FMNetWorkManager sharedInstance] requestURL:RESET_LOGIN_PWD_URL httpMethod:@"POST" parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject) {
        success(operation, responseObject);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error, id responseObject) {
        failure(operation, error ,responseObject);
    }];
}

- (AFHTTPRequestOperation *)updateLoginPwd:(NSString*)oldloginPwd newLoginPwd:(NSString*)newLoginPwd
                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure{
    NSDictionary* user = [NSDictionary dictionaryWithObjectsAndKeys:newLoginPwd,@"loginPwd", nil];
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:user,@"user",oldloginPwd,@"oldPwd",nil];
    
    return [[FMNetWorkManager sharedInstance] requestURL:UPDATE_LOGIN_PWD_URL httpMethod:@"POST" parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject) {
        success(operation, responseObject);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error, id responseObject) {
        failure(operation, error ,responseObject);
    }];
}

@end
