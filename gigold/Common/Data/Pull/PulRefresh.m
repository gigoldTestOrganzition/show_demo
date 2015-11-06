//
//  PulRefresh.m
//  refresh
//
//  Created by caidengshan on 9/12/13.
//  Copyright (c) 2013 caidengshan. All rights reserved.
//

#import "PulRefresh.h"
#import <QuartzCore/QuartzCore.h>

//#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
//#define FLIP_ANIMATION_DURATION 0.18f

@implementation PulRefresh
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollDuration = 0.4;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = [UIColor clearColor];
        datelabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
        datelabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		datelabel.font = [UIFont systemFontOfSize:12];
		datelabel.textColor =  UIColorFromRGB(0x808080);;
//		datelabel = [UIColor colorWithWhite:0.9f alpha:1.0f];
//		datelabel = CGSizeMake(0.0f, 1.0f);
		datelabel.backgroundColor = [UIColor clearColor];
		datelabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:datelabel];

        datetext = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
		datetext.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		datetext.font = [UIFont systemFontOfSize:14];
		datetext.textColor = UIColorFromRGB(0x999999);
//		datetext.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
//		datetext.shadowOffset = CGSizeMake(0.0f, 1.0f);
		datetext.backgroundColor = [UIColor clearColor];
		datetext.textAlignment = NSTextAlignmentCenter;
        [self addSubview:datetext];
        
        arrow = [CALayer layer];
		arrow.frame = CGRectMake(25.0f, frame.size.height - 65.0f, 30.0f, 55.0f);
		arrow.contentsGravity = kCAGravityResizeAspect;
		arrow.contents = (id)[UIImage imageNamed:@"loding.png"].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			arrow.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		[[self layer] addSublayer:arrow];
        
        
        activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		activity.frame = CGRectMake(25.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
		[self addSubview:activity];
		
		[self setState:PullRefreshNormal];
        
    }
    
    return self;
}


- (void)setState:(PullRefreshState)aState{
    switch (aState) {
        case PullRefreshNormal:{
            datelabel.text = NSLocalizedString(@"继续下拉可刷新", @"Pull down to refresh status");
			[activity stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			arrow.hidden = NO;
			arrow.transform = CATransform3DIdentity;
			[CATransaction commit];
            [self refreshLastUpdatedDate];
        }
            break;
        case PullRefreshPulling:{
            datelabel.text = NSLocalizedString(@"松开可刷新", @"Release to refresh status");
			[CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
			arrow.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
        }
            break;
        case PullRefreshLoading:{
            datelabel.text = NSLocalizedString(@"正在努力加载中......", @"Loading Status");
			[activity startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			arrow.hidden = YES;
			[CATransaction commit];
        }
            break;
            
        default:
            break;
    }
    state = aState;
}


- (void)refreshLastUpdatedDate {
	
	if ([_delegate respondsToSelector:@selector(RefreshTableHeaderDataSourceLastUpdated:)]) {
		
		self.refreshDate = [_delegate RefreshTableHeaderDataSourceLastUpdated:self];
		
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setAMSymbol:@"AM"];
		[formatter setPMSymbol:@"PM"];
		[formatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
		datetext.text = [NSString stringWithFormat:@"最后更新: %@", [formatter stringFromDate:self.refreshDate]];
		[[NSUserDefaults standardUserDefaults] setObject:datetext.text forKey:@"EGORefreshTableView_LastRefresh"];
        [[NSUserDefaults standardUserDefaults] synchronize];
		
	} else {
		
		datetext.text = nil;
		
	}
    
}


- (void)RefreshScrollViewDidScroll:(UIScrollView *)scrollView{
    if (state == PullRefreshLoading) {
		
		CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
		offset = MIN(offset, 60);
		scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
		
	} else if (scrollView.isDragging) {
            
            //NSLog(@"%f",scrollView.contentOffset.y);
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(RefreshTableHeaderDataSourceIsLoading:)]) {
			_loading = [_delegate RefreshTableHeaderDataSourceIsLoading:self];
		}

            if (state == PullRefreshNormal && scrollView.contentOffset.y<-65.0f && scrollView.contentOffset.y < 0.0f && !_loading) {
                //NSLog(@"%f",scrollView.contentOffset.y);
                [self setState:PullRefreshPulling];
            }else if (state == PullRefreshPulling && scrollView.contentOffset.y >-65.0f && scrollView.contentOffset.y < 0.0f && !_loading ){
                //NSLog(@"%f",scrollView.contentOffset.y);
                [self setState:PullRefreshNormal];
            }
        
        }
        //是否保留数据到动画效果
//		if (scrollView.contentInset.top != 0) {
//			scrollView.contentInset = UIEdgeInsetsZero;
//		}
}

-(void)RefreshScrollViewDidEndDragging:(UIScrollView *)scrollView{
    BOOL _loading = NO;
	if ([_delegate respondsToSelector:@selector(RefreshTableHeaderDataSourceIsLoading:)]) {
		_loading = [_delegate RefreshTableHeaderDataSourceIsLoading:self];
	}
	if (scrollView.contentOffset.y <= - 65.0f && !_loading) {
		[self setState:PullRefreshLoading];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:self.scrollDuration];
		scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
		if ([_delegate respondsToSelector:@selector(RefreshTableHeaderDidTriggerRefresh:)]) {
			[_delegate RefreshTableHeaderDidTriggerRefresh:self];
		}
//		[self setState:PullRefreshLoading];
//		[UIView beginAnimations:nil context:NULL];
//		[UIView setAnimationDuration:0.2];
//		scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
//		[UIView commitAnimations];
		
	}
}

- (void)RefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView{
    if (state != PullRefreshNormal) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:self.scrollDuration];
        [scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
        [UIView commitAnimations];
        [self setState:PullRefreshNormal];
    }
}


-(void)resetlabelcolor{
    datelabel.backgroundColor = [UIColor clearColor];
    datetext.backgroundColor =[UIColor clearColor];
    datelabel.textColor =UIColorFromRGB(0xFFFFFF);
    datetext.textColor =UIColorFromRGB(0xFFFFFF);
    activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
}

@end




































