//
//  MyViewController.m
//  水果糖
//
//  Created by MacPro on 15-7-7.
//  Copyright (c) 2015年wsc. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController
@synthesize delegate;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}

-(void)headImageViewCreat{
    CGFloat itemCount = 8;
    CGFloat itemWidth = self.view.frame.size.width/itemCount;
    
    for (NSInteger i = 0; i < itemCount; i++) {
        UIView* itemView = [[UIView alloc] initWithFrame:CGRectMake(i*itemWidth, 44+STATUSBAR_OFFSET-itemWidth/2+5, itemWidth, itemWidth)];
        if (i % 2 == 0) {
            itemView.backgroundColor = tabBarColor;
        }else{
            itemView.backgroundColor = navigationBarBtnColor;
        }
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:itemView.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight  cornerRadii:CGSizeMake(itemWidth/2, itemWidth/2)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = itemView.bounds;
        maskLayer.path = maskPath.CGPath;
        itemView.layer.mask = maskLayer;
        [self.view addSubview:itemView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
