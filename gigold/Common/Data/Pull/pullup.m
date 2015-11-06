//
//  PulRefresh.m
//  refresh
//
//  Created by caidengshan on 9/12/13.
//  Copyright (c) 2013 caidengshan. All rights reserved.
//

#import "pull.h"
#import "pullup.h"
#import <QuartzCore/QuartzCore.h>



@implementation pullup


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = UIColorFromRGB(0xFFFFFF);;
        datelabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0, self.frame.size.width, 20.0f)];
        datelabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		datelabel.font = [UIFont systemFontOfSize:12];
		datelabel.textColor = UIColorFromRGB(0x808080);;
		datelabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		datelabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		datelabel.backgroundColor = [UIColor clearColor];
		datelabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:datelabel];
        
        datetext = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,20.0f, self.frame.size.width, 20.0f)];
		datetext.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		datetext.font = [UIFont systemFontOfSize:14];
		datetext.textColor = UIColorFromRGB(0x808080);;
		datetext.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		datetext.shadowOffset = CGSizeMake(0.0f, 1.0f);
		datetext.backgroundColor = [UIColor clearColor];
		datetext.textAlignment = NSTextAlignmentCenter;
		[self addSubview:datetext];
        
        
        arrow = [CALayer layer];
		arrow.frame = CGRectMake(25.0f,5, 30.0f, 55.f);
		arrow.contentsGravity = kCAGravityResizeAspect;
		arrow.contents = (id)[UIImage imageNamed:@"loding.png"].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			arrow.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		[[self layer] addSublayer:arrow];
        
        activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		activity.frame = CGRectMake(25.0f,20.0f, 20.0f, 20.0f);
		[self addSubview:activity];
		
		
		[self setState:PullRefreshNormal];
        
    }
    
    return self;
}



- (void)setState:(PullRefreshState)aState{
    switch (aState) {
        case PullRefreshNormal:{
            datetext.text = NSLocalizedString(@"Pull down to refresh...", @"Pull down to refresh status");
			[activity stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			arrow.hidden = NO;
			arrow.transform = CATransform3DIdentity;
			[CATransaction commit];
            
        }
            break;
        case PullRefreshPulling:{
            datetext.text = NSLocalizedString(@"Release to refresh...", @"Release to refresh status");
			[CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
			arrow.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
        }
            break;
        case PullRefreshLoading:{
            datetext.text = NSLocalizedString(@"Loading...", @"Loading Status");
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


- (void)pullupRefreshScrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = MAX(scrollView.contentSize.height, scrollView.frame.size.height) - scrollView.frame.size.height;
    NSLog(@"=---------------%f",y);
    
    if (state == PullRefreshLoading) {
		
//		CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
//		offset = MIN(offset, 60);
//		scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
		
	} else if (scrollView.isDragging) {
        
        //NSLog(@"%f",scrollView.contentOffset.y);
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(RefreshTableHeaderDataSourceIsLoading:)]) {
			_loading = [_delegate pullupRefreshTableHeaderDataSourceIsLoading:self];
		}
        
        if (state == PullRefreshNormal && scrollView.contentOffset.y>y+65.0f && scrollView.contentOffset.y > 0.0f && !_loading) {
            NSLog(@"%f",scrollView.contentOffset.y);
            [self setState:PullRefreshPulling];
        }else if (state == PullRefreshPulling && scrollView.contentOffset.y >y && scrollView.contentOffset.y < y+65 && !_loading ){
            NSLog(@"%f",scrollView.contentOffset.y);
            [self setState:PullRefreshNormal];
        }
        
    }
    
    //是否保留数据到动画效果
    //		if (scrollView.contentInset.top != 0) {
    //			scrollView.contentInset = UIEdgeInsetsZero;
    //		}
}

-(void)pullupRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView{
    CGFloat y = MAX(scrollView.contentSize.height, scrollView.frame.size.height) - scrollView.frame.size.height;
    
    NSLog(@"%f",y);
    
    BOOL _loading = NO;
	if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
		_loading = [_delegate pullupRefreshTableHeaderDataSourceIsLoading:self];
	}
	if (scrollView.contentOffset.y >=  y+65 && !_loading) {
		
		if ([_delegate respondsToSelector:@selector(RefreshTableHeaderDidTriggerRefresh:)]) {
			[_delegate pullupRefreshTableHeaderDidTriggerRefresh:self];
		}
		[self setState:PullRefreshLoading];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
        
        if (y>0) {
            scrollView.contentInset = UIEdgeInsetsMake(0, 0.0f, 65.0f, 0);
        }else{
            scrollView.contentInset = UIEdgeInsetsMake(0, 0.0f, scrollView.frame.size.height-65, 0);
        }
		//scrollView.contentInset = UIEdgeInsetsMake(0, 0.0f, 65.0f, 0);
		[UIView commitAnimations];
		
	}
}

- (void)pullupRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView{
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	[self setState:PullRefreshNormal];
}

-(void)resetlabelcolor{
    self.backgroundColor = UIColorFromRGB(0x171717);
    datelabel.backgroundColor =UIColorFromRGB(0xFFFFFF);
    datetext.backgroundColor =UIColorFromRGB(0xFFFFFF);
}


@end







































