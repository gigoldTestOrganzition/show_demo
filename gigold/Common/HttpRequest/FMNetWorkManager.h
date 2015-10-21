//
//  FMNetWorkManager.h
//  gigold
//
//  Created by MacPro on 15/10/10.
//  Copyright (c) 2015年 wsc. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "FMMacro_URL.h"
@interface FMNetWorkManager : AFHTTPSessionManager

+ (instancetype)sharedInstance;

/** 取消制定path的全部网络请求 */
- (void)cancelAllHTTPOperationsWithPath:(NSString *)path;

/** 网络请求(可设置超时时长) */
- (AFHTTPRequestOperation *)requestURL:(NSString *)URLString
                          httpMethod:(NSString *)method
                          parameters:(id)parameters
                     timeoutInterval:(NSTimeInterval)timeout
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure;

/** 网络请求(默认超时时长) */
- (AFHTTPRequestOperation *)requestURL:(NSString *)URLString
                          httpMethod:(NSString *)method
                          parameters:(id)parameters
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure;


@end
