//
//  GiglodsDeclarationView.h
//  gigold
//
//  Created by 单小萍 on 15/10/30.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiglodsDeclarationView : UIView
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *lookImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineLeadingLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayoutConstraint;

@end
