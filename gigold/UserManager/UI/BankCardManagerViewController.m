//
//  BankCardManagerViewController.m
//  gigold
//
//  Created by wsc on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BankCardManagerViewController.h"
#import "AddBankCardViewController.h"
#import "PayPwdValidateViewController.h"

@interface BankCardManagerViewController ()

@end

@implementation BankCardManagerViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addCustomNavBar];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeCustomNavBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的银行卡";
    
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"6120***9009",@"number",@"建设银行",@"type",@"im",@"image", nil];
    
    dataArray = [[NSMutableArray alloc] initWithObjects:@"账户余额",@"银行卡管理",@"密码管理", nil];
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    
    [self tableViewFooterViewCreat];
    // Do any additional setup after loading the view from its nib.
}

- (void)addCustomNavBar{
    addNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addNavBtn.frame = CGRectMake(mainScreenWidth-44, 0, 44, 44);
    addNavBtn.titleLabel.font = main_font;
    [addNavBtn setTitle:@"添加" forState:UIControlStateNormal];
    [addNavBtn addTarget:self action:@selector(addBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:addNavBtn];

}

-(void)removeCustomNavBar{
    [addNavBtn removeFromSuperview];
}

-(void)tableViewFooterViewCreat{
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, 120)];
    
    UIView* backgroudView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, footerView.frame.size.width-2*10, 90)];
    backgroudView.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:backgroudView];
    
    UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 24, 2)];
    view1.backgroundColor = theme_color;
    view1.center = CGPointMake(backgroudView.center.x-10, 32);
    
    UIView* view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 2, 24)];
    view2.backgroundColor = theme_color;
    view2.center = CGPointMake(backgroudView.center.x-10, 32);
    
    [backgroudView addSubview:view1];
    [backgroudView addSubview:view2];
    
    UILabel* addLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view2.frame.origin.y+view2.frame.size.height+10, backgroudView.frame.size.width, 15)];
    addLabel.textAlignment = NSTextAlignmentCenter;
    addLabel.textColor = theme_color;
    addLabel.font = dialog_font;
    addLabel.text = @"添加银行卡";
    [backgroudView addSubview:addLabel];
    
    UITapGestureRecognizer* oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addBtnPress)];
    [backgroudView addGestureRecognizer:oneTap];
    
    self.mTableView.tableFooterView = footerView;
}

-(void)addBtnPress{
    AddBankCardViewController* addBankCardView = [[AddBankCardViewController alloc] init];
    addBankCardView.delegate = self;
    [self.navigationController pushViewController:addBankCardView animated:YES];
}

#pragma mark ---- UITableViewDataSource,UITableViewDelegate --------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellString = @"BankCardTableViewCell";
    BankCardTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (!cell) {
        cell= [[[NSBundle mainBundle]loadNibNamed:@"BankCardTableViewCell" owner:nil options:nil] firstObject];
    }
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row % 2 == 0) {
        cell.bankCardTopView.backgroundColor = [UIColor colorWithRed:216/255.f green:35/255.f blue:42/255.f alpha:1];
        cell.bankImageView.image  = [UIImage imageNamed:@"bank_logo_cmb"];
        cell.cardTypeLabel.text = @"储蓄卡";
    }else{
        cell.bankCardTopView.backgroundColor = [UIColor colorWithRed:0/255.f green:91/255.f blue:167/255.f alpha:1];
        cell.bankImageView.image  = [UIImage imageNamed:@"bank_logo_ccb"];
        cell.cardTypeLabel.text = @"信用卡";
    }
    cell.numberLabel.text = @"*** *** *** 0782";

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"去删除某张卡");
    if (!popView) {
        UIView* showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, 45+50)];
        showView.backgroundColor = self.view.backgroundColor;
        
        UIButton* btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.backgroundColor = [UIColor whiteColor];
        btn1.frame = CGRectMake(0, 0, showView.frame.size.width, 45);
        [btn1 setTitle:@"解除绑定" forState:UIControlStateNormal];
        btn1.titleLabel.font = dialog_font;
        [btn1 setTitleColor:theme_color forState:UIControlStateNormal];
        [btn1 setTitleColor:theme_color forState:UIControlStateHighlighted];
        [showView addSubview:btn1];
        
        UIView* shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, btn1.frame.size.height-0.5, btn1.frame.size.width, 0.5)];
        shadowView.backgroundColor = gray_diver_color;
        [btn1 addSubview:shadowView];
        
        
        UIButton* btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.backgroundColor = [UIColor whiteColor];
        btn2.frame = CGRectMake(0, 50, showView.frame.size.width, 45);
        [btn2 setTitle:@"取消" forState:UIControlStateNormal];
        btn2.titleLabel.font = dialog_font;
        [btn2 setTitleColor:main_text_color forState:UIControlStateNormal];
        [btn2 setTitleColor:main_text_color forState:UIControlStateHighlighted];
        [showView addSubview:btn2];
        
        shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, btn2.frame.size.width, 0.5)];
        shadowView.backgroundColor = gray_diver_color;
        [btn2 addSubview:shadowView];
        
        [btn1 addTarget:self action:@selector(popBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 addTarget:self action:@selector(popBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        
        popView = [[CustomerView alloc] init];
        popView.showView = showView;
    }
    [popView showDialog:self.view];
}

-(void)popBtnPress:(UIButton*)btn{
    [popView stopDialog];
    if ([btn.titleLabel.text isEqualToString:@"取消"]) {
        
    }else{
        NSLog(@"去解绑");
        PayPwdValidateViewController* payPwdValidateView = [[PayPwdValidateViewController alloc] init];
        payPwdValidateView.payPwdValiteType = V_Delete_BankCardType;
        payPwdValidateView.delegate = self;
        payPwdValidateView.title = @"解除绑定";
        payPwdValidateView.titleLabel.text = @"请输入6位数字支付密码解除绑定 招商银行储蓄卡（6372)";
        [self.navigationController pushViewController:payPwdValidateView animated:YES];
    }
}


#pragma mark ---- BaseViewControllerDelegate --------

-(void)UIViewControllerBack:(BaseViewController *)baseViewController{
    if ([baseViewController isKindOfClass:[AddBankCardViewController class]]) {
        [dataArray addObject:@"新加一张银行卡"];
        [self.mTableView reloadData];
    }else if ([baseViewController isKindOfClass:[PayPwdValidateViewController class]]){
        [dataArray removeLastObject];
        [self.mTableView reloadData];
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
