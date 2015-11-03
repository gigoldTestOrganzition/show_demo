//
//  AddressCell.h
//  gigold
//
//  Created by 单小萍 on 15/10/29.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *estimatedAddress;
@property (weak, nonatomic) IBOutlet UILabel *detailAddress;

@property (weak, nonatomic) IBOutlet UIView *ctView;

@end
