//
//  PageTableviewdragloading.h
//  eteams
//
//  Created by caidengshan on 1/16/14.
//  Copyright (c) 2014 王 苏诚. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PageTableViewdragdelegate <NSObject>

-(void)startPaging:(NSInteger)currentPage withSize:(NSInteger)pageSize;

@end



@interface PageTableViewFootView : UIView{
    UIActivityIndicatorView *indicatorView;
    //UILabel *labelView;
}
@property(nonatomic,retain)UILabel *labelView;
@property (nonatomic,assign)BOOL isLoading;
@end
//上拉刷新
@interface PageTableviewdragloading : NSObject{
    
     PageTableViewFootView *footView;//表格的底部栏
     BOOL isableloading;              //是否还要需要继续加载;
    
}

@property(nonatomic,assign)id <PageTableViewdragdelegate> delegate; //delegate
@property(nonatomic,retain)UITableView *table; //放置的tableView
@property(nonatomic,assign)NSInteger pagenum;  //当前页码
@property(nonatomic,assign)NSInteger pages;    //总页码数
@property(nonatomic,assign)BOOL      isloading;  //记录加载状态
@property(nonatomic,assign)BOOL      hiden;      //隐藏属性

-(id)initWithTableView:(UITableView *)table; //初始化方法

-(void)removeTableView; //移除方法

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

-(void)reset;  //重新加载

-(void)loadNextPage;

-(void)setPagenum:(NSInteger)pagenum; //设置当前页码

-(void)startLoad; //开始加载
-(void)stopLoad;  //停止加载

@end
