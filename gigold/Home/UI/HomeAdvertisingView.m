//
//  HomeAdvertisingView.m
//  gigold
//
//  Created by 单小萍 on 15/11/6.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "HomeAdvertisingView.h"
@interface HomeAdvertisingView()<UIScrollViewDelegate>{
    NSMutableArray* imageDatas;
    NSInteger currenPage;
    NSTimer* timer;
}
@end
@implementation HomeAdvertisingView
@synthesize imgArray=_imgArray;
@synthesize slidingTime=_slidingTime;
@synthesize loopTime=_loopTime;
@synthesize imageScrollView=_imageScrollView;
@synthesize pageController=_pageController;
-(void)setImgArray:(NSArray *)imgArray{
    currenPage = 0;
    self.slidingTime = 2.f;
    self.loopTime = 3.f;
    _imageScrollView.contentSize=CGSizeMake((imgArray.count+1)*_imageScrollView.frame.size.width,_imageScrollView.frame.size.height);
    _imageScrollView.pagingEnabled = YES;
    _pageController.numberOfPages = imgArray.count;
    for (int i = 0;i < [imgArray count];i++){
        UIImageView* imageView = [[UIImageView alloc]initWithImage:imgArray[i]];
        imageView.frame = CGRectMake(i*_imageScrollView.frame.size.width,0.f,_imageScrollView.frame.size.width,_imageScrollView.frame.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_imageScrollView addSubview:imageView];
        //添加进imageview缓存
        if (!imageDatas) {
            imageDatas = [[NSMutableArray alloc]init];
        }
        [imageDatas addObject:imageView];
    }
   UIImageView* lastImageView =[[UIImageView alloc]initWithImage:imgArray[0]];
   lastImageView.frame = CGRectMake(imgArray.count*_imageScrollView.frame.size.width,0.f,_imageScrollView.frame.size.width,_imageScrollView.frame.size.height);
   [_imageScrollView addSubview:lastImageView];
   [imageDatas addObject:lastImageView];
}
-(void)updataFrame:(CGRect)frame{
    self.frame = frame;
    if (!_imageScrollView) {
        self.imageScrollView = [[UIScrollView alloc]init];
        _imageScrollView.frame = CGRectMake(0.f,0.f,self.frame.size.width,self.frame.size.height);
        _imageScrollView.contentInset = UIEdgeInsetsZero;
        _imageScrollView.contentOffset = CGPointMake(0.f,0.f);
        _imageScrollView.showsHorizontalScrollIndicator = NO;
        _imageScrollView.showsVerticalScrollIndicator = NO;
        _imageScrollView.delegate = self;
        [self addSubview:_imageScrollView];
    }else{
        _imageScrollView.frame = self.bounds;
    }
    
    if (!_pageController) {
        self.pageController = [[UIPageControl alloc]initWithFrame:CGRectMake(0.f, self.frame.size.height-25.f,self.frame.size.width,30.f)];
        _pageController.currentPage = 0;
        [self addSubview:_pageController];
    }else{
        _pageController.frame = CGRectMake(0.f, self.frame.size.height-25.f,self.frame.size.width,30.f);
    }
    if(imageDatas) {
        CGRect currentImageViewFrame = [self getCurrentImageView].frame;
        currentImageViewFrame.size.height = frame.size.height;
        [self getCurrentImageView].frame = currentImageViewFrame;
    }
}

//循环内容
-(void)loopContent{
    if (!timer){
        timer = [NSTimer scheduledTimerWithTimeInterval:_loopTime target:self selector:@selector(changePage) userInfo:nil repeats:YES];
    }
}
//改变页码
-(void)changePage{
    currenPage++;
    [self setPage:currenPage animation:YES];
}


//设置当前页码
-(void)setPage:(NSInteger)page animation:(BOOL)isAnimation{
    _pageController.currentPage  =  page > imageDatas.count - 2 ?0:page;
    CGPoint point = _imageScrollView.contentOffset;
    point.x = page*_imageScrollView.frame.size.width;
    [_imageScrollView setContentOffset:point animated:isAnimation];
}



/*
 * 获得当前页码
 */
-(NSInteger)getCurrentPage:(UIScrollView*)scrollView{
    NSInteger estimatedPage =  scrollView.contentOffset.x/scrollView.frame.size.width;
    NSInteger addPage =(scrollView.contentOffset.x-estimatedPage*scrollView.frame.size.width)/(scrollView.frame.size.width/2);
    NSInteger page = estimatedPage + addPage;
    return page;
}

//获得当前的imageView视图
-(UIImageView*)getCurrentImageView{
   return imageDatas[currenPage];
}

#pragma mark -scrollView deleget
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    currenPage = [self getCurrentPage:scrollView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (currenPage > imageDatas.count-2) {
        currenPage = 0;
    }
    [self setPage:currenPage animation:NO];
    [self loopContent];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [timer invalidate];
    timer = nil;
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (currenPage > imageDatas.count-2) {
        currenPage = 0;
        [self setPage:currenPage animation:NO];
    }
}
@end
