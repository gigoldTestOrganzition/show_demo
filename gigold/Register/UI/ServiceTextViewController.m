//
//  ServiceTextViewController.m
//  gigold
//
//  Created by wsc on 15/10/27.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "ServiceTextViewController.h"

@interface ServiceTextViewController ()

@end

@implementation ServiceTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableViewHeaderViewCreat];
    
    // Do any additional setup after loading the view from its nib.
}

- (CGSize)contentSize:(NSString*)contentString {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary * attributes = @{NSFontAttributeName : prompt_or_icon_font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize contentSize = [contentString boundingRectWithSize:CGSizeMake(mainScreenWidth-2*15, MAXFLOAT)
                                                 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                              attributes:attributes
                                                 context:nil].size;
    return contentSize;
}

-(void)tableViewHeaderViewCreat{
    
    NSString* contentString = @"用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议。 文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用户协议文字用。";
    
    CGSize size = [self contentSize:contentString];
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, 55+size.height)];
    
    UILabel* headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 55)];
    headLabel.backgroundColor = [UIColor clearColor];
    headLabel.font = main_font;
    headLabel.textColor = main_text_color;
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.lineBreakMode = NSLineBreakByWordWrapping;
    headLabel.text = @"吉高钱包用户协议";
    [headerView addSubview:headLabel];
    
    UILabel* contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 55, headerView.frame.size.width-2*15, size.height)];
    contentLabel.backgroundColor = [UIColor redColor];
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.font = prompt_or_icon_font;
    contentLabel.textColor = main_text_color;
    contentLabel.numberOfLines = 0;
    contentLabel.text = contentString;
    [headerView addSubview:contentLabel];
    
    
    self.mTableView.tableHeaderView = headerView;
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
