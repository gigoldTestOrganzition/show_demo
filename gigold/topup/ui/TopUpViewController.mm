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
#import "StringUtil.h"
#import "ViewUtil.h"
#import "CustomerView.h"
#import "SelectPayTypeView.h"
#import "BankCell.h"
#import "Bank.h"
#import "UPPayPlugin.h"
#import "appliacation_attribute.h"
#import "TopUpResultViewController.h"
#import "AddBankCardViewController.h"
@interface TopUpViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UPPayPluginDelegate>{
    //充值金额
    __weak IBOutlet UITextField *amountField;
    //下一步按钮
    __weak IBOutlet UIButton *nextBtn;
    //选择付款方式
    SelectPayTypeView* selectPayView;
    //银行卡
    NSMutableArray* bankCards;
    
}
@end

@implementation TopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
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
    nextBtn.layer.cornerRadius = nextBtn.bounds.size.height/2;
    nextBtn.enabled = NO;

}
// 返回
-(void)back{
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//初始化数据
-(void)initData{
    if (!bankCards) {
        bankCards = [NSMutableArray new];
    }
    Bank* ban1 = [Bank new];
    ban1.name = @"招商银行";
    ban1.blance = @"100";
    [bankCards addObject:ban1];
    
    Bank* ban2 = [Bank new];
    ban2.name = @"建设银行";
    ban2.blance = @"50";
    [bankCards addObject:ban2];

}

#pragma mark - xib链接
//下一步
- (IBAction)next:(id)sender{
    [self selectPayType];
    
    
//    [nextBtn setBackgroundColor:theme_auxiliary_color];
//    if (amountField.text.length == 0){
//        [[AppUtils shareAppUtils] showAlert:@"输入金额不能为空"];
//    }else{
//        TopUpShowViewController* topUpShowViewController = (TopUpShowViewController*)storyboard_controller_identity(@"topUpStoryboard",@"topupDetail");
//        topUpShowViewController.amount = amountField.text;
//        [self.navigationController pushViewController:topUpShowViewController animated:YES];
//    }
//    [nextBtn setBackgroundColor:theme_color];
}
//选择支付类型
-(void)selectPayType{
    if (!selectPayView) {
        selectPayView = [[SelectPayTypeView alloc]init];
        selectPayView.delegate = self;
        selectPayView.dataSource = self;
    }
    [selectPayView showDialog:self.view];
    
}
//选择银联支付
-(void)selectUnipay{
    NSLog(@"unipay");
    [selectPayView stopDialog];
    [self startUPPay];

}
//添加银行卡
-(void)addBankCard{
    NSLog(@"add");
    [selectPayView stopDialog];
    //[self startUPPay];
    AddBankCardViewController* addBankCardViewController =  [[AddBankCardViewController alloc]init];
    [self.navigationController pushViewController:addBankCardViewController animated:YES];

}
//开启银联支付
-(void)startUPPay{
     [UPPayPlugin startPay:@"1" mode:@"01" viewController:self delegate:self];
}
#pragma mark -tableView协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [bankCards count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BankCell* cell  = (BankCell*)[[NSBundle mainBundle] loadNibNamed:@"PayTypeCell" owner:self options:nil][1];
    Bank* bank = bankCards[indexPath.row];
    cell.name.text = bank.name;
    cell.blance.text = bank.blance;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Bank* bank = bankCards[indexPath.row];
    //NSLog(bank.name);
    [selectPayView stopDialog];
    [self startUPPay];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* headView = [[NSBundle mainBundle] loadNibNamed:@"PayTypeCell" owner:self options:nil][0];
    UITapGestureRecognizer* headRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectUnipay)];
    headView.userInteractionEnabled = YES;
    [headView addGestureRecognizer:headRecognizer];
    return headView;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* footerView = [[NSBundle mainBundle] loadNibNamed:@"PayTypeCell" owner:self options:nil][2];
    UITapGestureRecognizer* footerRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addBankCard)];
    footerView.userInteractionEnabled = YES;
    [footerView addGestureRecognizer:footerRecognizer];
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 48;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 48;
}
#pragma mark ---- UITextFieldDelegate --------
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([StringUtil isEmpty:string]) {
        if (nextBtn.enabled) {
            [nextBtn setBackgroundColor:unable_tap_color];
            nextBtn.enabled  = NO;
        }
    }else{
        if (!nextBtn.enabled) {
            [nextBtn setBackgroundColor:theme_color];
            nextBtn.enabled  = YES;
        }
    }
    
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
#pragma mark -银联支付协议 
-(void)UPPayPluginResult:(NSString *)result{
    
    TopUpResultViewController* topUpResultViewController = (TopUpResultViewController*)storyboard_controller_identity(@"topUpStoryboard", @"topupResult");
    topUpResultViewController.isSuccess =[result isEqualToString:@"fail"]?NO:YES;
    topUpResultViewController.amountStr = amountField.text;
    [self.navigationController pushViewController:topUpResultViewController animated:NO];

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
