//
//  User.m
//  gigold
//
//  Created by wsc on 15/10/30.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "User.h"

@implementation User

-(id)init{
    self.email = @"";
    self.gender = @"";
    self.Id = @"";
    self.idNo = @"";
    self.idType = @"";
    self.loginDate = nil;
    self.loginPwd = @"";
    self.mark = @"";
    self.mobile = @"";
    self.name = @"";
    self.nick = @"";
    self.payPwd = @"";
    self.state = @"";
    self.stsw = @"";
    self.usrNo = @"";
    self.loginErrTimes = 0;
    self.payErrTimes = 0;
    return [super init];
}

@end
