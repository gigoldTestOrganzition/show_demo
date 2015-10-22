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


#ifdef DEBUG
#define MF_URL_HOST @"http://192.168.2.47:8080/foundation-web"  //测试环境的HOST
#else
#define MF_URL_HOST @""  //正式环境的HOST
#endif

#endif
