//
//  AddressManagerViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/29.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "AddressManagerViewController.h"
#import "Address.h"
#import "AddressCell.h"
#import "AddAddressViewController.h"

@interface AddressManagerViewController ()<UITableViewDelegate,UITableViewDataSource>{

    __weak IBOutlet UITableView *addressTableView;
    NSMutableArray* datas;
}
@end

@implementation AddressManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
    //tableview
    addressTableView.estimatedRowHeight = 44.f;
    addressTableView.tableFooterView = [UIView new];
    addressTableView.tableFooterView.backgroundColor = [UIColor clearColor];
    addressTableView.backgroundColor = back_ground_color;
    addressTableView.separatorColor = back_ground_color;
    [self tableViewFooterViewCreat];
    self.navigationItem.title = @"地址管理";
    NSDictionary* attributeDic = [NSDictionary dictionaryWithObjectsAndKeys:auxiliary_font,UITextAttributeFont,nil];
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributeDic forState:0];
    //[self.navigationItem.rightBarButtonItem setTitleTextAttributes:attributeDic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(addAddress)];
    
    // Do any additional setup after loading the view from its nib.
}

//添加地址
-(void)addAddress{
    AddAddressViewController* addAddressViewController = [[AddAddressViewController alloc]init];
    addAddressViewController.deleget = self;
    [self.navigationController pushViewController:addAddressViewController animated:YES];

}
-(void)initDatas{
    if (!datas) {
        datas = [NSMutableArray new];
    }
    Address* address1 = [Address new];
    address1.estimatedAddress = @"梅西好莱城";
    address1.detailAddress = @"湖南省长沙市河西梅溪湖";
    [datas addObject:address1];
    
    Address* address2 = [Address new];
    address2.estimatedAddress = @"阳光一百";
    address2.detailAddress = @"湖南省长沙市河西";
    [datas addObject:address2];
}
//添加地址
-(void)addAddress:(Address*)address{
    [datas addObject:address];
    [addressTableView reloadData];
}
-(void)deleteAddress:(Address *)address{
    [datas removeObject:address];
    [addressTableView reloadData];
}

-(void)tableViewFooterViewCreat{
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, mainScreenWidth, 120)];
    
    UIView* backgroudView = [[UIView alloc] initWithFrame:CGRectMake(13,5, footerView.frame.size.width-2*13, 70)];
    backgroudView.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:backgroudView];
    
    UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(0,0, 24, 2)];
    view1.backgroundColor = theme_color;
    view1.center = CGPointMake(backgroudView.center.x-10,20);
    
    UIView* view2 = [[UIView alloc] initWithFrame:CGRectMake(0,0, 2, 24)];
    view2.backgroundColor = theme_color;
    view2.center = CGPointMake(backgroudView.center.x-10,20);
    
    [backgroudView addSubview:view1];
    [backgroudView addSubview:view2];
    
    UILabel* addLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view2.frame.origin.y+view2.frame.size.height+10, backgroudView.frame.size.width, 15)];
    addLabel.textAlignment = NSTextAlignmentCenter;
    addLabel.textColor = theme_color;
    addLabel.font = main_font;
    addLabel.text = @"添加地址";
    [backgroudView addSubview:addLabel];
    
    UITapGestureRecognizer* oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addAddress)];
    [backgroudView addGestureRecognizer:oneTap];
    addressTableView.tableFooterView = footerView;
}


#pragma mark - tableview 协议
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Address* address = datas[indexPath.row];
    AddAddressViewController* addressDetailViewController = [[AddAddressViewController alloc]init];
    addressDetailViewController.deleget = self;
    addressDetailViewController.address = address;
    [self.navigationController pushViewController:addressDetailViewController animated:YES];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [datas count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellName = @"cell";
    AddressCell* cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        UINib * nib = [UINib nibWithNibName:@"AddressCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellName];
        cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
        
        
    }
    Address* adress = datas[indexPath.row];
    cell.estimatedAddress.text = adress.estimatedAddress;
    cell.detailAddress.text = adress.detailAddress;
    return cell;
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
