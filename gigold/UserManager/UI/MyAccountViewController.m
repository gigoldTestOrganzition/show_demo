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

@interface MyAccountViewController ()

@end

@implementation MyAccountViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(LoginStateChangeNotification:)name:@"LoginStateChange" object:nil];
    
    self.view.backgroundColor = [UIColor colorWithRed:72/255. green:202/255. blue:226/255. alpha:1];
    
    titleArray = [[NSMutableArray alloc] initWithObjects:@"吉有钱",@"零钱",@"银行卡",@"交易记录",@"密码管理", nil];
    imageArray = [[NSMutableArray alloc] initWithObjects:@"user_menu_ico_1",@"user_menu_ico_2",@"user_menu_ico_3",@"user_menu_ico_4",@"user_menu_ico_5", nil];
    
    [self.settingBtn addTarget:self action:@selector(settingBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    self.mTableView.backgroundColor = [UIColor colorWithRed:72/255. green:202/255. blue:226/255. alpha:1];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    [self tableViewHeaderViewCreat];
    
    // Do any additional setup after loading the view from its nib.
}

//监听登录状态改变
-(void)LoginStateChangeNotification:(NSNotification *)notification{
    if ([[AppUtils shareAppUtils] getIsLogin]) {
        loginLabel.hidden = YES;
        markLabel.hidden = NO;
        moblieLabel.hidden = NO;
    }else{
        loginLabel.hidden = NO;
        markLabel.hidden = YES;
        moblieLabel.hidden = YES;
    }
}


-(void)tableViewHeaderViewCreat{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 120)];
    headerView.backgroundColor = self.view.backgroundColor;
    
    UIImageView* headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, headerView.frame.size.height-55, 45, 45)];
    headImageView.backgroundColor = [UIColor redColor];
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
    moblieLabel.text = [[AppUtils shareAppUtils] encryptMoblieNumber:[[AppUtils shareAppUtils] getAccount]];
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
        LoginViewController* loginView = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginView animated:YES];
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
    }
    cell.menuTitleLabel.text = [titleArray objectAtIndex:indexPath.row];
    cell.menuImageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
    cell.valueLabel.text = @"";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.swipeController showLeft];
    NSString* menuTitle = [titleArray objectAtIndex:indexPath.row];
    NSLog(@"去%@",menuTitle);
    if ([menuTitle isEqualToString:@"吉有钱"]) {
    }else if ([menuTitle isEqualToString:@"交易记录"]){
        if (![[AppUtils shareAppUtils] getIsLogin]) {
            LoginViewController* loginView = [[LoginViewController alloc] init];
            loginView.loginType = GoIncomeAE;
            loginView.delegate = self;
            [self.navigationController pushViewController:loginView animated:YES];
        }else{
            IncomeAEViewController* incomeAEView = [[IncomeAEViewController alloc] init];
            incomeAEView.delegate = self;
            [self.navigationController pushViewController:incomeAEView animated:YES];
        }
        
    }
    else if ([menuTitle isEqualToString:@"银行卡"]){
        if (![[AppUtils shareAppUtils] getIsLogin]) {
            LoginViewController* loginView = [[LoginViewController alloc] init];
            loginView.loginType = GoBankCardManager;
            loginView.delegate = self;
            [self.navigationController pushViewController:loginView animated:YES];
        }else{
            BankCardManagerViewController* bankCardView = [[BankCardManagerViewController alloc] init];
            bankCardView.delegate = self;
            [self.navigationController pushViewController:bankCardView animated:YES];
        }
        
    }
    else if ([menuTitle isEqualToString:@"密码管理"]){
        if (![[AppUtils shareAppUtils] getIsLogin]) {
            LoginViewController* loginView = [[LoginViewController alloc] init];
            loginView.loginType = GoPasswordManager;
            loginView.delegate = self;
            [self.navigationController pushViewController:loginView animated:YES];
        }else{
            PasswordManagerViewController* passwordManagerView = [[PasswordManagerViewController alloc] init];
            passwordManagerView.delegate = self;
            [self.navigationController pushViewController:passwordManagerView animated:YES];
        }
        
    }else if ([menuTitle isEqualToString:@"零钱"]){
        
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
        }
    }
    else if ([baseViewController isKindOfClass:[PasswordManagerViewController class]]){
        LoginViewController* loginView = [[LoginViewController alloc] init];
        loginView.loginType = OnlyLogin;
        [self.navigationController pushViewController:loginView animated:YES];
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
