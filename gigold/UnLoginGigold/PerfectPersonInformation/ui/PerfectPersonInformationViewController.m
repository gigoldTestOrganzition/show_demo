//
//  PerfectPersonInformationViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/30.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "PerfectPersonInformationViewController.h"
#import "AddOpenBankCardViewController.h"
#import "StringUtil.h"

@interface PerfectPersonInformationViewController ()<UITextFieldDelegate>{
    __weak IBOutlet UITextField *name;
    __weak IBOutlet UITextField *idCard;
    __weak IBOutlet NSLayoutConstraint *topLayoutConstraint;
    
    __weak IBOutlet UIButton *nextBtn;
    
}

@end

@implementation PerfectPersonInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    topLayoutConstraint.constant = 25.f;
    self.navigationItem.title = @"完善个人信息";
    nextBtn.enabled = NO;
    nextBtn.layer.cornerRadius = nextBtn.frame.size.height/2;
    // Do any additional setup after loading the view from its nib.
}
//下一步
- (IBAction)next:(id)sender {
    AddOpenBankCardViewController* addOpenBankCardViewController = [[AddOpenBankCardViewController alloc]init];
    addOpenBankCardViewController.name = name.text;
    [self.navigationController pushViewController:addOpenBankCardViewController animated:YES];
}
#pragma  mark -tableView
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSInteger value = textField.text.length-range.length+string.length;
    if (value <= 0) {
        nextBtn.backgroundColor = unable_tap_color;
    }else{
        if(textField == name) {
            if ([StringUtil isEmpty:idCard.text]) {
                nextBtn.backgroundColor = unable_tap_color;
                nextBtn.enabled = NO;
            }else{
                nextBtn.backgroundColor = theme_color;
                nextBtn.enabled = YES;
            }
        }else{
            if ([StringUtil isEmpty:name.text]) {
                nextBtn.backgroundColor = unable_tap_color;
                nextBtn.enabled = NO;
            }else{
                nextBtn.backgroundColor = theme_color;
                nextBtn.enabled = YES;
            }
        }
    }
    
    
    if (value > 15) {
        return NO;
    }else{
        return YES;
    }
}
@end
