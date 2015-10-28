//
//  SmallChangeViewController.m
//  gigold
//
//  Created by wsc on 15/10/27.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "SmallChangeViewController.h"
#import "SmallChangeTableViewCell.h"
#import "StringUtil.h"

@interface SmallChangeViewController ()

@end

@implementation SmallChangeViewController

- (void)setTitle:(NSString *)title{
    if ([title isEqualToString:@"全部"]){
        title = @"收支明细";
    }
    CGFloat width = [StringUtil getStringWidth:title font:title_or_btn_font size:CGSizeMake(MAXFLOAT, 44)];
    
    if (navTitleView) {
        [navTitleView removeFromSuperview];
        navTitleView = nil;
    }
    
    navTitleView = [[UIView alloc] init];
    titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = title_or_btn_font;
    titleLabel.textColor = [UIColor whiteColor];
        
    [navTitleView addSubview:titleLabel];
        
    markImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_menu_but_arrow"]];
    [navTitleView addSubview:markImageView];
        
    UITapGestureRecognizer* oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTilePress)];
        [navTitleView addGestureRecognizer:oneTap];
    
    
    navTitleView.frame = CGRectMake(0, 0, width+22, 44);
    titleLabel.frame = CGRectMake(0, 0, width, 44);
    markImageView.frame = CGRectMake(width+10, 16, 12, 12);
    [self.navigationItem setTitleView:navTitleView];
    
    titleLabel.text = title;
    
    NSLog(@"%f %f %f %f", markImageView.transform.tx,markImageView.transform.ty, markImageView.transform.c, markImageView.transform.d);
}

-(void)headTilePress{
    NSLog(@"弹出菜单");
    if (!popView) {
        UIView* showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, 45*menuTitles.count)];
        showView.backgroundColor = [UIColor whiteColor];
        
        for (NSInteger i = 0 ; i < menuTitles.count; i++) {
            UILabel* menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 45*i, showView.frame.size.width, 45)];
            menuLabel.backgroundColor = [UIColor clearColor];
            menuLabel.userInteractionEnabled = YES;
            menuLabel.font = main_font;
            menuLabel.textColor = main_text_color;
            menuLabel.text = [NSString stringWithFormat:@"         %@",[menuTitles objectAtIndex:i]];
            [showView addSubview:menuLabel];
            
            UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[menuImages objectAtIndex:i]]];
            imageView.frame = CGRectMake(10, 14.5, 16, 16);
            [menuLabel addSubview:imageView];
            
            UIView* shadowView = [[UIView alloc] initWithFrame:CGRectMake(10, menuLabel.frame.size.height-0.5, menuLabel.frame.size.width-10, 0.5)];
            shadowView.backgroundColor = gray_diver_color;
            if (i == menuTitles.count - 1) {
                shadowView.frame = CGRectMake(0, menuLabel.frame.size.height-0.5, menuLabel.frame.size.width, 0.5);
            }
            
            UITapGestureRecognizer* oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelPress:)];
            [menuLabel addGestureRecognizer:oneTap];
            
            [menuLabel addSubview:shadowView];
        }
        
        popView = [[CustomerView alloc] init];
        popView.showView = showView;
        popView.pullStyle = PullViewTop;
    }
    
    if (popView.superview) {
        [popView stopDialog];
    }else{
        [popView showDialogByBaseLine:44+STATUSBAR_OFFSET view:self.view];
         [popView showDialog:self.view];
    }
    
    if (markImageView.transform.a == 1) {
         markImageView.transform = CGAffineTransformMakeRotation((180.0f * M_PI) / 180.0f);
    }else{
         markImageView.transform = CGAffineTransformMakeRotation((0.0f * M_PI) / 180.0f);
    }
}

-(void)labelPress:(UITapGestureRecognizer*)gesture{
    UILabel* label = (UILabel*)gesture.view;
    NSString* titleString = [label.text componentsSeparatedByString:@" "].lastObject;
    self.title = titleString;
    [self headTilePress];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收支明细";
    
    menuTitles = [[NSMutableArray alloc] initWithObjects:@"全部",@"收入",@"支出", nil];
    menuImages = [[NSMutableArray alloc] initWithObjects:@"ico_statement_1",@"ico_statement_2",@"ico_statement_3", nil];
    
    NSDictionary* dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"2015-10-10",@"time",@"账户充值",@"style",@"80",@"smallChange",@"+80",@"money", nil];
    NSDictionary* dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"2015-10-11",@"time",@"账户充值",@"style",@"160",@"smallChange",@"+80",@"money", nil];
    NSDictionary* dict3 = [NSDictionary dictionaryWithObjectsAndKeys:@"2015-10-12",@"time",@"账户充值",@"style",@"360",@"smallChange",@"+200",@"money", nil];
    NSDictionary* dict4 = [NSDictionary dictionaryWithObjectsAndKeys:@"2015-10-13",@"time",@"提现",@"style",@"260",@"smallChange",@"-100",@"money", nil];
    NSDictionary* dict5 = [NSDictionary dictionaryWithObjectsAndKeys:@"2015-10-15",@"time",@"商品消费",@"style",@"140",@"smallChange",@"-120",@"money", nil];
    
//    dataArray = [[NSMutableArray alloc] init];
    dataArray = [[NSMutableArray alloc] initWithObjects:dict5,dict4,dict3,dict2,dict1, nil];
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    
    if (dataArray.count > 0) {
        self.noneView.hidden = YES;
        self.mTableView.hidden = NO;
    }else{
        self.noneView.hidden = NO;
        self.mTableView.hidden = YES;
    }
    
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark ---- UITableViewDataSource,UITableViewDelegate --------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellString = @"SmallChangeTableViewCell";
    SmallChangeTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (!cell) {
        cell= [[[NSBundle mainBundle]loadNibNamed:@"SmallChangeTableViewCell" owner:nil options:nil] firstObject];
    }
    
    cell.styleLabel.text = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"style"];
    cell.timeLabel.text = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"time"];
    cell.smallChangeLabel.text = [NSString stringWithFormat:@"余额：%@",[[dataArray objectAtIndex:indexPath.row] objectForKey:@"smallChange"]];
    cell.moneyLabel.text = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"money"];;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
