//
//  AddAddressViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/29.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "AddAddressViewController.h"
#import "OutView.h"
#import "SelectRegionView.h"
#import "StringUtil.h"
#import "MBProgressHUDManager.h"

@interface AddAddressViewController ()<CustomerViewClickDeleget>{

    __weak IBOutlet NSLayoutConstraint *topLayoutConstraint;
    
    __weak IBOutlet UITextField *region;
    __weak IBOutlet UIView *regionView;
    
    
    __weak IBOutlet UITextField *detailAddress;
    
    
    
    __weak IBOutlet UITextField *familyAddress;
    __weak IBOutlet UIView *detailAddressView;
    
    //删除
    __weak IBOutlet UIView *deletetopLine;
    
    __weak IBOutlet UIView *deletebottomLine;
    
    __weak IBOutlet UILabel *deleteView;
    
    OutView* outView;
    SelectRegionView* selectRegionView;
    
}
@end

@implementation AddAddressViewController
@synthesize deleget=_deleget;
@synthesize address=_address;

- (void)viewDidLoad {
    [super viewDidLoad];
    //top
    topLayoutConstraint.constant = 44.f+STATUSBAR_OFFSET+15.f;
    //ui
    [self initUI];
    //event
}
//初始化ui
-(void)initUI{
    if (!_address) {//添加
        self.navigationItem.title = @"添加地址";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(savaAdress)];
        
        UITapGestureRecognizer* regionGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectRegion)];
        regionView.userInteractionEnabled = YES;
        [regionView addGestureRecognizer:regionGestureRecognizer];
        
        UITapGestureRecognizer* detailAddressGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectDetailAddress)];
        detailAddressView.userInteractionEnabled = YES;
        [detailAddressView addGestureRecognizer:detailAddressGestureRecognizer];
        [self hiddenDelete];
        
    }else{//删除
        familyAddress.enabled = NO;
        self.navigationItem.title = @"我的地址";
        region.text = _address.estimatedAddress;
        detailAddress.text = _address.detailAddress;
        familyAddress.text = _address.detailAddress;
        UITapGestureRecognizer* deleteGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteAddress)];
        deleteView.userInteractionEnabled = YES;
        [deleteView addGestureRecognizer:deleteGestureRecognizer];
        
    }
    region.enabled = NO;
    detailAddress.enabled = NO;

}

//删除地址
-(void)deleteAddress{
    if (!outView) {
        outView = [[OutView alloc]init];
        [outView.outBtn setTitle:@"删除" forState:UIControlStateNormal];
        outView.clickDeleget = self;
    }
    [outView showDialog:self.view];
}
//隐藏删除
-(void)hiddenDelete{
    deletetopLine.hidden = YES;
    deletebottomLine.hidden = YES;
    deleteView.hidden = YES;
    
}
//保存地址
-(void)savaAdress{
    NSLog(@"sava address");
    if ([StringUtil isEmpty:region.text]||[StringUtil isEmpty:detailAddress.text]||[StringUtil isEmpty:familyAddress.text]) {
        [MBProgressHUDManager showMessage:@"请完整填写信息" view:self.view];
    }else if(_deleget){
        Address* address = [[Address alloc]init];
        address.estimatedAddress = region.text;
        address.detailAddress =  [NSString stringWithFormat:@"%@%@",detailAddress.text,familyAddress.text];
        [_deleget addAddress:address];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//选择地区
-(void)selectRegion{
    NSLog(@"sava region");
    if (!selectRegionView) {
        selectRegionView = [[SelectRegionView alloc]init];
        selectRegionView.clickDeleget = self;
    }
    [selectRegionView showDialog:self.view];
}
//选择详情地区
-(void)selectDetailAddress{
    NSLog(@"sava detailAddress");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)click:(NSString *)tag{
    if ([tag isEqualToString:@"cancle"]) {
        region.text = @"";
        detailAddress.text = @"";
        familyAddress.text = @"";
        return;
    }
    
    if (_deleget) {
        [_deleget deleteAddress:_address];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)clickParam:(NSDictionary *)param{
    if (param[@"1"]) {
        region.text = param[@"1"];
    }
    
    if (param[@"2"]) {
        detailAddress.text = param[@"2"];

    }
    
    if (param[@"3"]) {
        familyAddress.text = param[@"3"];

    }
    
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
