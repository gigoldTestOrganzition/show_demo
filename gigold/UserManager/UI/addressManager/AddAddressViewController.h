//
//  AddAddressViewController.h
//  gigold
//
//  Created by 单小萍 on 15/10/29.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressManagerViewController.h"
#import "Address.h"
@interface AddAddressViewController : BaseViewController
@property (nonatomic,weak)AddressManagerViewController* deleget;
@property(nonatomic,weak)Address* address;
@end
