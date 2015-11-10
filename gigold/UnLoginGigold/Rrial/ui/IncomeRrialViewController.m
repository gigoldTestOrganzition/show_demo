//
//  IncomeRrialViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/31.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "IncomeRrialViewController.h"
#import "appliacation_attribute.h"
#import "RollInViewController.h"
@interface IncomeRrialViewController (){

    
    __weak IBOutlet NSLayoutConstraint *topLayoutConstraint;
    
    __weak IBOutlet UILabel *amountNumber;
    
    __weak IBOutlet UISlider *howSilder;
    __weak IBOutlet UILabel *minAmount;
    __weak IBOutlet UILabel *maxAmount;
    
    __weak IBOutlet UILabel *jiyouqianIncome;
    
    __weak IBOutlet UILabel *bankIncome;
    __weak IBOutlet UIButton *rollInBtn;
    
    int progressValue;
    float sliderValue;
}
@end

@implementation IncomeRrialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    topLayoutConstraint.constant = 0.f;//44.f+STATUSBAR_OFFSET;
    self.navigationItem.title = @"预期收益试算";
    progressValue = 10;
    sliderValue = 10;
    [howSilder setThumbImage:[UIImage imageNamed:@"jyq_shisuan_round.png"] forState:UIControlStateNormal];
    [howSilder setThumbImage:[UIImage imageNamed:@"jyq_shisuan_round.png"] forState:UIControlStateHighlighted];
    
    [howSilder addTarget:self action:@selector(changeAmount:) forControlEvents:UIControlEventValueChanged];
    [howSilder addTarget:self action:@selector(setSliderProgress) forControlEvents:UIControlEventTouchUpInside];
    rollInBtn.layer.cornerRadius = rollInBtn.frame.size.height/2;
}
//滑动改变金额
-(void)changeAmount:(id)sender{
    
    UISlider* slider = sender;
    [self filterValue:slider.value];
    int currentValue = progressValue*100000/100;
    amountNumber.text = [NSString stringWithFormat:@"%i",currentValue];
    sliderValue = slider.value;
}
//设置进度
-(void)setSliderProgress{
    howSilder.value = progressValue;
}
/*
 *判断是否是整数
 */
-(void)filterValue:(float)value{
    if (value > sliderValue){
        progressValue++;
        if (progressValue > 100) {
            progressValue = 100;
        }
 
    }else if (value < sliderValue){
        progressValue--;
        if (progressValue < 0) {
            progressValue = 0;
        }
    }

}
//转入金额
- (IBAction)rollInAmount:(id)sender {
    RollInViewController*  rollInViewController = storyboard_controller_identity(@"GigoldTreasureHome", @"rollIn");
    rollInViewController.amountStr = amountNumber.text;
    [self.navigationController pushViewController:rollInViewController animated:YES];
}


@end
