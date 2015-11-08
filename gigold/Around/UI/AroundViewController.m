//
//  AroundViewController.m
//  gigold
//
//  Created by 单小萍 on 15/11/6.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "AroundViewController.h"
#import "AroundData.h"
#import "AroundCell.h"
#import "LifeItemData.h"
#import "LifeItemCell.h"
@interface AroundViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{

    
    NSMutableArray* recommendedDatas;
    __weak IBOutlet UITableView *aroundServiceTableView;

    
    NSMutableArray* serviceDatas;
    __weak IBOutlet NSLayoutConstraint *topLayoutConstraint;
    
    __weak IBOutlet NSLayoutConstraint *aroundCollectionHeight;
    __weak IBOutlet UICollectionView *aroundServiceCollectionView;
}
@end

@implementation AroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"周边";
    [self initDatas];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    aroundServiceTableView.estimatedRowHeight = 60.f;
    aroundServiceTableView.backgroundColor = back_ground_color;
    aroundServiceTableView.separatorColor = white_background_diver_color;
    aroundServiceTableView.tableFooterView = [UIView new];
    
    topLayoutConstraint.constant = 44.f+STATUSBAR_OFFSET;
    aroundCollectionHeight.constant = mainScreenWidth*2/5;
    UINib * nib = [UINib nibWithNibName:@"LifeCell" bundle:nil];
    [aroundServiceCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
}
-(void)initDatas{
    if(!recommendedDatas) {
        recommendedDatas = [[NSMutableArray alloc]init];
    }
    AroundData* around1 = [[AroundData alloc]init];
    around1.merchantName  = @"重庆千川渔火锅";
    around1.address  = @"德思勤·四季汇购物中心L4-37/38";
    around1.discount = @"9.8折";
    around1.distance = @"100";
    around1.evaluate = @"23";
    around1.sentWay = @"上门";
    [recommendedDatas addObject:around1];
    
    AroundData* around2 = [[AroundData alloc]init];
    around2.merchantName  = @"花果园鲜花水果店";
    around2.address  = @"德思勤城市广场A7-1008商铺";
    around2.discount = @"满50减5 满200减25";
    around2.distance = @"305";
    around2.evaluate = @"332";
    around2.sentWay = @"";
    [recommendedDatas addObject:around2];
    
    AroundData* around3 = [[AroundData alloc]init];
    around3.merchantName  = @"酷琪ktv量贩";
    around3.address  = @"湘府中路117号";
    around3.discount = @"8折";
    around3.distance = @"205";
    around3.evaluate = @"32";
    around3.sentWay = @"快递";
    [recommendedDatas addObject:around3];
    
    
    if (!serviceDatas) {
        serviceDatas = [[NSMutableArray alloc]init];
    }
    NSArray* descArray = [[NSArray alloc]initWithObjects:@"门禁",@"物业费",@"停车费",@"交水费",@"交电费",@"燃气费",@"公交卡充值",@"还信用卡",nil];
    NSArray* imgArray = [[NSArray alloc]initWithObjects:@"perimeter_ico_1",@"perimeter_ico_2",@"perimeter_ico_3",@"perimeter_ico_4",@"perimeter_ico_5",@"perimeter_ico_6",@"perimeter_ico_1",@"perimeter_ico_1",nil];
    for (int i = 0; i < descArray.count; i++) {
        LifeItemData* lifeItem = [[LifeItemData alloc]init];
        lifeItem.img =  [UIImage imageNamed:imgArray[i]];
        lifeItem.desc =  descArray[i];
        [serviceDatas addObject:lifeItem];
    }

    
}
#pragma mark uitableView 协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return recommendedDatas.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        AroundCell* aroundCell = [[[NSBundle mainBundle] loadNibNamed:@"around_cell" owner:nil options:nil]firstObject];
        AroundData* aroundData = recommendedDatas[indexPath.row];
        aroundCell.merchantsName.text = aroundData.merchantName;
        aroundCell.adress.text = aroundData.address;
        aroundCell.disCount.text = aroundData.discount;
        aroundCell.distance.text = [NSString stringWithFormat:@"%@m",aroundData.distance];
        aroundCell.evaluate.text = [NSString stringWithFormat:@"%@评价",aroundData.evaluate];
        if(indexPath.row == recommendedDatas.count-1){
            aroundCell.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
            aroundCell.layoutMargins = UIEdgeInsetsZero;
        }else{
            aroundCell.separatorInset = UIEdgeInsetsMake(0.f, 10.f, 0.f, 0.f);
        }
        return aroundCell;
}
#pragma mark uicollectionView  协议
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [serviceDatas count];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(mainScreenWidth/4,mainScreenWidth/5);
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LifeItemCell* lifeCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    lifeCell.distance.constant = 5.f;
    LifeItemData* lifeData = serviceDatas[indexPath.row];
    lifeCell.img.image = lifeData.img;
    lifeCell.desc.text = lifeData.desc;
    return lifeCell;
}
@end
