//
//  CustomerSlider.m
//  gigold
//
//  Created by 单小萍 on 15/10/31.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "CustomerSlider.h"

@implementation CustomerSlider

-(CGRect)trackRectForBounds:(CGRect)bounds{
    return CGRectMake(bounds.origin.x,bounds.origin.y, bounds.size.width,5.f);
}
@end
