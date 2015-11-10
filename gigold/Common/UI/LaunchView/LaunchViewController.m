//
//  LaunchViewController.m
//  gigold
//
//  Created by wsc on 15/11/6.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    NSLog(@"%@",[NSString stringWithFormat:@"launch-%fh",mainScreenHeight]);
    self.defaultImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"launch-%.0fh",mainScreenHeight]];
    
    if (mainScreenHeight == 480) {
        self.launchHeight.constant = 220/2.0f;
    }else if (mainScreenHeight == 568){
        self.launchHeight.constant = 220/2.0f;
    }else if (mainScreenHeight == 667){
        self.launchHeight.constant = 258/2.0f;
    }else if (mainScreenHeight == 736){
        self.launchHeight.constant = 427/2.0f;
    }

    self.launchImageView.image = [UIImage imageNamed:@"login_pic@1080w.jpg"];
    
    self.launchImageView.alpha = 0.1;
    
    [UIView animateWithDuration:1 animations:^{
        self.launchImageView.alpha = 1;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(launchBack) withObject:nil afterDelay:1];
    }];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)launchBack{
    [self performSelector:@selector(reallyBack) withObject:nil afterDelay:0.8];
    [UIView animateWithDuration:1 animations:^{
        self.launchImageView.alpha = 0.2;
        self.defaultImageView.alpha  = 0.2;
    } completion:^(BOOL finished) {
    }];
    
}

-(void)reallyBack{
    [self.navigationController popViewControllerAnimated:NO];
    if ([self.delegate respondsToSelector:@selector(UIViewControllerBack:)]) {
        [self.delegate performSelector:@selector(UIViewControllerBack:) withObject:self];
    }
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
