//
//  RollOutViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "RollOutViewController.h"
#import "Colors.h"
#import "appliacation_attribute.h"
#import "RollOutResultViewController.h"

@interface RollOutViewController (){
    //转出银行
    __weak IBOutlet UILabel *outBank;
    //普通类型
    __weak IBOutlet UILabel *nomalType;
    //快速类型
    __weak IBOutlet UILabel *quickType;
    //转出金额
    __weak IBOutlet UITextField *outAmount;
    //全部转出
    __weak IBOutlet UILabel *allRollOut;
    //支付密码
    __weak IBOutlet UITextField *payPwd;
    //忘记密码
    __weak IBOutlet UIView *forgetPwd;
    
    
    
    
}
@end

@implementation RollOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initEvent];
    self.navigationItem.title = @"转出";
    // Do any additional setup after loading the view.
}
//初始化事件
-(void)initEvent{
    UITapGestureRecognizer* selectBankRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBank)];
    outBank.userInteractionEnabled = YES;
    [outBank addGestureRecognizer:selectBankRecognizer];
    
    
    UITapGestureRecognizer* selectNomalTypeRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectNomalType)];
    nomalType.userInteractionEnabled = YES;
    [nomalType addGestureRecognizer:selectNomalTypeRecognizer];
    
    
    UITapGestureRecognizer* selectQucklyTypeRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectQuckleType)];
    quickType.userInteractionEnabled = YES;
    [quickType addGestureRecognizer:selectQucklyTypeRecognizer];
    
    UITapGestureRecognizer* allOutRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(allOutAction)];
    allRollOut.userInteractionEnabled = YES;
    [allRollOut addGestureRecognizer:allOutRecognizer];
    
    
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

#pragma mark －手势 
//选择银行
-(void)selectBank{
    NSLog(@"选择银行");
}
//选择普通类型
-(void)selectNomalType{
    NSLog(@"普通类型");
    nomalType.backgroundColor = lightGrayColor;
    nomalType.textColor = [UIColor whiteColor];
    
    quickType.backgroundColor = [UIColor clearColor];
    quickType.textColor = lightGrayColor;
    
}
//选择快速类型
-(void)selectQuckleType{
    NSLog(@"快速类型");
    
    quickType.backgroundColor = lightGrayColor;
    quickType.textColor = [UIColor whiteColor];
    
    nomalType.backgroundColor = [UIColor clearColor];
    nomalType.textColor = lightGrayColor;

}
//全部转出
-(void)allOutAction{
    NSLog(@"全部转出");
}
//忘记密码
-(void)forgetPwd{
    NSLog(@"忘记密码");
}
#pragma mark - xib链接
// 立即转出
- (IBAction)rollOutAction:(id)sender {
    NSLog(@"立即转出 ");
   RollOutResultViewController* rollOutResultViewController =(RollOutResultViewController*) storyboard_controller_identity(@"GigoldTreasureHome", @"rollOutResult");
    [self.navigationController pushViewController:rollOutResultViewController animated:YES];
    
}

@end
