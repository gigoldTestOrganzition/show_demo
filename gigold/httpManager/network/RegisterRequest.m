//
//  RegisterRequest.m
//  gigold
//
//  Created by wsc on 15/10/15.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "RegisterRequest.h"

@implementation RegisterRequest

static RegisterRequest *registerRequest = nil;

+ (instancetype)sharedRegisterRequest
{
    if (registerRequest == nil){
        registerRequest = [[RegisterRequest alloc] init];
    }
    return registerRequest;
}

//获取短信验证码
//"sign":"签名算法:将参数按ASII码排序，然后加上密钥串进行MD5加密，例如：sign=MD5(mobileNum=13576543876+MWD76D29KKAS8912SK)" /*签名*/
- (AFHTTPRequestOperation *)validateMoblieNum:(NSString*)mobileNum
                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure{
    
    NSMutableDictionary* tempParam = [NSMutableDictionary dictionary];
    [tempParam setValue:mobileNum forKey:@"moblieNum"];
    
    return [[FMNetWorkManager sharedInstance] requestURL:MOBLIE_VALIDATE_URL httpMethod:@"POST" parameters:tempParam success:^(AFHTTPRequestOperation * operation, id responseObject) {
        success(operation, responseObject);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error, id responseObject) {
        failure(operation, error ,responseObject);
    }];
}

//用户开户
//"sign":"sign=MD5(loginPwd=abc123&mobileNum=13576543876&payPwd=reft876+MWD76D29KKAS8912SK)" /*签名*/
- (AFHTTPRequestOperation *)registerRequestMoblieNum:(NSString*)mobileNum loginPwd:(NSString*)loginPwd  payPwd:(NSString*)payPwd
                                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure{
    
    return [[FMNetWorkManager sharedInstance] requestURL:REGISTER_URL httpMethod:@"POST" parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
        success(operation, responseObject);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error, id responseObject) {
        failure(operation, error ,responseObject);
    }];
}


@end
