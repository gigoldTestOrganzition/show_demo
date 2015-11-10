//
//  HelpViewController.m
//  gigold
//
//  Created by wsc on 15/10/14.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController
@synthesize isShowLaunchView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    images = [[NSArray alloc] initWithObjects:@"",@"",@"",@"",@"", nil];
    
    [self showMainView];
 
    if (isShowLaunchView) {
        [self showCustomLaunchView];
    }
}

-(void)showMainView{
    UIScrollView* mScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    mScrollView.contentSize = CGSizeMake(images.count*mScrollView.frame.size.width, mScrollView.frame.size.height);
    mScrollView.pagingEnabled = YES;
    mScrollView.bounces = NO;
    
    [self.view addSubview:mScrollView];
    
    for (NSInteger i = 0; i < images.count ; i++) {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(mScrollView.frame.size.width*i, 0, mScrollView.frame.size.width, mScrollView.frame.size.height)];
        imageView.userInteractionEnabled = YES;
        
        if ( i%2 == 0) {
            imageView.backgroundColor = [UIColor redColor];
        }else{
            imageView.backgroundColor = [UIColor greenColor];
        }
        
        [mScrollView addSubview:imageView];
        
        if (i == images.count - 1) {
            UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            backBtn.frame = CGRectMake(80, imageView.frame.size.height-50, imageView.frame.size.width-2*80, 30);
            backBtn.layer.borderWidth = 1;
            backBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            backBtn.layer.cornerRadius = 10;
            [backBtn setTitle:@"知道了" forState:UIControlStateNormal];
            [backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
            
            [imageView addSubview:backBtn];
        }
    }
}

-(void)backBtnPress{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showMainView" object:nil];
}

-(void)showCustomLaunchView{
    launchView = [[LaunchViewController alloc] init];
    launchView.delegate = self;
    launchView.view.frame = CGRectMake(0, 0, mainScreenWidth, mainScreenHeight);
    [self.view addSubview:launchView.view];
}


-(void)UIViewControllerBack:(BaseViewController *)baseViewController{
    [launchView.view removeFromSuperview];
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
