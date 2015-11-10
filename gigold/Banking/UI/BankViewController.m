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
#import "TopUpViewController.h"
#import "appliacation_attribute.h"
@interface BankViewController (){
    __weak IBOutlet NSLayoutConstraint *topLayoutConstraint;
    
    __weak IBOutlet UIView *sevenRateView;
    __weak IBOutlet UIView *tenthouSandView;
    __weak IBOutlet UIButton *jiyouqianBtn;
    __weak IBOutlet NSLayoutConstraint *jiyouqianBtnHeight;
    //零钱
    __weak IBOutlet UIView *smallChangeView;
    
    //线
    __weak IBOutlet NSLayoutConstraint *line1;
    __weak IBOutlet NSLayoutConstraint *line2;
    __weak IBOutlet NSLayoutConstraint *line3;
    __weak IBOutlet NSLayoutConstraint *line4;
    __weak IBOutlet NSLayoutConstraint *line5;
    
    __weak IBOutlet NSLayoutConstraint *line6;
    
    __weak IBOutlet NSLayoutConstraint *line7;
    
    
}
@end

@implementation BankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"金融";
    topLayoutConstraint.constant = 0.f;//44.f+STATUSBAR_OFFSET;
    
    
    
    [ViewUtil registerGestures:tenthouSandView target:self action:@selector(intoTenthousand)];
    [ViewUtil registerGestures:sevenRateView target:self action:@selector(intoSevenrate)];
    
    
    jiyouqianBtnHeight.constant = mainScreenWidth/3;
    jiyouqianBtn.backgroundColor = [UIColor whiteColor];
    jiyouqianBtn.layer.cornerRadius = jiyouqianBtn.frame.size.height/2;
    jiyouqianBtn.layer.borderWidth = 1.f;
    jiyouqianBtn.layer.borderColor = theme_color.CGColor;
    [ViewUtil registerGestures:jiyouqianBtn target:self action:@selector(intoGiyouqian)];
    //零钱
    [ViewUtil registerGestures:smallChangeView target:self action:@selector(intoSmallChange)];
    
    
    [self setLine];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)setLine{
    line1.constant = 0.5;
    line2.constant = 0.5;

    line3.constant = 0.5;

    line4.constant = 0.5;

    line5.constant = 0.5;

    line6.constant = 0.5;

    line7.constant = 0.5;

}
//进入万分收益
-(void)intoTenthousand{
    SenvenIncomeRateViewController* senvenIncomeRateViewController  = (SenvenIncomeRateViewController*)storyboard_controller_identity(@"GigoldTreasureHome", @"senverIncome");
    senvenIncomeRateViewController.showType = IRShowTypeTenthousand;
     [((UINavigationController*)Etappdelegate.window.rootViewController) pushViewController:senvenIncomeRateViewController animated:YES];
    
    //[self.navigationController pushViewController:senvenIncomeRateViewController animated:YES];

}
//进入七日年化率
-(void)intoSevenrate{
    SenvenIncomeRateViewController* senvenIncomeRateViewController  = (SenvenIncomeRateViewController*)storyboard_controller_identity(@"GigoldTreasureHome", @"senverIncome");
    senvenIncomeRateViewController.showType = IRShowTypeSeven;
     [((UINavigationController*)Etappdelegate.window.rootViewController) pushViewController:senvenIncomeRateViewController animated:YES];
    //[self.navigationController pushViewController:senvenIncomeRateViewController animated:YES];
    

}
//进入吉有钱
-(void)intoGiyouqian{
    NSString* openMark =  [[RuntimeContext getInstane]getData:@"open"];
    if (![StringUtil isEmpty:openMark]) {
        GigoldTreasureHomeViewController* giyouqianViewController = storyboard_controller_identity(@"GigoldTreasureHome", @"home");
        [((UINavigationController*)Etappdelegate.window.rootViewController) pushViewController:giyouqianViewController animated:YES];
        //self.hidesBottomBarWhenPushed=YES;
        //[self.navigationController pushViewController:giyouqianViewController animated:YES];
    }else{
        OpenGigoldViewController* openJiyouqianViewController = [[OpenGigoldViewController alloc]init];
        [((UINavigationController*)Etappdelegate.window.rootViewController) pushViewController:openJiyouqianViewController animated:YES];
        //self.hidesBottomBarWhenPushed = YES;
        //[self.navigationController pushViewController:openJiyouqianViewController animated:YES];
    }


}
//进入零钱
-(void)intoSmallChange{
    TopUpViewController* topViewController = storyboard_controller_identity(@"topUpStoryboard",@"topup");
    [((UINavigationController*)Etappdelegate.window.rootViewController) pushViewController:topViewController animated:YES];
    //[self.navigationController pushViewController:topViewController animated:YES];
}
@end
