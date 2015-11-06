//
//  PulRefresh.h
//  refresh
//
//  Created by caidengshan on 9/12/13.
//  Copyright (c) 2013 caidengshan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pull.h"


@class pullup;

@protocol pullupdelegate <NSObject>

- (void)pullupRefreshTableHeaderDidTriggerRefresh:(pullup*)view;

- (BOOL)pullupRefreshTableHeaderDataSourceIsLoading:(pullup*)view;


@optional
- (NSDate*)pullupRefreshTableHeaderDataSourceLastUpdated:(pullup*)view;


@end





@interface pullup : UIView{
    UILabel  *datelabel;
    UILabel  *datetext;
    UIActivityIndicatorView *activity;
    CALayer             *arrow;
    
    PullRefreshState state;
    
}
@property(nonatomic,assign)id<pullupdelegate> delegate;


- (void)pulluprefreshLastUpdatedDate;

- (void)pullupRefreshScrollViewDidScroll:(UIScrollView *)scrollView;

- (void)pullupRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;

- (void)pullupRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

- (void)resetlabelcolor;

@end





