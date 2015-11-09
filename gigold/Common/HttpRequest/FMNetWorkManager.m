//
//  FMNetWorkManager.m
//  gigold
//
//  Created by MacPro on 15/10/10.
//  Copyright (c) 2015年 wsc. All rights reserved.
//

#import "FMNetWorkManager.h"
#import "AppUtils.h"

@implementation FMNetWorkManager


+ (instancetype)sharedInstance
{
    static FMNetWorkManager *NetWork = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NetWork = [[FMNetWorkManager alloc] init];
    });
    return NetWork;
}

- (instancetype)init {
    return [self initWithBaseURL:[NSURL URLWithString:MF_URL_HOST]];
}

- (void)cancelAllHTTPOperationsWithPath:(NSString *)path
{
    [[[FMNetWorkManager sharedInstance] session] getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        [self cancelTasksInArray:dataTasks withPath:path];
        [self cancelTasksInArray:uploadTasks withPath:path];
        [self cancelTasksInArray:downloadTasks withPath:path];
    }];
}

- (void)cancelTasksInArray:(NSArray *)tasksArray withPath:(NSString *)path
{
    for (NSURLSessionTask *task in tasksArray) {
        NSRange range = [[[[task currentRequest]URL] absoluteString] rangeOfString:path];
        if (range.location != NSNotFound) {
            [task cancel];
        }
    }
}

- (AFHTTPRequestOperation *)requestURL:(NSString *)URLString
                          httpMethod:(NSString *)method
                          parameters:(id)parameters
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure
{
    return [self requestURL:URLString httpMethod:method parameters:parameters timeoutInterval:0 success:success failure:failure];
}

- (AFHTTPRequestOperation *)requestURL:(NSString *)URLString
                          httpMethod:(NSString *)method
                          parameters:(id)parameters
                     timeoutInterval:(NSTimeInterval)timeout
                             success:(void (^)(AFHTTPRequestOperation *, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure
{
    AFHTTPRequestOperation *operation = [self FMdataTaskWithHTTPMethod:method URLString:URLString parameters:parameters timeoutInterval:timeout success:success failure:failure];
    [operation resume];
    return operation;
}


- (AFHTTPRequestOperation *)FMdataTaskWithHTTPMethod:(NSString *)method
                                         URLString:(NSString *)URLString
                                        parameters:(id)parameters
                                           success:(void (^)(AFHTTPRequestOperation *, id))success
                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure
{
    return [self FMdataTaskWithHTTPMethod:method URLString:URLString parameters:parameters timeoutInterval:0 success:success failure:failure];
}

- (AFHTTPRequestOperation *)FMdataTaskWithHTTPMethod:(NSString *)method
                                         URLString:(NSString *)URLString
                                        parameters:(id)parameters
                                   timeoutInterval:(NSTimeInterval)timeout
                                           success:(void (^)(AFHTTPRequestOperation *, id))success
                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure
{
    //公共参数
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if ([[AppUtils shareAppUtils] getTokenId]) {
        [params setObject:[[AppUtils shareAppUtils] getTokenId] forKey:@"tokenId"];
    }

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    
    
    NSString* GID =  [[AppUtils shareAppUtils] getGID];
    //清空cookies
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] removeCookiesSinceDate:[NSDate dateWithTimeIntervalSince1970:0]];

    if (GID.length > 0){
        [manager.requestSerializer setValue:GID forHTTPHeaderField:@"GID"];
    }else{
        [manager.requestSerializer setValue:nil forHTTPHeaderField:@"GID"];
    }
    
     __block AFHTTPRequestOperation *operation = [manager POST:URLString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //取头信息中的GID值进行存储
        NSString *GID = [[operation.response allHeaderFields] valueForKey:@"GID"];
        if (GID.length > 0) {
            [[AppUtils shareAppUtils] saveGID:GID];
        }
        NSLog(@"JSON: %@", responseObject);
        NSLog(@"allHTTPHeaderFields:%@ %@",operation.request.allHTTPHeaderFields,operation.response.allHeaderFields);
        success (operation,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error%@",error);
        failure(operation,error,nil);
    }];
    
    return operation;
}


@end
