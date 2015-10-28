//
//  BankCardManagerViewController.m
//  gigold
//
//  Created by wsc on 15/10/21.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BankCardManagerViewController.h"
#import "AddBankCardViewController.h"

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
    
    dataArray = [[NSMutableArray alloc] initWithObjects:@"吉高宝",@"账户余额",@"银行卡管理",@"密码管理", nil];
    
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
        cell.cardTypeLabel.text = @"储蓄卡";
    }else{
        cell.bankCardTopView.backgroundColor = [UIColor colorWithRed:0/255.f green:91/255.f blue:167/255.f alpha:1];
        cell.cardTypeLabel.text = @"信用卡";
    }
    cell.numberLabel.text = @"*** *** *** 0782";

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"去删除某张卡");
}

#pragma mark ---- BaseViewControllerDelegate --------

-(void)UIViewControllerBack:(BaseViewController *)baseViewController{
    if ([baseViewController isKindOfClass:[AddBankCardViewController class]]) {
        [dataArray addObject:@"新加一张银行卡"];
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
