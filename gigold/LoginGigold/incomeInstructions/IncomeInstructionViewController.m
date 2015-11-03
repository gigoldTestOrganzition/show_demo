//
//  IncomeInstructionViewController.m
//  gigold
//
//  Created by 单小萍 on 15/10/22.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "IncomeInstructionViewController.h"

@interface IncomeInstructionViewController (){

    __weak IBOutlet UILabel *desc1;
    __weak IBOutlet UILabel *desc2;
}
@end

@implementation IncomeInstructionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收益说明";
    [self setDesc];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*设置描述 */
-(void)setDesc{
    NSString* des1String = @"       转入吉有钱的资金在第二个交易日由基金公司进行份额确认，对已确认的份额，基金公司产生收益的当天收益在次日下午15点之前在余额宝中显示\n       温馨提示: 15:00后转入的资金会顺延1个交易日确认，双休日及国家法定假期，基金公司不进行份额确认。";
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:des1String];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:8];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [des1String length])];
    [desc1 setAttributedText:attributedString1];
    
    
    NSString* des2String = @"       收益计算：吉有钱每天的收益都不同，收益计算公式＝ （吉有钱确认金额/10000）*当天基金公司公布的每万份收益。";
    NSMutableAttributedString * attributedString2 = [[NSMutableAttributedString alloc] initWithString:des2String];
    NSMutableParagraphStyle * paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle2 setLineSpacing:8];
    [attributedString2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle2 range:NSMakeRange(0, [des2String length])];
    [desc2 setAttributedText:attributedString2];
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
