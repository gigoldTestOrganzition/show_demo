//
//  AddressManagerViewController.h
//  gigold
//
//  Created by 单小萍 on 15/10/29.
//  Copyright © 2015年 wsc. All rights reserved.
//
/*
 *地址管理
 */
#import "BaseViewController.h"
#import "Address.h"
@interface AddressManagerViewController : BaseViewController
-(void)addAddress:(Address*)address;
-(void)deleteAddress:(Address*)address;
@end
