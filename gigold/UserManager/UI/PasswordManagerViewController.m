//
//  PasswordManagerViewController.m
//  gigold
//
//  Created by wsc on 15/10/12.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "PasswordManagerViewController.h"
#import "UpdataPWDViewController.h"
#import "PayPasswordViewController.h"
#import "VerificationCodeWriteViewController.h"

@interface PasswordManagerViewController ()

@end

@implementation PasswordManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"密码管理";
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}

-(void)leftBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---- UITableViewDataSource,UITableViewDelegate --------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellString = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor colorWithRed:89/255. green:89/255. blue:89/255. alpha:1];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"修改登录密码";
    }else{
        cell.textLabel.text = @"修改支付密码";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UpdataPWDViewController* updataPWDView = [[UpdataPWDViewController alloc] init];
        updataPWDView.title = @"修改登录密码";
        [self.navigationController pushViewController:updataPWDView animated:YES];
    }
    else if (indexPath.row == 1){
        VerificationCodeWriteViewController* verificationCodeWriteView = [[VerificationCodeWriteViewController alloc] init];
        verificationCodeWriteView.title = @"修改支付密码";
        verificationCodeWriteView.moblieNum = [[AppUtils shareAppUtils] getAccount];
        verificationCodeWriteView.flowType = UpdataPayPWDType;
        [self.navigationController pushViewController:verificationCodeWriteView animated:YES];
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
