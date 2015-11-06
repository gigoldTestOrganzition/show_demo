//
//  PulRefresh.h
//  refresh
//
//  Created by caidengshan on 9/12/13.
//  Copyright (c) 2013 caidengshan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pull.h"

//typedef enum{
//	PullRefreshPulling = 0,
//	PullRefreshNormal,
//	PullRefreshLoading,
//} PullRefreshState;


@class PulRefresh;

@protocol PulRefreshdelegate <NSObject>

- (void)RefreshTableHeaderDidTriggerRefresh:(PulRefresh*)view;

- (BOOL)RefreshTableHeaderDataSourceIsLoading:(PulRefresh*)view;

@optional
- (NSDate*)RefreshTableHeaderDataSourceLastUpdated:(PulRefresh*)view;
- (NSString*)Refreshtextnomal;
- (NSString*)Refreshtextpull;
- (NSString*)Refreshtextloding;
@end







@interface PulRefresh : UIView{
    UILabel  *datelabel;
    UILabel  *datetext;
    UIActivityIndicatorView *activity;
    CALayer             *arrow;
    
    PullRefreshState state;
    
}
@property(nonatomic,assign)id<PulRefreshdelegate> delegate;
@property(nonatomic,retain) NSDate *refreshDate;
@property(nonatomic,assign) CGFloat scrollDuration;


- (void)refreshLastUpdatedDate;
- (void)RefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)RefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)RefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

- (void)resetlabelcolor;

@end
