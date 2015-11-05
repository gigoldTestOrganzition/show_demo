//
//  user.h
//  gigold
//
//  Created by wsc on 15/10/30.
//  Copyright © 2015年 wsc. All rights reserved.
//

//用户对象
#import <Foundation/Foundation.h>
#import "BaseClass.h"

@interface User : BaseClass

@property (strong, nonatomic) NSString* email;
@property (strong, nonatomic) NSString* gender;
@property (strong, nonatomic) NSString* Id;
@property (strong, nonatomic) NSString* idNo;
@property (strong, nonatomic) NSString* idType;
@property (strong, nonatomic) NSDate* loginDate;
@property (strong, nonatomic) NSString* loginPwd;
@property (strong, nonatomic) NSString* mark;
@property (strong, nonatomic) NSString* mobile;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* nick;
@property (strong, nonatomic) NSString* payPwd;
@property (strong, nonatomic) NSString* state;
@property (strong, nonatomic) NSString* stsw;
@property (strong, nonatomic) NSString* usrNo;
@property (assign, nonatomic) NSInteger loginErrTimes;
@property (assign, nonatomic) NSInteger payErrTimes;

@end
