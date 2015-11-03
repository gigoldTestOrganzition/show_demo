//
//  SelectRegionView.h
//  gigold
//
//  Created by 单小萍 on 15/10/29.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "CustomerView.h"

@interface SelectRegionView : CustomerView

@property (weak, nonatomic) IBOutlet UILabel *cancle;
@property (weak, nonatomic) IBOutlet UILabel *sure;

@property (weak, nonatomic) IBOutlet UIPickerView *regionPickerView;
@end
