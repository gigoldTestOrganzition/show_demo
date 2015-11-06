//
//  PageTableviewdragloading.m
//  eteams
//
//  Created by caidengshan on 1/16/14.
//  Copyright (c) 2014 王 苏诚. All rights reserved.
//

#import "PageTableviewdragloading.h"


@implementation PageTableViewFootView
@synthesize isLoading;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        v.backgroundColor = [UIColor clearColor];
//        v.backgroundColor=[UIColor colorWithRed:221.0f/255 green:221.0f/255 blue:221.0f/255 alpha:1];
        indicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicatorView.frame = CGRectMake(frame.size.width/3, 12, 20, 20);
        [v addSubview:indicatorView];
        [indicatorView startAnimating];        
        self.labelView=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.labelView.backgroundColor=[UIColor clearColor];
        self.labelView.textAlignment=NSTextAlignmentCenter;
        self.labelView.text=@"向上拖动显示更多";
        self.labelView.textColor = [UIColor colorWithRed:179.0f/255.0f green:179.0f/255.0f blue:179.0f/255.0f alpha:1];
        self.labelView.font=[UIFont systemFontOfSize:15];
        [v addSubview:self.labelView];
        [self addSubview:v];
    }
    return self;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

-(void)setIsLoading:(BOOL)is{
    isLoading=is;
    if(isLoading){
        [indicatorView startAnimating];
        self.labelView.text=@"正在加载";
    }else{
        [indicatorView stopAnimating];
        self.labelView.text=@"向上拖动加载更多";
    }
}

@end


@implementation PageTableviewdragloading


-(id)initWithTableView:(UITableView *)table{
    self=[super init];
    if (self) {
        self.pagenum = 0;
        self.table = table;
        isableloading= YES;
        footView=[[PageTableViewFootView alloc] initWithFrame:CGRectMake(0,0,mainScreenWidth,44)];
        //self.table.tableFooterView = footView;
    }
    return self;
}

-(void)removeTableView{
    self.table.tableFooterView = nil;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(self.isloading){
        return;
    }
    if(scrollView.contentOffset.y>0 && (scrollView.contentOffset.y>scrollView.contentSize.height-scrollView.frame.size.height)){
        if (self.pagenum < self.pages) {
            [self beginLoad];
        }
    }
}

-(void)beginLoad{
    self.isloading=YES;
    self.pagenum ++;
    [footView setIsLoading:YES];
    [self.delegate startPaging:self.pagenum withSize:8];
}

-(void)reset{
    self.pagenum = 0;
    self.isloading = NO;
    self.pages = 0;
    self.table.tableFooterView = nil;
}

-(void)setHiden:(BOOL)hiden {
    _hiden = hiden;
    footView.hidden = hiden;
}

-(void)setPagenum:(NSInteger)pagenum{
    _pagenum = pagenum;
    if (self.pages == 0){
        footView.labelView.text = @"无数据";
    }else{
        if (self.pagenum < self.pages) {
            footView.labelView.text=@"向上拖动加载更多";
        }
        else {
            footView.labelView.text = @"已加载所有数据";
        }
    }
    
    self.table.tableFooterView = footView;
    
}

-(void)loadNextPage{
    if (self.pages)
    [self beginLoad];
}

-(void)startLoad{
    self.isloading=YES;
    footView.isLoading = YES;
    self.table.tableFooterView = footView;
}

-(void)stopLoad{
    self.isloading=NO;
    footView.isLoading = NO;
    if (self.pages > self.pagenum || self.pages == 0) {
        footView.labelView.text = @"加载失败";
    }
}


@end

