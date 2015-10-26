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
    
    dataArray = [[NSMutableArray alloc] init];
    [dataArray addObject:@"修改登录密码"];
    if ([[AppUtils shareAppUtils] getIsPayPwd]) {
        [dataArray addObject:@"修改支付密码"];
    }else{
        [dataArray addObject:@"设置支付密码"];
    }
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}

-(void)leftBtnPress{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---- UITableViewDataSource,UITableViewDelegate --------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
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
    cell.textLabel.textColor = main_text_color;
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* typeString = [dataArray objectAtIndex:indexPath.row];
    
    if ([typeString isEqualToString:@"修改登录密码"]) {
        UpdataPWDViewController* updataPWDView = [[UpdataPWDViewController alloc] init];
        updataPWDView.title = typeString;
        updataPWDView.delegate = self;
        [self.navigationController pushViewController:updataPWDView animated:YES];
    }
    else if ([typeString isEqualToString:@"设置支付密码"]){
        VerificationCodeWriteViewController* verificationCodeWriteView = [[VerificationCodeWriteViewController alloc] init];
        verificationCodeWriteView.title = typeString;
        verificationCodeWriteView.delegate = self;
        verificationCodeWriteView.moblieNum = [[AppUtils shareAppUtils] getAccount];
        verificationCodeWriteView.flowType = SetPayPWDType;
        [self.navigationController pushViewController:verificationCodeWriteView animated:YES];
    }
    else if ([typeString isEqualToString:@"修改支付密码"]){
        VerificationCodeWriteViewController* verificationCodeWriteView = [[VerificationCodeWriteViewController alloc] init];
        verificationCodeWriteView.title = typeString;
        verificationCodeWriteView.delegate = self;
        verificationCodeWriteView.moblieNum = [[AppUtils shareAppUtils] getAccount];
        verificationCodeWriteView.flowType = UpdataPayPWDType;
        [self.navigationController pushViewController:verificationCodeWriteView animated:YES];
    }
    
}

#pragma mark ---- BaseViewControllerDelegate --------

-(void)UIViewControllerBack:(BaseViewController *)baseViewController{
    if ([baseViewController isKindOfClass:[UpdataPWDViewController class]]) {
        [self.navigationController popViewControllerAnimated:NO];
        if ([self.delegate respondsToSelector:@selector(UIViewControllerBack:)]) {
            [self.delegate performSelector:@selector(UIViewControllerBack:) withObject:self];
        }
    }else if ([baseViewController isKindOfClass:[VerificationCodeWriteViewController class]]){
        if ([[AppUtils shareAppUtils] getIsPayPwd]) {
            [dataArray replaceObjectAtIndex:1 withObject:@"修改支付密码"];
        }else{
            [dataArray replaceObjectAtIndex:1 withObject:@"设置支付密码"];
        }
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
