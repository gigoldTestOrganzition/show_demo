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
#import "UserInfoRequest.h"
#import "User_SmallChange.h"

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
    
    dataArray = [[NSMutableArray alloc] init];
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    
    
    [[UserInfoRequest sharedUserInfoRequest] amtdetailqueryPageNum:1 beginDate:nil endDate:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSString* rspCd = [responseObject objectForKey:@"rspCd"];
        NSString* rspInf = [responseObject objectForKey:@"rspInf"];
        if ([rspCd isEqualToString:SUCCESS]) {
            NSDictionary* pageinfo = [responseObject objectForKey:@"pageinfo"];
            NSInteger prePage = [[pageinfo objectForKey:@"prePage"] integerValue];
            if (prePage == 0 || prePage == 1) {
                [dataArray removeAllObjects];
            }
            
            NSArray* list = [pageinfo objectForKey:@"list"];
            
            for (NSDictionary* smallChangDict  in list) {
                User_SmallChange* user_smallChange = [User_SmallChange objectWithKeyValues:smallChangDict];
                if (user_smallChange) {
                    [dataArray addObject:user_smallChange];
                }
            }
            
            if (dataArray.count > 0) {
                self.noneView.hidden = YES;
                self.mTableView.hidden = NO;
            }else{
                self.noneView.hidden = NO;
                self.mTableView.hidden = YES;
            }
            
            [self.mTableView reloadData];
            
        }else{
            [[AppUtils shareAppUtils] showHUD:rspInf andView:self.view];
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error, id responseObject) {
        
    }];
    
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
    
    User_SmallChange* user_smallChange = [dataArray objectAtIndex:indexPath.row];
    cell.styleLabel.text = [NSString stringWithFormat:@"%@",user_smallChange.ordTyp];
    cell.timeLabel.text = user_smallChange.oldTxTm;
    cell.smallChangeLabel.text = [NSString stringWithFormat:@"余额：%ld",user_smallChange.bal];
    
    
    if (user_smallChange.drAmt == 0) {
        cell.moneyLabel.text = [NSString stringWithFormat:@"+%ld",user_smallChange.crAmt];
        cell.moneyLabel.textColor = theme_color;
    }else{
        cell.moneyLabel.text = [NSString stringWithFormat:@"-%ld",user_smallChange.drAmt];
        cell.moneyLabel.textColor = UIColorFromRGB(0xE56767);
    }
    
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
