//
//  AddOpenBankCardViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/30.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "AddOpenBankCardViewController.h"
#import "VerificationCodeWriteViewController.h"
#import "Bank.h"
#import "StringUtil.h"
#import "OpenBankCardSelectView.h"
#import "ViewUtil.h"
#import "LimitInstructionsViewController.h"
@interface AddOpenBankCardViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    NSMutableArray* datas;
    
    __weak IBOutlet UILabel *nameLabel;
    //选择银行
    __weak IBOutlet UIView *bankView;
    __weak IBOutlet UITextField *bank;
    //信息收集
    __weak IBOutlet UITextField *cardNumber;
    __weak IBOutlet UITextField *phoneNumber;
    //按钮下一步
    __weak IBOutlet UIButton *nextBtn;
    __weak IBOutlet NSLayoutConstraint *topLayoutConstraint;
    
    CustomerView* selectBankView;
}
@end

@implementation AddOpenBankCardViewController
@synthesize name=_name;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    
    topLayoutConstraint.constant = 44.f+STATUSBAR_OFFSET+25.f;
    self.title = @"添加银行卡";
    nameLabel.text = _name;
    
    bank.enabled = NO;
    UITapGestureRecognizer* selectGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBank)];
    bankView.userInteractionEnabled = YES;
    [bankView addGestureRecognizer:selectGestureRecognizer];
    
    
    nextBtn.layer.cornerRadius = nextBtn.frame.size.height/2;
    // Do any additional setup after loading the view.
}

//初始化数据
-(void)initData{
    if (!datas) {
        datas = [NSMutableArray new];
    }
    Bank* ban1 = [Bank new];
    ban1.name = @"招商银行";
    ban1.blance = @"100";
    [datas addObject:ban1];
    
    Bank* ban2 = [Bank new];
    ban2.name = @"建设银行";
    ban2.blance = @"50";
    [datas addObject:ban2];
}


//下一步

- (IBAction)next:(id)sender {
    VerificationCodeWriteViewController* verificationCodeWriteViewController = [[VerificationCodeWriteViewController alloc]init];
    verificationCodeWriteViewController.moblieNum = phoneNumber.text;
    verificationCodeWriteViewController.flowType = OpenGigoldType;
    verificationCodeWriteViewController.title = @"添加银行卡";
    [self.navigationController pushViewController:verificationCodeWriteViewController animated:YES];
}

/*选择银行*/
-(void)selectBank{
    if (!selectBankView) {
        selectBankView = [[CustomerView alloc]init];
        selectBankView.pullStyle = PullviewRight;
        OpenBankCardSelectView* bankCardView = [[[NSBundle mainBundle]loadNibNamed:@"OpenBankCardSelectView" owner:self options:nil]firstObject];
        bankCardView.frame = CGRectMake(40.f,44.f+STATUSBAR_OFFSET,mainScreenWidth-40.f, mainScreenHeight);
        bankCardView.selectTableView.tableFooterView = [UIView new];
        bankCardView.selectTableView.layoutMargins = UIEdgeInsetsZero;
        bankCardView.backgroundColor = back_ground_color;
        bankCardView.selectTableView.backgroundColor = back_ground_color;
        bankCardView.selectTableView.delegate = self;
        bankCardView.selectTableView.dataSource = self;
        [ViewUtil registerGestures:bankCardView.limitInstructions target:self action:@selector(intoLimitInstructions)];
        selectBankView.showView = bankCardView;
    }
    [selectBankView showDialog:self.view];
}
//进入限额说明
-(void)intoLimitInstructions{
    LimitInstructionsViewController* limitInstructionsViewController = [[LimitInstructionsViewController alloc]init];
    [self.navigationController pushViewController:limitInstructionsViewController animated:YES];
}
#pragma mark -textfield
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"ss");
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([StringUtil isEmpty:string]) {
        nextBtn.enabled = NO;
    }else{
        nextBtn.enabled = [self isNextEnable:textField];
    }
    if (nextBtn.enabled) {
        nextBtn.backgroundColor = theme_color;
    }else{
        nextBtn.backgroundColor = unable_tap_color;
    }
    NSInteger value = textField.text.length-range.length+string.length;
    if (textField == phoneNumber) {
        if(value > 11){
            return NO;
        }else{
            return YES;
        }
    }else {
        if(value > 18){
            return NO;
        }else{
            return YES;
        }
    }
    return YES;
}
//是否可点击下一步
-(BOOL)isNextEnable:(UITextField*)textField{
    if (textField == cardNumber) {
        if (![StringUtil isEmpty:bank.text]&&![StringUtil isEmpty:phoneNumber.text]) {
            return YES;
        }else{
            return NO;
        }
    }else{
        if (![StringUtil isEmpty:bank.text]&&![StringUtil isEmpty:cardNumber.text]) {
            return YES;
        }else{
            return NO;
        }
    }
}
// 是否可点击
-(void)isNextEnable{
    if (![StringUtil isEmpty:bank.text]&&![StringUtil isEmpty:cardNumber.text]&&![StringUtil isEmpty:phoneNumber.text]) {
        nextBtn.enabled = YES;
        nextBtn.backgroundColor = theme_color;
    }else{
        nextBtn.enabled = NO;
        nextBtn.backgroundColor = unable_tap_color;
    }
}

#pragma mark -tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [datas count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    Bank* bankItem = datas[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"bank_logo_cmb"];
    cell.textLabel.text = bankItem.name;
    cell.textLabel.textColor  = main_text_color;
    cell.textLabel.font = main_font;
    if(indexPath.row == datas.count - 1){
        cell.separatorInset = UIEdgeInsetsZero;
        cell.layoutMargins  = UIEdgeInsetsZero;
    }else{
       cell.separatorInset = UIEdgeInsetsMake(0.f,10.f,0.f,0.f);
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [selectBankView stopDialog];
    Bank* bankItem = datas[indexPath.row];
    bank.text = bankItem.name;
    [self isNextEnable];
}
@end
