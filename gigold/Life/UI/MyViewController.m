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
#import "GigoldTreasureHomeViewController.h"
#import "ResultShowView.h"
#import "AutomaticArcView.h"
#import "OutView.h"
#import "SecurityPromptView.h"
#import "LoadView.h"
#import "OpenGigoldViewController.h"
#import "CustomerProgressLableView.h"

@interface MyViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CustomerViewClickDeleget>{
    //功能描述
    __weak IBOutlet UICollectionView *functionCollectionView;
    //描述数据集合
    NSMutableArray* functionDatas;
    
//    
//    //测试view
//    ResultShowView* resultShowView;
//    OutView* outView;
//    SecurityPromptView* securityPromptView;
//    LoadView* loadView;
//    CGFloat baseline;
}
@end

@implementation MyViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    //self.hidesBottomBarWhenPushed = NO;
}

//初始化数据
-(void)initData{
    functionDatas = [NSMutableArray new];
    NSArray *desStr = @[@"充值",@"转账",@"话费充值",@"生活缴费",@"物业费",@"停车费",@"吉高宝"];
    NSArray *selArray = [[NSArray alloc]initWithObjects:[NSValue valueWithPointer:@selector(topup)],
        [NSValue valueWithPointer:@selector(transfer)],
        [NSValue valueWithPointer:@selector(phoneTopup)],
        [NSValue valueWithPointer:@selector(lifePay)],
        [NSValue valueWithPointer:@selector(propertyPay)],
            [NSValue valueWithPointer:@selector(stopCarPay)],
        [NSValue valueWithPointer:@selector(gigoldTreasure)],nil];
    
    int i = 0;
    for (NSString* itemStr in desStr) {
        FonctionDesc* fonctionDesc = [FonctionDesc new];
        fonctionDesc.desc = itemStr;
        fonctionDesc.action = [selArray[i++] pointerValue];
        [functionDatas addObject:fonctionDesc];
    }
    
    
    // 测试
    //baseline = 200;
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
    TopUpViewController* topupViewController = (TopUpViewController*)storyboard_controller(@"topUpStoryboard");
    topupViewController.hidesBottomBarWhenPushed = YES;
//    ((UINavigationController*)Etappdelegate.window.rootViewController)
    [((UINavigationController*)Etappdelegate.window.rootViewController) pushViewController:topupViewController animated:YES];
   
    
}
//转账
-(void)transfer{
    NSLog(@"转账");
    
//    if (!resultShowView) {
//        
//        resultShowView = [ResultShowView showResult:ResultTypeError];
//        resultShowView.pullStyle = PullViewDown;
//        resultShowView.drawTime = 5.f;
//        
//    }
//    if (![resultShowView isShow]) {
//        [resultShowView showDialogByBaseLine:baseline view:self.view];
//        
//    }else{
//        [resultShowView stopDialog];
//    }
    
    
}
//话费充值
-(void)phoneTopup{
    NSLog(@"话费充值");
//    if (!outView) {
//        outView = [[OutView alloc]init];
//        outView.pullStyle = PullViewCenter;
//    }
//    if (!outView.isShow) {
//        [outView showDialog:self.view];
//    }else{
//        [outView showDialog:self.view];
//    }
    
}
// 生活缴费
-(void)lifePay{
    NSLog(@"生活缴费");
//    if (!securityPromptView) {
//        securityPromptView = [[SecurityPromptView alloc]init];
//        securityPromptView.clickDeleget = self;
//    }
//    [securityPromptView showDialog:self.view];
}
//物业费
-(void)propertyPay{
    NSLog(@"物业费");
    
        GigoldTreasureHomeViewController* gigoldTreasureHomeViewController = (GigoldTreasureHomeViewController*)storyboard_controller_identity(@"GigoldTreasureHome",@"home");
        gigoldTreasureHomeViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:gigoldTreasureHomeViewController animated:YES];
    
    //if (!loadView) {
    //    loadView = [LoadView showLoad:LoadViewTypeSafeCheck view:self.view];
    //}
    
}
//停车费
-(void)stopCarPay{
    //if (!loadView) {
    //    loadView = [LoadView showLoad:LoadViewTypeJump view:self.view];
    //}
    
}
//吉高宝
-(void)gigoldTreasure{
    
//    GigoldTreasureHomeViewController* gigoldTreasureHomeViewController = (GigoldTreasureHomeViewController*)storyboard_controller_identity(@"GigoldTreasureHome",@"home");
//    gigoldTreasureHomeViewController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:gigoldTreasureHomeViewController animated:YES];
    
    OpenGigoldViewController* openGigoldViewController = [[OpenGigoldViewController alloc]init];
    [self.navigationController pushViewController:openGigoldViewController animated:YES];
}

#pragma mark -UICollectionView  协议
-(void)click:(NSString *)tag{
    NSLog(@"设置支付密码");
   
}
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
    FonctionDesc* funDesc =  functionDatas[indexPath.row];
    [self performSelector:funDesc.action];
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(screenWidth/3-1,screenWidth/4);
}

@end
