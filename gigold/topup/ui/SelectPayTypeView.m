//
//  SelectPayTypeView.m
//  gigold
//
//  Created by 单小萍 on 15/10/26.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "SelectPayTypeView.h"
@interface SelectPayTypeView(){}
@end
@implementation SelectPayTypeView
@synthesize selectPayTypeTableView=_selectPayTypeTableView;
@synthesize cancleImg=_cancleImg;
@synthesize title=_title;
@synthesize delegate = _delegate;
@synthesize dataSource = _dataSource;
@synthesize titleStr=_titleStr;
-(instancetype)init{
    self = [super init];
    if (self) {
        [self initUI];
        [self initEvent];
    }
    return self;
}
// 初始化ui
-(void)initUI{
    SelectPayTypeView* contentView = [[NSBundle mainBundle]loadNibNamed:@"SelectPayTypeView" owner:self options:nil][0];
    contentView.frame = CGRectMake(0,0, mainScreenWidth,contentView.frame.size.height);
    self.cancleImg = contentView.cancleImg;
    self.selectPayTypeTableView = contentView.selectPayTypeTableView;
    self.title = contentView.title;
    self.showView = contentView;
    
}
//初始化事件
-(void)initEvent{
    UITapGestureRecognizer* cancleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stopDialog)];
    _cancleImg.userInteractionEnabled = YES;
    [_cancleImg addGestureRecognizer:cancleRecognizer];
}
-(void)setDelegate:(id<UITableViewDelegate>)delegat{
    _selectPayTypeTableView.delegate = delegat;
}
-(void)setDataSource:(id<UITableViewDataSource>)dataSource{
    _selectPayTypeTableView.dataSource = dataSource;
}
-(void)setTitleStr:(NSString *)titleStr{
    _title.text = titleStr;
}
@end
