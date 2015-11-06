//
//  UserInfoRequest.h
//  gigold
//
//  Created by wsc on 15/10/15.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMNetWorkManager.h"

@interface UserInfoRequest : NSObject

+ (instancetype)sharedUserInfoRequest;

//用户基本信息查询
//"mobileNum":"APP端只作长度校验，由后台验证手机号码的合法性" /*手机号*/,
//"sign":"签名算法:将参数按ASII码排序，然后加上密钥串进行MD5加密，例如：sign=MD5(mobileNum=13576543876+MWD76D29KKAS8912SK)" /*签名*/

#define QUERY_INFO_URL  @"/user/queryinfo"

- (AFHTTPRequestOperation *)queryinfoMoblieNum:(NSString*)mobileNum
                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure;


//用户余额信息查询
//"mobileNum":"APP端只作长度校验，由后台验证手机号码的合法性" /*手机号*/,
//"sign":"签名算法:将参数按ASII码排序，然后加上密钥串进行MD5加密，例如：sign=MD5(mobileNum=13576543876+MWD76D29KKAS8912SK)" /*签名*/

#define BAL_INFO_URL  @"/user/balinfo"

- (AFHTTPRequestOperation *)balinfoMoblieNum:(NSString*)mobileNum
                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject))failure;

//用户收支明细查询
//"mobileNum":"APP端只作长度校验，由后台验证手机号码的合法性" /*手机号*/,
//"acNo":"" /*账号*/,
//"beginDate":"" /*开始日期*/,
//"endDate":"" /*结束日期*/,
//"sign":"签名算法:将参数按ASII码排序，然后加上密钥串进行MD5加密，例如：sign=MD5(mobileNum=13576543876+MWD76D29KKAS8912SK)" /*签名*/

#define AMTDETAIL_QUERY_URL   @"/user/amtdetailquery.do"

- (AFHTTPRequestOperation *)amtdetailqueryPageNum:(NSInteger)pageNum queryType:(NSInteger)queryType 
                                   success:(void (^)(AFHTTPRequestOperation *task, id responseObject))success
                                   failure:(void (^)(AFHTTPRequestOperation *task, NSError *error, id responseObject))failure;




@end
