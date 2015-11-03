//
//  GigoldDeclaration.h
//  gigold
//
//  Created by 单小萍 on 15/10/30.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GigoldDeclaration : NSObject
//标题
@property(nonatomic,copy)NSString* title;
//声明类型
@property(nonatomic,copy)NSString* type;
//是否正在查看
@property(nonatomic,assign)BOOL isLook;
@end
