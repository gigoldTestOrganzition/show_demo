//
//  BankViewController.m
//  gigold
//
//  Created by 单小萍 on 15/11/6.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "BankViewController.h"
#import "ViewUtil.h"
#import "RuntimeContext.h"
#import "appliacation_attribute.h"
#import "OpenGigoldViewController.h"
#import "GigoldTreasureHomeViewController.h"
#import "StringUtil.h"
#import "SenvenIncomeRateViewController.h"
@interface BankViewController (){
    __weak IBOutlet NSLayoutConstraint *topLayoutConstraint;
    
    __weak IBOutlet UIView *sevenRateView;
    __weak IBOutlet UIView *tenthouSandView;
    __weak IBOutlet UIButton *jiyouqianBtn;
    __weak IBOutlet NSLayoutConstraint *jiyouqianBtnHeight;
}
@end

@implementation BankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"金融";
    topLayoutConstraint.constant = 44.f+STATUSBAR_OFFSET;
    
    [ViewUtil registerGestures:tenthouSandView target:self action:@selector(intoTenthousand)];
    [ViewUtil registerGestures:sevenRateView target:self action:@selector(intoSevenrate)];
    
    
    jiyouqianBtnHeight.constant = mainScreenWidth/3;
    jiyouqianBtn.backgroundColor = [UIColor whiteColor];
    jiyouqianBtn.layer.cornerRadius = jiyouqianBtn.frame.size.height/2;
    jiyouqianBtn.layer.borderWidth = 1.f;
    jiyouqianBtn.layer.borderColor = theme_color.CGColor;
    [ViewUtil registerGestures:jiyouqianBtn target:self action:@selector(intoGiyouqian)];
    
    
    // Do any additional setup after loading the view from its nib.
}
//进入万分收益
-(void)intoTenthousand{
    SenvenIncomeRateViewController* senvenIncomeRateViewController  = (SenvenIncomeRateViewController*)storyboard_controller_identity(@"GigoldTreasureHome", @"senverIncome");
    senvenIncomeRateViewController.showType = IRShowTypeTenthousand;
    [self.navigationController pushViewController:senvenIncomeRateViewController animated:YES];

}
//进入七日年化率
-(void)intoSevenrate{
    SenvenIncomeRateViewController* senvenIncomeRateViewController  = (SenvenIncomeRateViewController*)storyboard_controller_identity(@"GigoldTreasureHome", @"senverIncome");
    senvenIncomeRateViewController.showType = IRShowTypeSeven;
    [self.navigationController pushViewController:senvenIncomeRateViewController animated:YES];
    

}
//进入吉有钱
-(void)intoGiyouqian{
    NSString* openMark =  [[RuntimeContext getInstane]getData:@"open"];
    if (![StringUtil isEmpty:openMark]) {
        GigoldTreasureHomeViewController* giyouqianViewController = storyboard_controller_identity(@"GigoldTreasureHome", @"home");
        //self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:giyouqianViewController animated:YES];
    }else{
        OpenGigoldViewController* openJiyouqianViewController = [[OpenGigoldViewController alloc]init];
        //self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:openJiyouqianViewController animated:YES];
    }


}
@end
