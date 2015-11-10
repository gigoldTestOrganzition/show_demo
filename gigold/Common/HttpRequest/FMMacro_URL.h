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
//#define MF_URL_HOST @"192.168.2.29:8080"  //测试环境的HOST
#else
#define MF_URL_HOST @""  //正式环境的HOST
#endif

#define FUNC_URL @""   //功能url
//#define FUNC_URL @"/foundation-web"   //功能url

#endif
