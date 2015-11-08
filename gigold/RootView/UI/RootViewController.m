//
//  RootViewController.m
//  gigold
//
//  Created by wsc on 15/10/23.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "RootViewController.h"
#import <UIKit/UIKit.h>
#import "appliacation_attribute.h"
#import "ContentViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
    
    self.centerViewController =[[ContentViewController alloc]init];
    [self becomeFirstResponder];
    
    MyAccountViewController* myAccountView1= [[MyAccountViewController alloc] init];
    self.leftViewController = myAccountView1;
    self.leftVisibleWidth = self.view.bounds.size.width -50;
    // Do any additional setup after loading the view.
}
+(RootViewController *)shareInstance{
    static RootViewController* rootViewController = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        rootViewController = [[RootViewController alloc]init];
    });
    return rootViewController;
}

//切换首页中间和右侧筛选页面，左侧关注页面永远不变
-(void)CreatShowViewWithType:(NSInteger)type andUserId:(NSString*)userId andMenuType:(NSInteger)menu_type andIsChangRoot:(NSString*)ischange andFilter:(NSString *)filterString{
//    if (homeView){
//        if (self.centerViewController == homeView && selectedCount == type && type == INDEX_HOME && [userId isEqual:homeView.userId] && homeView.m_enum_type == menu_type && menu_type == RootViewType) {
//            [homeView pullRefreshData];
//            return;
//        }
//    }
//    
//    if (taskView){
//        if (self.centerViewController == taskView && selectedCount == type && type == INDEX_TASK && [userId isEqual:taskView.userId] && taskView.m_enum_type == menu_type  && menu_type == RootViewType) {
//            [taskView pullRefreshData];
//            return;
//        }
//    }
//    
//    if (dailyReportView) {
//        if (self.centerViewController == dailyReportView && selectedCount == type && type == INDEX_DAILY && [userId isEqual:dailyReportView.userId] && dailyReportView.m_enum_type == menu_type  && menu_type == RootViewType) {
//            [dailyReportView pullRefreshData];
//            return;
//        }
//    }
//    
//    if (client){
//        if (self.centerViewController == client && selectedCount == type && type == INDEX_CUSTOMER && [userId isEqual:client.userId] && client.m_enum_type == menu_type  && menu_type == RootViewType) {
//            [client pullRefreshData];
//            return;
//        }
//    }
//    
//    if (documentView){
//        if (self.centerViewController == documentView && selectedCount == type && type == INDEX_DOCUMENT && [userId isEqual:documentView.userId] && documentView.m_enum_type == menu_type  && menu_type == RootViewType) {
//            [documentView pullRefreshData];
//            return;
//        }
//    }
//    
//    if (workflowView){
//        if (self.centerViewController == workflowView && selectedCount == type && type == INDEX_FLOW && [userId isEqual:workflowView.userId] && workflowView.m_enum_type == menu_type  && menu_type == RootViewType) {
//            [workflowView pullRefreshData];
//            return;
//        }
//    }
//    
//    if (goalListView){
//        if (self.centerViewController == goalListView && selectedCount == type && type == INDEX_GOAL && [userId isEqual:goalListView.userId] && goalListView.m_enum_type == menu_type  && menu_type == RootViewType) {
//            [goalListView pullRefreshData];
//            return;
//        }
//    }
//    
//    if (attendanceView){
//        if (self.centerViewController == attendanceView && selectedCount == type && type == INDEX_ATTANDANCE && [userId isEqual:attendanceView.userId] && attendanceView.m_enum_type == menu_type  && menu_type == RootViewType) {
//            [attendanceView pullRefreshData];
//            return;
//        }
//    }
//    
//    if (wechatView){
//        if (self.centerViewController == wechatView && selectedCount == type && type == INDEX_WECHAT && [userId isEqual:wechatView.userId] && wechatView.m_enum_type == menu_type  && menu_type == RootViewType) {
//            [wechatView pullRefreshData];
//            return;
//        }
//    }
//    
//    if (agendaView){
//        if (self.centerViewController == agendaView && selectedCount == type && type == INDEX_AGENDA && [userId isEqual:agendaView.userId] && agendaView.m_enum_type == menu_type  && menu_type == RootViewType) {
//            [agendaView pullRefreshData];
//            return;
//        }
//    }
//    
//    if (workReportView){
//        if (self.centerViewController == workReportView && selectedCount == type && type == INDEX_REPORT && [userId isEqual:workReportView.userId] && workReportView.m_enum_type == menu_type  && menu_type == RootViewType) {
//            [workReportView pullRefreshData];
//            return;
//        }
//    }
//    
//    if (reportFormsView){
//        if (self.centerViewController == reportFormsView && selectedCount == type && type == INDEX_REPORT_FORMS && [userId isEqual:reportFormsView.userId] && reportFormsView.m_enum_type == menu_type  && menu_type == RootViewType) {
//            [reportFormsView pullRefreshData];
//            return;
//        }
//    }
//    
//    if (menu_type == RootViewType && !tabBar){
//        [self createTabBar];
//    }
//    
//    self.canShowRight = YES;
//    BOOL needRefreshData = NO;
//    if (type == INDEX_HOME){
//        //        if (!homeView) {
//        //            homeView = [[HomeViewController alloc] init];
//        //        } else if (![homeView.userId isEqual:userId]) {
//        //            needRefreshData = YES;
//        //        } else {
//        //            if ([NSDate date].timeIntervalSince1970 - [homeView refreshDate].timeIntervalSince1970 > REFRESH_LIST_INTERVAL2) {
//        //                needRefreshData = YES;
//        //            }
//        //        }
//        //        homeView.userId = userId;
//        //        homeView.m_enum_type = menu_type;
//        //        self.centerViewController = homeView;
//        //        self.canShowRight = NO;
//        //        if (needRefreshData) {
//        //            [homeView refreshData];
//        //        } else {
//        //            [[NSNotificationCenter defaultCenter] postNotificationName:refreshNumbersNotification object:nil];
//        //        }
//        
//        if (!messageView) {
//            messageView = [[MessageCentreViewController alloc] init];
//        } else if (![messageView.userId isEqual:userId]) {
//            //needRefreshData = YES;
//            [messageView changeLoginUserRefreshData];
//        } else {
//            if ([NSDate date].timeIntervalSince1970 - [messageView refreshDate].timeIntervalSince1970 > REFRESH_LIST_INTERVAL2) {
//                needRefreshData = YES;
//            }
//        }
//        messageView.userId = userId;
//        messageView.m_enum_type = menu_type;
//        self.centerViewController = messageView;
//        self.canShowRight = NO;
//        if (needRefreshData) {
//            [messageView refreshData];
//        } else {
//            [[NSNotificationCenter defaultCenter] postNotificationName:refreshNumbersNotification object:nil];
//        }
//        
//    }
//    else if (type == INDEX_TASK){
//        if (!taskView) {
//            taskView = [[TaskListViewController alloc] init];
//            taskView.viewType = taskListViewType;
//            if ([filterString isEqualToString:@"我今天的任务"]) {
//                taskView.defaultGroup = @"今天";
//                taskView.selectMenu = @"我的任务";
//            }
//            if ([filterString isEqualToString:@"下属今天的任务(负责/参与)"]) {
//                taskView.defaultGroup = @"今天";
//                taskView.selectMenu = @"下属的任务(负责/参与)";
//            }
//        } else if (![taskView.userId isEqual:userId]) {
//            needRefreshData = YES;
//        } else {
//            if ([filterString isEqualToString:@"我今天的任务"]) {
//                [taskView showTaskByGroup:@"今天" andMenu:@"我的任务"];
//                [taskFilterView clearPress];
//            } else if ([filterString isEqualToString:@"下属今天的任务(负责/参与)"]) {
//                [taskView showTaskByGroup:@"今天" andMenu:@"下属的任务(负责/参与)"];
//            } else if ([NSDate date].timeIntervalSince1970 - [taskView refreshDate].timeIntervalSince1970 > REFRESH_LIST_INTERVAL2) {
//                needRefreshData = YES;
//            }
//        }
//        [[SearchClasses shareSearchClasses] setPageSize:MAX_PAGESIZE];
//        taskView.userId = userId;
//        taskView.m_enum_type = menu_type;
//        self.centerViewController = taskView;
//        if (!taskFilterView) {
//            taskFilterView = [[TaskFilterViewController alloc] init];
//            taskFilterView.view.frame = self.view.bounds;
//        }
//        self.rightViewController = taskFilterView;
//        self.rightVisibleWidth = self.view.bounds.size.width-50;
//        if (needRefreshData) {
//            [taskView refreshData];
//        }
//    }
//    else if (type == INDEX_DAILY){
//        if (!dailyReportView) {
//            dailyReportView = [[DailyReportViewController alloc] init];
//            dailyReportView.viewType = DailyReportListViewType;
//            if ([filterString isEqualToString:@"未读的日报"]){
//                dailyReportView.selectType = blogSelectUnRead;
//            }
//            else if ([filterString isEqualToString:@"评论我的"]){
//                dailyReportView.selectType = blogSelectQueryCommentMe;
//                dailyReportView.isUnread = YES;
//            }else if ([filterString isEqualToString:@"回复我的"]){
//                dailyReportView.selectType = BlogSelectQueryReplayMe;
//                dailyReportView.isUnread = YES;
//            }
//        } else if (![dailyReportView.userId isEqual:userId]) {
//            needRefreshData = YES;
//        }else{
//            if (filterString.length > 0){
//                [dailyReportView Popsection:nil prama:filterString];
//            } else if ([NSDate date].timeIntervalSince1970 - [dailyReportView refreshDate].timeIntervalSince1970 > REFRESH_LIST_INTERVAL2) {
//                needRefreshData = YES;
//            }
//        }
//        
//        dailyReportView.userId = userId;
//        dailyReportView.m_enum_type = menu_type;
//        self.centerViewController = dailyReportView;
//        if (!dailyReportFilterView) {
//            dailyReportFilterView = [[DailyReportFilterViewController alloc] init];
//        }
//        self.rightViewController = dailyReportFilterView;
//        self.rightVisibleWidth = self.view.bounds.size.width -50;
//        if (needRefreshData) {
//            [dailyReportView refreshData];
//        }
//    }
//    else if (type == INDEX_DOCUMENT){
//        if (!documentView) {
//            documentView = [[DocumentsViewController alloc] init];
//            documentView.viewType = DocumentListViewType;
//            documentView.selectMenu = filterString;
//        } else if (![documentView.userId isEqual:userId]) {
//            needRefreshData = YES;
//        } else {
//            if (filterString.length > 0) {
//                [documentView Popsection:nil prama:filterString];
//            } else if ([NSDate date].timeIntervalSince1970 - [documentView refreshDate].timeIntervalSince1970 > REFRESH_LIST_INTERVAL2) {
//                needRefreshData = YES;
//            }
//        }
//        documentView.userId = userId;
//        documentView.m_enum_type = menu_type;
//        self.centerViewController = documentView;
//        if (!documentFilterView) {
//            documentFilterView = [[DocumentFilterViewController alloc] init];
//        }
//        self.rightViewController = documentFilterView;
//        self.rightVisibleWidth = self.view.bounds.size.width -50;
//        if (needRefreshData) {
//            [documentView refreshData];
//        }
//    }
//    else if (type == INDEX_CUSTOMER){
//        if (!client) {
//            client = [[ClientViewController alloc] init];
//            client.selectMenu = filterString;
//        } else if (![client.userId isEqual:userId]) {
//            needRefreshData = YES;
//        } else {
//            if (filterString.length > 0) {
//                [client Popsection:nil prama:filterString];
//            } else if ([NSDate date].timeIntervalSince1970 - [client refreshDate].timeIntervalSince1970 > REFRESH_LIST_INTERVAL2) {
//                needRefreshData = YES;
//            }
//        }
//        client.userId = userId;
//        client.m_enum_type = menu_type;
//        self.centerViewController = client;
//        if (!clientFilterView) {
//            clientFilterView =[[ClientFilterViewController alloc] init];
//        }
//        self.rightViewController = clientFilterView;
//        self.rightVisibleWidth = self.view.bounds.size.width-50;
//        if (needRefreshData) {
//            [client refreshData];
//        }
//    }
//    else if (type == INDEX_FLOW){
//        if (!workflowView) {
//            workflowView = [[WorkFlowViewController alloc] init];
//            workflowView.selectMenu = filterString;
//        } else if (![workflowView.userId isEqual:userId]) {
//            needRefreshData = YES;
//        } else {
//            if (filterString.length > 0) {
//                [workflowView Popsection:nil prama:filterString];
//            } else if ([NSDate date].timeIntervalSince1970 - [workflowView refreshDate].timeIntervalSince1970 > REFRESH_LIST_INTERVAL2) {
//                needRefreshData = YES;
//            }
//        }
//        workflowView.userId = userId;
//        workflowView.m_enum_type = menu_type;
//        self.centerViewController = workflowView;
//        if (!workflowFilterView) {
//            workflowFilterView = [[WorkFlowFilterViewController alloc] init];
//        }
//        self.rightViewController = workflowFilterView;
//        self.rightVisibleWidth = self.view.bounds.size.width -50;
//        if (needRefreshData) {
//            [workflowView refreshData];
//        }
//    }
//    else if (type == INDEX_ATTANDANCE){
//        if (!attendanceView) {
//            attendanceView = [[AttendanceViewController alloc] init];
//        } else if (![attendanceView.userId isEqual:userId]) {
//            needRefreshData = YES;
//        } else {
//            if ([NSDate date].timeIntervalSince1970 - [attendanceView refreshDate].timeIntervalSince1970 > REFRESH_LIST_INTERVAL2) {
//                needRefreshData = YES;
//            }
//        }
//        attendanceView.userId = userId;
//        attendanceView.m_enum_type = menu_type;
//        self.centerViewController = attendanceView;
//        if (!attendanceFilterView) {
//            attendanceFilterView = [[AttendanceFilterViewController alloc] init];
//        }
//        self.rightViewController = attendanceFilterView;
//        self.rightVisibleWidth = self.view.bounds.size.width -50;
//        if (needRefreshData) {
//            [attendanceView refreshData];
//        }
//    }
//    else if (type == INDEX_WECHAT){
//        if (!wechatView) {
//            wechatView = [[WXContactsViewController alloc] init];
//        } else if (![wechatView.userId isEqual:userId]) {
//            needRefreshData = YES;
//        } else {
//            if ([NSDate date].timeIntervalSince1970 - [wechatView refreshDate].timeIntervalSince1970 > REFRESH_LIST_INTERVAL2) {
//                needRefreshData = YES;
//            }
//        }
//        wechatView.userId = userId;
//        wechatView.m_enum_type = menu_type;
//        self.centerViewController = wechatView;
//        self.canShowRight = NO;
//        if (needRefreshData) {
//            [wechatView refreshData];
//        }
//    }
//    else if (type == INDEX_GOAL){
//        if (!goalListView) {
//            goalListView = [[GoalListViewController alloc] init];
//            goalListView.selectMenu = filterString;
//        } else if (![goalListView.userId isEqual:userId]) {
//            needRefreshData = YES;
//        } else {
//            if (filterString.length > 0) {
//                [goalListView Popsection:nil prama:filterString];
//            } else if ([NSDate date].timeIntervalSince1970 - [goalListView refreshDate].timeIntervalSince1970 > REFRESH_LIST_INTERVAL2) {
//                needRefreshData = YES;
//            }
//        }
//        goalListView.userId = userId;
//        goalListView.m_enum_type = menu_type;
//        self.centerViewController = goalListView;
//        if (!goalListFilterView) {
//            goalListFilterView = [[GoalListFilerViewController alloc] init];
//        }
//        self.rightViewController = goalListFilterView;
//        self.rightVisibleWidth = self.view.bounds.size.width -50;
//        if (needRefreshData) {
//            [goalListView refreshData];
//        }
//    }
//    else if (type == INDEX_AGENDA){
//        if (!agendaView) {
//            agendaView = [[PWSDefaultViewController alloc] init];
//            agendaView.currentDate = [[AppUtils shareAppUtils] getDateWithString:[[AppUtils shareAppUtils]getDateString:[NSDate date] withFormat:@"yyyy-MM-dd"] withFormat:@"yyyy-MM-dd"];
//        } else if (![agendaView.userId isEqual:userId]) {
//            needRefreshData = YES;
//        }else{
//            if ([filterString isEqualToString:@"我今天的日程"]) {
//                agendaView.userId = userId;
//                agendaView.m_enum_type = menu_type;
//                [agendaView showToday];
//            } else if ([NSDate date].timeIntervalSince1970 - [agendaView refreshDate].timeIntervalSince1970 > REFRESH_LIST_INTERVAL2) {
//                needRefreshData = YES;
//            }
//        }
//        
//        agendaView.userId = userId;
//        agendaView.m_enum_type = menu_type;
//        agendaView.view.frame = self.view.bounds;
//        self.centerViewController = agendaView;
//        if (menu_type != RootViewType) {
//            self.canShowRight = NO;
//        }
//        if (!agendaFilterView) {
//            agendaFilterView = [[AgendaFilterViewController alloc] init];
//        }else{
//            if (needRefreshData) {
//                [agendaFilterView clearPress];
//            }
//        }
//        
//        self.rightViewController = agendaFilterView;
//        self.rightVisibleWidth = self.view.bounds.size.width -50;
//        if (needRefreshData) {
//            [agendaView refreshData];
//        }
//    }
//    else if (type == INDEX_REPORT){
//        if (!workReportView) {
//            workReportView = [[WorkReportViewController alloc] init];
//        } else if (![workReportView.userId isEqual:userId]) {
//            needRefreshData = YES;
//        } else {
//            if ([NSDate date].timeIntervalSince1970 - [workReportView refreshDate].timeIntervalSince1970 > REFRESH_LIST_INTERVAL2) {
//                needRefreshData = YES;
//            }
//        }
//        workReportView.userId = userId;
//        workReportView.m_enum_type = menu_type;
//        self.centerViewController = workReportView;
//        if (needRefreshData) {
//            [workReportView refreshData];
//        }
//        if (!workReportFilterVC) {
//            workReportFilterVC = [[WorkReportFilterViewController alloc] init];
//        }
//        self.rightViewController = workReportFilterVC;
//        self.rightVisibleWidth = self.view.bounds.size.width -50;
//    }
//    else if (type == INDEX_REPORT_FORMS){
//        if (!reportFormsView) {
//            reportFormsView = [[ReportFormsViewController alloc] init];
//        } else if (![reportFormsView.userId isEqual:userId]) {
//            needRefreshData = YES;
//        }
//        reportFormsView.userId = userId;
//        reportFormsView.selectDate = [NSDate date];
//        reportFormsView.selectUserId = userId;
//        reportFormsView.m_enum_type = menu_type;
//        self.centerViewController = reportFormsView;
//        if (needRefreshData) {
//            [reportFormsView refreshData];
//        }
//        if (!reportFormsFilterView) {
//            reportFormsFilterView = [[ReportFormsFilterViewController alloc] init];
//        }
//        reportFormsFilterView.userId = userId;
//        reportFormsFilterView.selectUserId = userId;
//        self.rightViewController = reportFormsFilterView;
//        self.rightVisibleWidth = self.view.bounds.size.width -50;
//    }
//    
//    if ([ischange boolValue]){
//        selectedCount = type;
//    }
//    
//    if (self.centerViewController) {
//        
//        [tabBar removeFromSuperview];
//        if (menu_type == RootViewType && tabBar) {
//            [self.centerViewController.view addSubview:tabBar];
//        }
//        [self createNewButton];
//        [self startTimer];
//    }
//    if (self.leftViewController == nil) {
//        attentionViewController* attentionView = [[attentionViewController alloc] init];
//        attentionView.viewType = attentionViewType;
//        self.swipeDelegate =attentionView;
//        self.leftViewController = attentionView;
//        self.leftVisibleWidth = self.view.bounds.size.width;
//        Etrelease(attentionView);
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
