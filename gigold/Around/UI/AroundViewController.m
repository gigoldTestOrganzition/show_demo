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
    __weak IBOutlet NSLayoutConstraint *topLayoutConstraint;
    __weak IBOutlet UITableView *aroundServiceTableView;

    
    NSMutableArray* serviceDatas;
    UICollectionView *aroundServiceCollectionView;
}
@end

@implementation AroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"周边";
    [self initDatas];
    self.automaticallyAdjustsScrollViewInsets = NO;
    topLayoutConstraint.constant = 0.f;//44.f+STATUSBAR_OFFSET;
    aroundServiceTableView.estimatedRowHeight = 60.f;
    aroundServiceTableView.backgroundColor = back_ground_color;
    aroundServiceTableView.separatorColor = white_background_diver_color;
    aroundServiceTableView.tableFooterView = [UIView new];
    UICollectionView* aroundCollectionView =  [self getAroundServiceCollectionView];
    aroundServiceTableView.tableHeaderView = aroundCollectionView;
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
    
    
    AroundData* around8 = [[AroundData alloc]init];
    around8.merchantName  = @"酷琪ktv量贩";
    around8.address  = @"湘府中路117号";
    around8.discount = @"8折";
    around8.distance = @"205";
    around8.evaluate = @"32";
    around8.sentWay = @"快递";
    [recommendedDatas addObject:around8];
    
    
    
    AroundData* around4 = [[AroundData alloc]init];
    around4.merchantName  = @"酷琪ktv量贩";
    around4.address  = @"湘府中路117号";
    around4.discount = @"8折";
    around4.distance = @"205";
    around4.evaluate = @"32";
    around4.sentWay = @"快递";
    [recommendedDatas addObject:around4];
    
    
    
    AroundData* around5 = [[AroundData alloc]init];
    around5.merchantName  = @"酷琪ktv量贩";
    around5.address  = @"湘府中路117号";
    around5.discount = @"8折";
    around5.distance = @"205";
    around5.evaluate = @"32";
    around5.sentWay = @"快递";
    [recommendedDatas addObject:around5];
    
    
    
    AroundData* around6 = [[AroundData alloc]init];
    around6.merchantName  = @"酷琪ktv量贩";
    around6.address  = @"湘府中路117号";
    around6.discount = @"8折";
    around6.distance = @"205";
    around6.evaluate = @"32";
    around6.sentWay = @"快递";
    [recommendedDatas addObject:around6];
    
    
    
    AroundData* around7 = [[AroundData alloc]init];
    around7.merchantName  = @"酷琪ktv量贩";
    around7.address  = @"湘府中路117号";
    around7.discount = @"8折";
    around7.distance = @"205";
    around7.evaluate = @"32";
    around7.sentWay = @"快递";
    [recommendedDatas addObject:around7];
    
    
    if (!serviceDatas) {
        serviceDatas = [[NSMutableArray alloc]init];
    }
    NSArray* descArray = [[NSArray alloc]initWithObjects:@"美食",@"零食",@"理发店",@"母婴店",@"水果店",@"游泳馆",@"药店",@"娱乐",nil];
    NSArray* imgArray = [[NSArray alloc]initWithObjects:@"perimeter_ico_1",@"perimeter_ico_2",@"perimeter_ico_3",@"perimeter_ico_4",@"perimeter_ico_5",@"perimeter_ico_6",@"perimeter_ico_7",@"perimeter_ico_8",nil];
    for (int i = 0; i < descArray.count; i++) {
        LifeItemData* lifeItem = [[LifeItemData alloc]init];
        lifeItem.img =  [UIImage imageNamed:imgArray[i]];
        lifeItem.desc =  descArray[i];
        [serviceDatas addObject:lifeItem];
    }
}
-(UICollectionView*)getAroundServiceCollectionView{
    if (!aroundServiceCollectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        layout.itemSize = CGSizeMake(mainScreenWidth/4,mainScreenWidth*2/5);
        aroundServiceCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0.f,0.f,mainScreenWidth,mainScreenWidth*2/5) collectionViewLayout:layout];
        aroundServiceCollectionView.delegate = self;
        aroundServiceCollectionView.dataSource = self;
        aroundServiceCollectionView.scrollEnabled = NO;
        aroundServiceCollectionView.backgroundColor = [UIColor whiteColor];
        UINib * nib = [UINib nibWithNibName:@"LifeCell" bundle:nil];
        [aroundServiceCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    }
    return aroundServiceCollectionView;
}
#pragma mark uitableView 协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* headView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, mainScreenWidth,35.f)];
    headView.backgroundColor = back_ground_color;
    
    UILabel* headLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.f, 10.f, mainScreenWidth,25.f)];
    headLabel.backgroundColor = back_ground_color;
    headLabel.font = auxiliary_font;
    headLabel.textColor = white_auxiliary_color;
    headLabel.text = @"热门推荐";
    [headView addSubview:headLabel];
    UIView* topline = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, mainScreenWidth,0.5f)];
    topline.backgroundColor = white_background_diver_color;
    [headView addSubview:topline];
    
    UIView* bottomline = [[UIView alloc]initWithFrame:CGRectMake(0.f, 34.5f, mainScreenWidth,0.5f)];
    bottomline.backgroundColor = white_background_diver_color;
    [headView addSubview:bottomline];
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35.f;
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
