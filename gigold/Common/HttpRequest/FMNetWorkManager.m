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
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    dic[@"jsessionid"] = @"7e0fe3fa6180157d032b4ebba5ca36fa";
//    
//    NSError *serialError = nil;
//    NSMutableURLRequest *urlRequest = [self.requestSerializer requestWithMethod:@"GET" URLString:URLString parameters:dic error:&serialError];
//    NSString *theUrl = [urlRequest.URL absoluteString];
//    
//    NSError *serializationError = nil;
//    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:theUrl relativeToURL:self.baseURL] absoluteString] parameters:nil error:&serializationError];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    

//    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"sessionCookies"]];
//    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//

    //如果报接受类型不一致请替换一致text/html或别的
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
//    manager.requestSerializer.HTTPRequestHeaders
//    [manager ]
    //传入的参数
//    NSDictionary *parameters = @{@"1":@"XXXX",@"2":@"XXXX",@"3":@"XXXXX"};
    //你的接口地址
    //发送请求
//    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
//    [manager.requestSerializer setValue:@"application/json;charset=utf-8;"forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:@"text/plain"forHTTPHeaderField:@"Content-Type"];
    
    
    NSString* GID =  [[AppUtils shareAppUtils] getGID];
    NSLog(@"NSString GID%@",GID);
    //清空cookies
    NSLog(@"%@",[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]);
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] removeCookiesSinceDate:[NSDate dateWithTimeIntervalSince1970:0]];
    NSLog(@"%@",[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]);

    if (GID.length > 0){
        [manager.requestSerializer setValue:GID forHTTPHeaderField:@"GID"];
    }else{
        [manager.requestSerializer setValue:nil forHTTPHeaderField:@"GID"];
    }
    NSLog(@"%@",manager.requestSerializer.HTTPRequestHeaders);
    
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
         failure(operation,error,nil);
    }];
    
    return operation;
}


@end
