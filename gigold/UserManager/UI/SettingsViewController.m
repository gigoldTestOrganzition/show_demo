//
//  SettingsViewController.m
//  gigold
//
//  Created by wsc on 15/10/24.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    dataArray = [[NSMutableArray alloc] init];
    
    [dataArray addObject:[NSMutableArray arrayWithObjects:@"消息通知", nil]];
    [dataArray addObject:[NSMutableArray arrayWithObjects:@"帮助",@"反馈",@"关于", nil]];
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    if ([[AppUtils shareAppUtils] getIsLogin]) {
        [self tableViewFooterViewCreat];
    }
    // Do any additional setup after loading the view from its nib.
}

-(void)tableViewFooterViewCreat{
    UIButton* logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.backgroundColor = [UIColor whiteColor];
    logoutBtn.frame = CGRectMake(0, 0, mainScreenWidth, 45);
    [logoutBtn setTitleColor:[UIColor colorWithRed:72/255. green:202/255. blue:226/255. alpha:1] forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(logoutBtnPress) forControlEvents:UIControlEventTouchUpInside];
    logoutBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    
    UIView* shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, logoutBtn.frame.size.width, 0.5)];
    shadowView.backgroundColor = gray_diver_color;
    [logoutBtn addSubview:shadowView];
    
    shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, logoutBtn.frame.size.height-0.5, logoutBtn.frame.size.width, 0.5)];
    shadowView.backgroundColor = gray_diver_color;
    [logoutBtn addSubview:shadowView];
    
    self.mTableView.tableFooterView = logoutBtn;
}

-(void)logoutBtnPress{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您确定要退出当前帐号吗？\n退出后您将不会收到新的推送消息 " delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert show];
}

#pragma mark - alert

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self logoutRespond];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark ---- UITableViewDataSource,UITableViewDelegate --------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray* item = [dataArray objectAtIndex:section];
    return item.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 20.f;
    }
    return 10.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellString = @"SettingCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (!cell) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = main_text_color;
    cell.textLabel.text = [[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
