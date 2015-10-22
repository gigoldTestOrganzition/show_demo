//
//  TopUpResultViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "TopUpResultViewController.h"
#import "Colors.h"

@interface TopUpResultViewController (){
    //结果view
    __weak IBOutlet UIView *resultView;
    //结果描述
    __weak IBOutlet UILabel *resultDesc;
}

@end

@implementation TopUpResultViewController
@synthesize isSuccess=_isSuccess;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"充值结果";
    resultView.layer.cornerRadius = 60.f;
    if (_isSuccess) {
        resultView.backgroundColor = lightBlueColor;
        resultDesc.text = @"充值成功";
    }else{
        resultView.backgroundColor = lightGrayColor;
        resultDesc.text = @"充值失败";
    }
    
    // Do any additional setup after loading the view.
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
