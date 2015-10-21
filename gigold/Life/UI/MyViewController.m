//
//  MyViewController.m
//  水果糖
//
//  Created by MacPro on 15-7-7.
//  Copyright (c) 2015年wsc. All rights reserved.
//

#import "MyViewController.h"
#import "FonctionDesc.h"
#import "FonctionCell.h"
#import "appliacation_attribute.h"
#import "TopUpViewController.h"

@interface MyViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    //功能描述
    __weak IBOutlet UICollectionView *functionCollectionView;
    //描述数据集合
    NSMutableArray* functionDatas;
}
@end

@implementation MyViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.hidesBottomBarWhenPushed = NO;
}

//初始化数据
-(void)initData{
    functionDatas = [NSMutableArray new];
    NSArray *desStr = @[@"充值",@"转账",@"话费充值",@"生活缴费",@"物业费",@"停车费",@"吉高宝"];
    for (NSString* itemStr in desStr) {
        FonctionDesc* fonctionDesc = [FonctionDesc new];
        fonctionDesc.desc = itemStr;
        [functionDatas addObject:fonctionDesc];
    }
 }


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
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

#pragma mark -action 功能响应
//充值
-(void)topup{
    //NSLog(@"充值");
    
    TopUpViewController* topupViewController = (TopUpViewController*)storyboard_controller(@"topUpStoryboard");
    topupViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:topupViewController animated:YES];
    //[self presentViewController:topupViewController animated:NO completion:nil];
    
}
//转账
-(void)transfer{
    
}
//话费充值
-(void)phoneTopup{
    
}
// 生活缴费
-(void)lifePay{
    
}
//物业费
-(void)propertyPay{
    
}
//停车费
-(void)stopCarPay{
    
}
//吉高宝
-(void)gigoldTreasure{
    
}






#pragma mark -UICollectionView  协议
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [functionDatas count];
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    FonctionCell* cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    FonctionDesc* fundata =  functionDatas[indexPath.row];
    
    cell.txt.text = fundata.desc;
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   //FonctionDesc* funDesc =  functionDatas[indexPath.row];
    if (indexPath.row == 0) {
        [self performSelector:@selector(topup)];
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(screenWidth/3-1,screenWidth/4);
}

@end
