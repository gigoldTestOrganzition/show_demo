//
//  SelectRegionView.m
//  gigold
//
//  Created by 单小萍 on 15/10/29.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "SelectRegionView.h"
#import "SelectRegionView.h"
@interface SelectRegionView()<UIPickerViewDelegate,UIPickerViewDataSource>{
    NSMutableArray* regionDatas;
    
}
@end
@implementation SelectRegionView
@synthesize cancle=_cancle;
@synthesize sure=_sure;
@synthesize  regionPickerView=_regionPickerView;

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initRegionDatas];
        [self initUI];
        [self initEvent];
        
    }
    return self;
}
//初始化ui
-(void)initUI{
    SelectRegionView* selectRegionView = (SelectRegionView*) [[[NSBundle mainBundle] loadNibNamed:@"SelectRegionView" owner:self options:nil] firstObject];
    selectRegionView.frame = CGRectMake(0,0, mainScreenWidth, selectRegionView.frame.size.height);
    self.cancle = selectRegionView.cancle;
    self.sure = selectRegionView.sure;
    self.regionPickerView = selectRegionView.regionPickerView;
    _regionPickerView.delegate = self;
    _regionPickerView.dataSource = self;
    _regionPickerView.showsSelectionIndicator = YES;
    [_regionPickerView selectRow:[regionDatas count]/6 inComponent:0 animated:NO];
    [_regionPickerView selectRow:[regionDatas count]/6 inComponent:1 animated:NO];
    [_regionPickerView selectRow:[regionDatas count]/6 inComponent:2 animated:NO];
    self.showView = selectRegionView;
}
//初始化事件
-(void)initEvent{
    UITapGestureRecognizer* cancleGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancleOperation)];
    _cancle.userInteractionEnabled = YES;
    [_cancle addGestureRecognizer:cancleGestureRecognizer];
    
    UITapGestureRecognizer* sureGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sureRegion)];
    _sure.userInteractionEnabled = YES;
    [_sure addGestureRecognizer:sureGestureRecognizer];
    
}
//初始化地区数据
-(void)initRegionDatas{
   if (!regionDatas){
        regionDatas = [[NSMutableArray alloc]initWithObjects:
                       @"湖南",@"长沙",@"芙蓉区",
                       @"湖北",@"武汉",@"江汉",
                       @"湖北",@"武汉",@"江汉",
                       @"湖北",@"武汉",@"江汉",
                       @"湖北",@"武汉",@"江汉",
                       @"湖北",@"武汉",@"江汉",
                       @"湖北",@"武汉",@"江汉",nil];
       
   }
}
//取消
-(void)cancleOperation{
    [self stopDialog];
    if([super clickDeleget]){
        [[super clickDeleget] click:@"cancle"];
    }
}
//确认选择地区
-(void)sureRegion{
    [self stopDialog];
}

#pragma mark -UIPickerViewDelegate

//返回列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
    
}
//返回行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [regionDatas count]/3;
}
//-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    NSInteger index = row*3+component;
//    return regionDatas[index];
//}
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* showLable =  (view?(UILabel*)view:[[UILabel alloc]initWithFrame:CGRectMake(0.f,0.f,60.f,30.f)]);
     NSInteger index = row*3+component;
    showLable.textColor = main_text_color;
    showLable.font = main_font;
    showLable.text = regionDatas[index];
    return showLable;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSInteger index = row*3+component;
    if([super clickDeleget]) {
        NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:regionDatas[index],[NSString stringWithFormat:@"%li",component+1], nil];
        [[super clickDeleget]clickParam:params];
    }
}
@end
