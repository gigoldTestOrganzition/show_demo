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
    //显示img
    __weak IBOutlet UIImageView *resultImg;
    //结果描述
    __weak IBOutlet UILabel *resultDesc;
    //错误补充
    __weak IBOutlet UILabel *resultErrorDesc;
     //结果再操作
    __weak IBOutlet UILabel *resultAction;
    
    __weak IBOutlet NSLayoutConstraint *resultActionDistanceLayoutConstraint;
}

@end

@implementation TopUpResultViewController
@synthesize isSuccess = _isSuccess;
@synthesize amountStr = _amountStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(operationResult)];
    
    if (_isSuccess) {
        self.navigationItem.title = @"充值成功";
        resultImg.image = [UIImage imageNamed:@"main_correct_ico.png"];
        resultDesc.text = [NSString stringWithFormat:@"%@%@元",@"成功充值",_amountStr];
        resultErrorDesc.hidden = YES;
        resultAction.text = @"返回首页";
        resultActionDistanceLayoutConstraint.constant-=20;
        
    }else{
        self.navigationItem.title = @"充值失败";
        resultImg.image = [UIImage imageNamed:@"main_error_ico.png"];
        resultDesc.text = @"充值失败";
        resultAction.text = @"重试";
    }
    UITapGestureRecognizer* actionGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(operationResult)];
    resultAction.userInteractionEnabled = YES;
    [resultAction addGestureRecognizer:actionGestureRecognizer];
    
    
    
}
//操作结果
-(void)operationResult{
    if (_isSuccess) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    
    }
}
//关闭
-(void)close{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
