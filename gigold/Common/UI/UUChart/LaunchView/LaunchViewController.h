//
//  LaunchViewController.h
//  gigold
//
//  Created by wsc on 15/11/6.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BaseViewController.h"

@interface LaunchViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *defaultImageView;
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *launchHeight;
@end
