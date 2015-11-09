//
//  FMMacro_URL.h
//  gigold
//
//  Created by MacPro on 15/10/10.
//  Copyright (c) 2015年 wsc. All rights reserved.
//





#ifndef gigold_FMMacro_URL_h
#define gigold_FMMacro_URL_h

#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


#define HTTP_HEAD @"http://"     //http https

#ifdef DEBUG
#define MF_URL_HOST @"182.92.170.189:8081"  //测试环境的HOST
//#define MF_URL_HOST @"192.168.2.23:8080"  //测试环境的HOST
#else
#define MF_URL_HOST @""  //正式环境的HOST
#endif

#define FUNC_URL @""   //功能url
//#define FUNC_URL @"/foundation-web"   //功能url


//全局返回码定义
#define  SUCCESS         @"00000"  //成功
#define  SYSTEM_ERROR    @"99999"  //系统异常
#define  PARAMS_INVALID  @"90001"  //请求参数非法
#define  TIMEOUT         @"90002"  //网络超时


//用户返回码定义
#define USER_MOBILE_ERROR     @"U0011" //手机号码不正确
#define USER_MOBILE_EMPTY     @"U0012" //手机号码不能为空
#define USER_IS_EXIST         @"U0013" //用户已存在
#define USER_NOT_EXIST        @"U0014" //用户不存在
#define USER_REGISTER_FAIL    @"U0015" //用户注册失败
#define USER_MOBILE_PWD_ERROR @"U0016" //账号或密码错误
#define USER_OLD_PWD_ERROR    @"U0017" //旧密码不正确
#define USER_UPDATE_PWD_FAIL  @"U0018" //操作密码失败
#define USER_PWD_STYLE_ERROR  @"U0019" //密码格式不正确

//短信返回码定义
#define SMS_MOBILE_ERROR      @"S0001" //手机号码不合法
#define SMS_GET_CODE_FAIL     @"S0002" //获取短信验证码失败
#define SMS_VERIFY_CODE_FAIL  @"S0003" //短信验证码校验失败

//会话失效
#define SESSION_FAIL          @"30002" //会话失效

#endif
