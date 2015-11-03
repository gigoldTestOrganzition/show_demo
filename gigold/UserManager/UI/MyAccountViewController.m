//
//  MyAccountViewController.m
//  gigold
//
//  Created by wsc on 15/10/12.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "MyAccountViewController.h"
#import "PasswordManagerViewController.h"
#import "BankCardManagerViewController.h"
#import "IncomeAEViewController.h"
#import "SettingsViewController.h"
#import "LoginViewController.h"
#import "SmallChangeViewController.h"
#import "AddressManagerViewController.h"
@interface MyAccountViewController ()

@end

@implementation MyAccountViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    myUser = [[AppUtils shareAppUtils] getUserData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(LoginStateChangeNotification:)name:@"LoginStateChange" object:nil];
    
    self.view.backgroundColor = [UIColor colorWithRed:72/255. green:202/255. blue:226/255. alpha:1];
    
    titleArray = [[NSMutableArray alloc] initWithObjects:@"吉有钱",@"零钱",@"银行卡",@"交易记录",@"密码管理",@"地址管理", nil];
    imageArray = [[NSMutableArray alloc] initWithObjects:@"user_menu_ico_1",@"user_menu_ico_2",@"user_menu_ico_3",@"user_menu_ico_4",@"user_menu_ico_5",@"user_menu_ico_5",nil];
    
    [self.settingBtn addTarget:self action:@selector(settingBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    self.mTableView.backgroundColor = [UIColor colorWithRed:72/255. green:202/255. blue:226/255. alpha:1];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    [self tableViewHeaderViewCreat];
    
    // Do any additional setup after loading the view from its nib.
}

//监听登录状态改变
-(void)LoginStateChangeNotification:(NSNotification *)notification{
    myUser = [[AppUtils shareAppUtils] getUserData];
    if ([[AppUtils shareAppUtils] getIsLogin]) {
        loginLabel.hidden = YES;
        markLabel.hidden = NO;
        moblieLabel.hidden = NO;
        moblieLabel.text = [[AppUtils shareAppUtils] encryptMoblieNumber:myUser.mobile];
    }else{
        loginLabel.hidden = NO;
        markLabel.hidden = YES;
        moblieLabel.hidden = YES;
    }
    [self.mTableView reloadData];
}


-(void)tableViewHeaderViewCreat{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 120)];
    headerView.backgroundColor = self.view.backgroundColor;
    
    headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, headerView.frame.size.height-55, 45, 45)];
    [headImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"user_faces_1"]];
    headImageView.layer.cornerRadius = headImageView.frame.size.height/2;
    
    [headerView addSubview:headImageView];
    
    loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(headImageView.frame.size.width+headImageView.frame.origin.x+10, headImageView.frame.origin.y, headerView.frame.size.width-(headImageView.frame.size.width+headImageView.frame.origin.x+10+10), 45)];
    loginLabel.backgroundColor = [UIColor clearColor];
    loginLabel.text = @"点击登录";
    loginLabel.textColor = [UIColor whiteColor];
    loginLabel.font = [UIFont systemFontOfSize:16];
    [headerView addSubview:loginLabel];
    
    moblieLabel = [[UILabel alloc] initWithFrame:CGRectMake(headImageView.frame.size.width+headImageView.frame.origin.x+10, headImageView.frame.origin.y, headerView.frame.size.width-(headImageView.frame.size.width+headImageView.frame.origin.x+10+10), 22)];
    moblieLabel.backgroundColor = [UIColor clearColor];
    moblieLabel.font = [UIFont systemFontOfSize:16];
    moblieLabel.textColor = [UIColor whiteColor];
    moblieLabel.text = [[AppUtils shareAppUtils] encryptMoblieNumber:myUser.mobile];
    [headerView addSubview:moblieLabel];
    
    markLabel = [[UILabel alloc] initWithFrame:CGRectMake(headImageView.frame.size.width+headImageView.frame.origin.x+10, headImageView.frame.origin.y+22+6,60, 16)];
    markLabel.textAlignment = NSTextAlignmentCenter;
    markLabel.backgroundColor = [UIColor whiteColor];
    markLabel.textColor = self.view.backgroundColor;
    markLabel.font = [UIFont systemFontOfSize:10];
    markLabel.text = @"未实名认证";
    markLabel.clipsToBounds = YES;
    markLabel.layer.cornerRadius = 8;
    [headerView addSubview:markLabel];
    
    if ([[AppUtils shareAppUtils] getIsLogin]) {
        loginLabel.hidden = YES;
    }else{
        markLabel.hidden = YES;
        moblieLabel.hidden = YES;
    }
    
    UITapGestureRecognizer* oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerPress)];
    [headerView addGestureRecognizer:oneTap];
    
    self.mTableView.tableHeaderView = headerView;
}

-(void)headerPress{
    if ([[AppUtils shareAppUtils] getIsLogin]) {
        NSLog(@"去看个人界面");
    }else{
        NSLog(@"去登录");
        [self showLoginView:OnlyLogin];
    }
}

-(void)settingBtnPress{
    SettingsViewController* settingView = [[SettingsViewController alloc] init];
    [self.navigationController pushViewController:settingView animated:YES];
}



#pragma mark ---- UITableViewDataSource,UITableViewDelegate --------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellString = @"MyAccountTableViewCell";
    MyAccountTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (!cell) {
        NSLog(@"%@",[[NSBundle mainBundle]loadNibNamed:@"MyAccountTableViewCell" owner:nil options:nil] );
        cell= [[[NSBundle mainBundle]loadNibNamed:@"MyAccountTableViewCell" owner:nil options:nil] firstObject];
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = theme_color;
    }
    cell.menuTitleLabel.text = [titleArray objectAtIndex:indexPath.row];
    cell.menuImageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
    if (![[AppUtils shareAppUtils] getIsLogin]) {
        cell.valueLabel.text = @"";
    }else{
        if (indexPath.row == 0) {
            cell.valueLabel.text = @"53123.12元";
        }else if (indexPath.row == 1){
            cell.valueLabel.text = @"140.00元";
        }else if (indexPath.row == 2){
            cell.valueLabel.text = @"3张";
        }else{
            cell.valueLabel.text = @"";
        }
    }
    

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* menuTitle = [titleArray objectAtIndex:indexPath.row];
    NSLog(@"去%@",menuTitle);
    if ([menuTitle isEqualToString:@"吉有钱"]) {
    }
    else if ([menuTitle isEqualToString:@"零钱"]){
        if (![[AppUtils shareAppUtils] getIsLogin]) {
            [self showLoginView:GoSmallChange];
        }else{
            SmallChangeViewController* smallChangeView = [[SmallChangeViewController alloc] init];
            [self.navigationController pushViewController:smallChangeView animated:YES];
        }
    }
    else if ([menuTitle isEqualToString:@"交易记录"]){
        if (![[AppUtils shareAppUtils] getIsLogin]) {
            [self showLoginView:GoIncomeAE];
        }else{
            IncomeAEViewController* incomeAEView = [[IncomeAEViewController alloc] init];
            incomeAEView.delegate = self;
            [self.navigationController pushViewController:incomeAEView animated:YES];
        }
        
    }
    else if ([menuTitle isEqualToString:@"银行卡"]){
        if (![[AppUtils shareAppUtils] getIsLogin]) {
            [self showLoginView:GoBankCardManager];
        }else{
            BankCardManagerViewController* bankCardView = [[BankCardManagerViewController alloc] init];
            bankCardView.delegate = self;
            [self.navigationController pushViewController:bankCardView animated:YES];
        }
        
    }
    else if ([menuTitle isEqualToString:@"密码管理"]){
        if (![[AppUtils shareAppUtils] getIsLogin]) {
            [self showLoginView:GoPasswordManager];
        }else{
            PasswordManagerViewController* passwordManagerView = [[PasswordManagerViewController alloc] init];
            passwordManagerView.delegate = self;
            [self.navigationController pushViewController:passwordManagerView animated:YES];
        }
        
    }else if ([menuTitle isEqualToString:@"地址管理"]){
        AddressManagerViewController* addressManagerViewController = [[AddressManagerViewController alloc]init];
        [self.navigationController pushViewController:addressManagerViewController animated:YES];
        
    }
}

#pragma mark ---- BaseViewControllerDelegate --------

-(void)UIViewControllerBack:(BaseViewController *)baseViewController{
    if ([baseViewController isKindOfClass:[LoginViewController class]]) {
        LoginViewController* loginView = (LoginViewController*)baseViewController;
        if (loginView.loginType == OnlyLogin) {
            
        }else if (loginView.loginType == GoIncomeAE){
            IncomeAEViewController* incomeAEView = [[IncomeAEViewController alloc] init];
            [self.navigationController pushViewController:incomeAEView animated:YES];
        }else if (loginView.loginType == GoBankCardManager){
            BankCardManagerViewController* bankCardView = [[BankCardManagerViewController alloc] init];
            [self.navigationController pushViewController:bankCardView animated:YES];
        }else if (loginView.loginType == GoPasswordManager){
            PasswordManagerViewController* passwordManagerView = [[PasswordManagerViewController alloc] init];
            [self.navigationController pushViewController:passwordManagerView animated:YES];
        }else if (loginView.loginType == GoSmallChange){
            SmallChangeViewController* smallChangeView = [[SmallChangeViewController alloc] init];
            [self.navigationController pushViewController:smallChangeView animated:YES];
        }
    }
    else if ([baseViewController isKindOfClass:[PasswordManagerViewController class]]){
        [self showLoginView:OnlyLogin];
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
