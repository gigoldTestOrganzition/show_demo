//
//  GiglodsDeclarationView.m
//  gigold
//
//  Created by 单小萍 on 15/10/30.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "GiglodsDeclarationView.h"
@interface GiglodsDeclarationView(){
    
    __weak IBOutlet NSLayoutConstraint *line1;
    
    __weak IBOutlet NSLayoutConstraint *line2;
    
}
@end
@implementation GiglodsDeclarationView
@synthesize bottomLine=_bottomLine;
@synthesize title = _title;
@synthesize lookImg = _lookImg;
@synthesize bottomLineLeadingLayoutConstraint=_bottomLineLeadingLayoutConstraint;
@synthesize topLayoutConstraint=_topLayoutConstraint;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    line1.constant = 0.5f;
    line2.constant = 0.5f;
}
@end
