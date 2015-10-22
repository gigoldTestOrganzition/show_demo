//
//  TopUpShowViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/20.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "TopUpShowViewController.h"
#import "BankCard.h"
#import "BankCardCell.h"
#import "UPPayPlugin.h"
#import "MBProgressHUDManager.h"
#import "appliacation_attribute.h"
#import "TopUpResultViewController.h"

@interface TopUpShowViewController ()<UITableViewDataSource,UITableViewDelegate,UPPayPluginDelegate>{
    //充值金额
    __weak IBOutlet UILabel *amountLabel;
    //展示图片
    __weak IBOutlet UIImageView *showImg;
    //展示文字
    __weak IBOutlet UILabel *showTxt;
    //选择付款银行
    __weak IBOutlet UIView *selectPayBank;
    //付款dialog
    __weak IBOutlet UIView *payBankDialog;
    //下一步
    __weak IBOutlet UIButton *next;
    //到选择
    __weak IBOutlet NSLayoutConstraint *nextToSelectPayBankLayoutConstraint;
    //到详情
    __weak IBOutlet NSLayoutConstraint *nextToBankDialogLayoutConstraint;
    //dialog高度链接
    __weak IBOutlet NSLayoutConstraint *bankDialogHeight;
    
    //银行卡视图
    __weak IBOutlet UITableView *bankCardTableView;
    //银行卡
    NSMutableArray* bankCards;
    //是否显示dialog
    BOOL isShowBankDialog;
    // dialog高度
    CGFloat bandDialogHeight;
    
}

@end

@implementation TopUpShowViewController
@synthesize amount=_amountStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBankCards];
    [self initUi];
    
    // Do any additional setup after loading the view.
}
//初始化ui
-(void)initUi{
    isShowBankDialog =  NO;
    payBankDialog.hidden = YES;
    payBankDialog.alpha = 0;
    bandDialogHeight = payBankDialog.frame.size.height;
    bankDialogHeight.constant = 0;
    
    
    
    //tableView 初始化
    bankCardTableView.separatorInset = UIEdgeInsetsZero;
    bankCardTableView.layoutMargins = UIEdgeInsetsZero;
    bankCardTableView.tableFooterView = [UIView new];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.navigationItem.title=@"充值详情";
    amountLabel.text = _amountStr;
    
    
    UITapGestureRecognizer* selectBankRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBank)];
    [selectPayBank addGestureRecognizer:selectBankRecognizer];
    
    UITapGestureRecognizer* nextRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upPay)];
    [next addGestureRecognizer:nextRecognizer];
}
//初始银行卡信息
-(void)initBankCards{
    bankCards = [NSMutableArray new];
    BankCard* card1 = [BankCard new];
    card1.name = @"招商银行";
    card1.balance = @"122";
    
    BankCard* card2 = [BankCard new];
    card2.name = @"建设银行";
    card2.balance = @"422";
    
    BankCard* card3 = [BankCard new];
    card3.name = @"浦发银行";
    card3.balance = @"322";
    
    BankCard* card4 = [BankCard new];
    card4.name = @"工商银行";
    card4.balance = @"522";
    
    [bankCards addObject:card1];
    [bankCards addObject:card2];
    [bankCards addObject:card3];
    [bankCards addObject:card4];
    
    
    

}
-(void)selectBank{
    if (payBankDialog.hidden) {
        payBankDialog.hidden = NO;
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    if (!isShowBankDialog) {
        payBankDialog.alpha = 1.0;
        bankDialogHeight.constant = bandDialogHeight;
        nextToBankDialogLayoutConstraint.priority = 750;
        nextToSelectPayBankLayoutConstraint.priority = 250;

    }else{
        payBankDialog.alpha = 0.0;
         bankDialogHeight.constant = 0;
        payBankDialog.bounds.size =CGSizeMake(payBankDialog.bounds.size.width,0);
        nextToBankDialogLayoutConstraint.priority = 250;
        nextToSelectPayBankLayoutConstraint.priority = 750;
    }
    isShowBankDialog = !isShowBankDialog;
    [self.view layoutIfNeeded];
    [UIView commitAnimations];
}
//银联支付
-(void)upPay{
    [UPPayPlugin startPay:@"000000000" mode:@"01" viewController:self delegate:self];
    
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

#pragma mark - tableView协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [bankCards count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BankCardCell* cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    BankCard* card = bankCards[indexPath.row];
    cell.name.text = card.name;
    cell.amount.text = card.balance;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BankCard* card = bankCards[indexPath.row];
    showTxt.text = card.name;
    [self selectBank];
}

-(void)UPPayPluginResult:(NSString *)result{
    
    TopUpResultViewController* topUpResultViewController = (TopUpResultViewController*)storyboard_controller_identity(@"topUpStoryboard", @"topupResult");
    topUpResultViewController.isSuccess =[result isEqualToString:@"fail"]?NO:YES;
    [self.navigationController pushViewController:topUpResultViewController animated:YES];
    
}
@end
