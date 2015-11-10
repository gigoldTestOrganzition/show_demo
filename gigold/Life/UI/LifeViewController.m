//
//  LifeViewController.m
//  gigold
//
//  Created by 单小萍 on 15/11/6.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "LifeViewController.h"
#import "LifeItemData.h"
#import "LifeItemCell.h"
@interface LifeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{

    __weak IBOutlet NSLayoutConstraint *topLayoutConstraint;
    
    __weak IBOutlet UICollectionView *collectionView;
    NSMutableArray* lifeDatas;
    
    
    __weak IBOutlet NSLayoutConstraint *bottomLine;
    
    
}
@end

@implementation LifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"生活";
    topLayoutConstraint.constant = 0.f;//44.f+STATUSBAR_OFFSET;
    [self initDatas];
    UINib * nib = [UINib nibWithNibName:@"LifeCell" bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing=0.5f;
    layout.minimumLineSpacing = 0.5f;
    collectionView.collectionViewLayout = layout;
    collectionView.scrollEnabled = NO;
    // Do any additional setup after loading the view from its nib.
    bottomLine.constant = 0.5f;
}

//初始化数据
-(void)initDatas{
    if (!lifeDatas) {
        lifeDatas = [[NSMutableArray alloc]init];
    }
    NSArray* descArray = [[NSArray alloc]initWithObjects:@"门禁",@"物业费",@"停车费",@"交水费",@"交电费",@"燃气费",@"公交卡充值",@"还信用卡",@"充话费",nil];
    NSArray* imgArray = [[NSArray alloc]initWithObjects:@"life_ico_1",@"life_ico_2",@"life_ico_3",@"life_ico_4",@"life_ico_5",@"life_ico_6",@"life_ico_7",@"life_ico_8",@"life_ico_9",nil];
    for (int i = 0; i < descArray.count; i++) {
        LifeItemData* lifeItem = [[LifeItemData alloc]init];
        lifeItem.img =  [UIImage imageNamed:imgArray[i]];
        lifeItem.desc =  descArray[i];
        [lifeDatas addObject:lifeItem];
    }
}
#pragma mark -UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [lifeDatas count];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(mainScreenWidth/3-0.5, mainScreenWidth/3-0.5);
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LifeItemCell* lifeCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    LifeItemData* lifeData = lifeDatas[indexPath.row];
    lifeCell.img.image = lifeData.img;
    lifeCell.desc.text = lifeData.desc;
    return lifeCell;
}
@end
