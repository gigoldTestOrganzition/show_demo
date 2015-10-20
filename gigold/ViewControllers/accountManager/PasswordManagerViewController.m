//
//  PasswordManagerViewController.m
//  gigold
//
//  Created by wsc on 15/10/12.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "PasswordManagerViewController.h"
#import "ResetPasswordViewController.h"

@interface PasswordManagerViewController ()

@end

@implementation PasswordManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.leftBtn addTarget:self action:@selector(leftBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
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

    cell.textLabel.text = @"密码修改";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ResetPasswordViewController* resetView = [[ResetPasswordViewController alloc] init];
    resetView.titleLabel.text = @"重置密码";
    [self.navigationController pushViewController:resetView animated:YES];
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
