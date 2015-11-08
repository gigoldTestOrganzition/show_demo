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
@synthesize loopTime=_loopTime;
@synthesize imageScrollView=_imageScrollView;
@synthesize pageController=_pageController;


-(void)setImgArray:(NSArray *)imgArray{
    currenPage = 0;
    self.loopTime = 3.f;
    _imageScrollView.contentSize=CGSizeMake(imgArray.count*_imageScrollView.frame.size.width,_imageScrollView.frame.size.height);
    _pageController.numberOfPages =imgArray.count;
    for (int i = 0;i < [imgArray count];i++){
        UIImageView* imageView = [[UIImageView alloc]initWithImage:imgArray[i]];
        imageView.frame = CGRectMake(i*_imageScrollView.frame.size.width,0.f,_imageScrollView.frame.size.width,_imageScrollView.frame.size.height);
        
        [imageView sizeThatFits:CGSizeMake(imageView.frame.size.width, imageView.frame.size.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [_imageScrollView addSubview:imageView];
        //添加进imageview缓存
        if (!imageDatas) {
            imageDatas = [[NSMutableArray alloc]init];
        }
        [imageDatas addObject:imageView];
    }
}
-(void)updataFrame:(CGRect)frame{
    self.frame = frame;
    if (!_imageScrollView) {
        self.imageScrollView = [[UIScrollView alloc]init];
        _imageScrollView.frame = self.bounds;
        _imageScrollView.delegate = self;
        _imageScrollView.showsHorizontalScrollIndicator = NO;
        _imageScrollView.showsVerticalScrollIndicator = NO;
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
    timer = [NSTimer scheduledTimerWithTimeInterval:_loopTime target:self selector:@selector(changePage) userInfo:nil repeats:YES];
}

//改变页码
-(void)changePage{
    currenPage++;
    if (currenPage > imageDatas.count-1) {
        currenPage = 0;
    }
    CGPoint point = _imageScrollView.contentOffset;
    point.x = currenPage*_imageScrollView.frame.size.width;
    _imageScrollView.contentOffset = point;
}

//获得当前的imageView视图
-(UIImageView*)getCurrentImageView{
    NSInteger estimatedPage =  _imageScrollView.contentOffset.x/_imageScrollView.frame.size.width;
    NSInteger addPage =(_imageScrollView.contentOffset.x-estimatedPage*_imageScrollView.frame.size.width)/(_imageScrollView.frame.size.width/2);
    NSInteger page = estimatedPage+addPage;
    return imageDatas[page];
}
#pragma mark -scrollView deleget
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger estimatedPage =  scrollView.contentOffset.x/scrollView.frame.size.width;
    NSInteger addPage =(scrollView.contentOffset.x-estimatedPage*scrollView.frame.size.width)/(scrollView.frame.size.width/2);
    NSInteger page = estimatedPage + addPage;
    currenPage = page;
    _pageController.currentPage  = page;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    point.x = currenPage*scrollView.frame.size.width;
    scrollView.contentOffset = point;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [timer invalidate];
    timer = nil;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGPoint point = scrollView.contentOffset;
    point.x = currenPage*scrollView.frame.size.width;
    scrollView.contentOffset = point;
    [self loopContent];
}
@end
