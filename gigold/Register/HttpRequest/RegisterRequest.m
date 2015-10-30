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
- (AFHTTPRequestOperation *)validateMoblieNum:(NSString*)mobileNum BusinessType:(NSInteger)businessType
                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure{
    
    NSMutableDictionary* tempParam = [NSMutableDictionary dictionary];
    [tempParam setValue:mobileNum forKey:@"mobileNum"];
    [tempParam setValue:[NSString stringWithFormat:@"%ld",(long)businessType] forKey:@"businessType"];
    
    NSString* urlString = [NSString stringWithFormat:@"%@%@%@%@",HTTP_HEAD,MF_URL_HOST,FUNC_URL,MOBLIE_VALIDATE_URL];
    
    return [[FMNetWorkManager sharedInstance] requestURL:urlString httpMethod:@"POST" parameters:tempParam success:^(AFHTTPRequestOperation * operation, id responseObject) {
        success(operation, responseObject);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error, id responseObject) {
        failure(operation, error ,responseObject);
    }];
}

//检查短信验证码是否合法
//"smsCode":"" /*验证码*/
- (AFHTTPRequestOperation *)validateSmsCode:(NSString*)smsCode BusinessType:(NSInteger)businessType
                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure{
    NSMutableDictionary* tempParam = [NSMutableDictionary dictionary];
    [tempParam setValue:smsCode forKey:@"smsCode"];
    [tempParam setValue:[NSString stringWithFormat:@"%ld",(long)businessType] forKey:@"businessType"];
    
    NSString* urlString = [NSString stringWithFormat:@"%@%@%@%@",HTTP_HEAD,MF_URL_HOST,FUNC_URL,CODE_VALIDATE_URL];

    return [[FMNetWorkManager sharedInstance] requestURL:urlString httpMethod:@"POST" parameters:tempParam success:^(AFHTTPRequestOperation * operation, id responseObject) {
        success(operation, responseObject);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error, id responseObject) {
        failure(operation, error ,responseObject);
    }];
}

//用户开户
//"sign":"sign=MD5(loginPwd=abc123&mobileNum=13576543876&payPwd=reft876+MWD76D29KKAS8912SK)" /*签名*/
- (AFHTTPRequestOperation *)registerRequestMLoginPwd:(NSString*)loginPwd
                                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure{
    
    NSMutableDictionary* user = [NSMutableDictionary dictionary];
    [user setValue:loginPwd forKey:@"loginPwd"];
    
    NSMutableDictionary* tempParam = [NSMutableDictionary dictionary];
    [tempParam setValue:user forKey:@"user"];
    
    NSString* urlString = [NSString stringWithFormat:@"%@%@%@%@",HTTP_HEAD,MF_URL_HOST,FUNC_URL,REGISTER_URL];
    
    return [[FMNetWorkManager sharedInstance] requestURL:urlString httpMethod:@"POST" parameters:tempParam success:^(AFHTTPRequestOperation * operation, id responseObject) {
        success(operation, responseObject);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error, id responseObject) {
        failure(operation, error ,responseObject);
    }];
}

//校验用户是否存在
//"mobileNum":"" /*手机号，APP只得长度校难，后台作合法性校验*/

- (AFHTTPRequestOperation *)ValidateUserRequestMoblieNum:(NSString*)mobileNum
                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure{
    
    NSMutableDictionary* user = [NSMutableDictionary dictionary];
    [user setValue:mobileNum forKey:@"mobile"];

    NSDictionary* param = [NSDictionary dictionaryWithObjectsAndKeys:user,@"user", nil];
    
    NSString* urlString = [NSString stringWithFormat:@"%@%@%@%@",HTTP_HEAD,MF_URL_HOST,FUNC_URL,VALIDATE_UER_URL];
    
    return [[FMNetWorkManager sharedInstance] requestURL:urlString httpMethod:@"POST" parameters:param success:^(AFHTTPRequestOperation * operation, id responseObject) {
        success(operation, responseObject);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error, id responseObject) {
        failure(operation, error ,responseObject);
    }];
}

@end
