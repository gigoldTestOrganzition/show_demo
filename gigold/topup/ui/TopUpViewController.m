//
//  TopUpViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/20.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "TopUpViewController.h"
#import "TopUpShowViewController.h"
#import "appliacation_attribute.h"

@interface TopUpViewController ()<UITextFieldDelegate>{
    //充值金额
    __weak IBOutlet UITextField *amountField;
}
@end

@implementation TopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUi];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

//初始化界面
-(void)initUi{
    self.navigationItem.title = @"钱包充值";

}
// 返回
-(void)back{
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - xib链接
//下一步
- (IBAction)next:(id)sender{
    if (amountField.text.length == 0){
        [[AppUtils shareAppUtils] showAlert:@"输入金额不能为空"];
    }else{
        TopUpShowViewController* topUpShowViewController = (TopUpShowViewController*)storyboard_controller_identity(@"topUpStoryboard",@"topupDetail");
        topUpShowViewController.amount = amountField.text;
        [self.navigationController pushViewController:topUpShowViewController animated:YES];
    }
    
}

#pragma mark -协议
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSInteger value = textField.text.length-range.length+string.length;
    if (value>15) {
        return NO;
    }
    return YES;
    

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
