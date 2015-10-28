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
    self.title = @"服务协议";
    
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
    
//  读取自定义的plist文件
    NSString* key = @"";
    if (self.serviceTextType == Service_GigoldType) {
        key = @"吉高支付服务协议";
    }else if (self.serviceTextType == Service_FastPayType){
        key = @"快捷支付服务协议";
    }else if (self.serviceTextType == Service_Bank_CMBType){
        key = @"招行快捷支付协议";
    }
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ServiceText" ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSLog(@"dictionary = %@",dictionary);
    
    
    NSString* contentString = [dictionary objectForKey:key];
    
    CGSize size = [self contentSize:contentString];
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, 55+size.height+10)];
    
    UILabel* headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 55)];
    headLabel.backgroundColor = [UIColor clearColor];
    headLabel.font = main_font;
    headLabel.textColor = main_text_color;
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.lineBreakMode = NSLineBreakByWordWrapping;
    headLabel.text = key;
    
    [headerView addSubview:headLabel];
    
    UILabel* contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 55, headerView.frame.size.width-2*15, size.height)];
    contentLabel.backgroundColor = [UIColor clearColor];
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
