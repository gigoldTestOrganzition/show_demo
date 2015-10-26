//
//  RollInViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "RollInViewController.h"
#import "appliacation_attribute.h"

@interface RollInViewController (){
   // 转入银行
    __weak IBOutlet UILabel *rollInBank;
    // 银行标记
    __weak IBOutlet UIImageView *bankSelectMark;
    // 转入金额
    __weak IBOutlet UITextField *rollInAmount;
    //支付密码
    __weak IBOutlet UITextField *payPwd;
    //忘记密码
    __weak IBOutlet UIView *forgetPwd;
}
@end

@implementation RollInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"转入";
    [self initEvent];
    
    // Do any additional setup after loading the view.
}
//初始化事件
-(void)initEvent{
    UITapGestureRecognizer* selectBankRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBank)];
    rollInBank.userInteractionEnabled = YES;
    [rollInBank addGestureRecognizer:selectBankRecognizer];
    
    UITapGestureRecognizer* forgetPwdRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(forgetPwd)];
    forgetPwd.userInteractionEnabled = YES;
    [forgetPwd addGestureRecognizer:forgetPwdRecognizer];

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
//立即转入
- (IBAction)rollInAction:(id)sender {
    NSLog(@"立即转入");
    RollInViewController* rollInViewController  = (RollInViewController*)storyboard_controller_identity(@"GigoldTreasureHome", @"rollInResult");
    [self.navigationController pushViewController:rollInViewController animated:YES];
    
}
//选择银行
-(void)selectBank{
    NSLog(@"选择银行");
}
//忘记密码
-(void)forgetPwd{
     NSLog(@"忘记密码");
}

@end
