            //
//  RCHomeViewController.m
//  高仿微博
//
//  Created by Raychen on 15/4/7.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCHomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "RCTitleButton.h"
#import "DXPopover.h"
#import "RCStatusResult.h"
#import "RCStatusParam.h"
#import "RCAccountTool.h"
#import "RCStatusTool.h"
#import "MBProgressHUD+MJ.h"
#import "MJExtension.h"
#import "RCStatus.h"
#import "RCStatusCell.h"
#import "MJRefresh.h"
#import "RCStatusFrame.h"
#import "RCUserInfoResult.h"
#import "RCUserParam.h"
#import "RCUserTool.h"
#import "RCStatusDetailViewController.h"
#import "RCTopPopoverView.h"
@interface RCHomeViewController () <RCTopPopoverViewDelegate>
@property(nonatomic,weak) RCTitleButton * titleButton;
/**
 *  存放微博数据，子控件的frame，cell的高度的数组
 */
@property(strong,nonatomic) NSMutableArray * statusFrames;
@property(strong,nonatomic) NSNumber * lastPage;
@property (nonatomic, assign)NSUInteger newStatusCount;

@end

@implementation RCHomeViewController
#pragma mark - 懒加载
-(NSMutableArray *)statusFrames{
    if (!_statusFrames) {

        self.statusFrames =[NSMutableArray array];

    }
    return _statusFrames;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor                = [UIColor colorWithWhite:0.929 alpha:1.000];
    self.tableView.separatorStyle            = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset              = UIEdgeInsetsMake(10, 0, 0, 0);
    // 设置导航栏
    [self setUpNavigationBar];


    //刷新控件
    [self initRefresh];

    [self loadUserInfo];

    [self.tableView headerBeginRefreshing];

}
/**
 *  设置导航栏
 */
- (void)setUpNavigationBar{

    self.navigationItem.leftBarButtonItem    = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" higthligthImage:@"navigationbar_friendsearch_highlighted" targrt:self action:@selector(addFriend)];

    self.navigationItem.rightBarButtonItem   = [UIBarButtonItem itemWithImage:@"navigationbar_pop" higthligthImage:@"navigationbar_pop_highlighted" targrt:self action:@selector(sao)];
    
    
    RCTitleButton * titleButton              = [[RCTitleButton alloc]init];
    self.titleButton                         = titleButton;
    if ([RCAccountTool account].name) {
        [titleButton setTitle:[RCAccountTool account].name forState:UIControlStateNormal];
    }else{
        [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    }


//    titleButton .backgroundColor = [UIColor redColor];
    [titleButton addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView            = titleButton;

}
- (void)addFriend{

}
#pragma mark 扫一扫
- (void)sao{
    RCTopPopoverView * popoverView                  = [[RCTopPopoverView alloc]initWithFrame:CGRectMake(0, 20, 130, 80) ];
    popoverView.deleagte1 = self;
    popoverView.backgroundColor                = [UIColor colorWithWhite:0.000 alpha:0.320];
    DXPopover *popover                       = [DXPopover popover];
    popover.maskType                         = DXPopoverMaskTypeNone;
    popover.betweenAtViewAndArrowHeight = 15;
    popover.cornerRadius = 2;
    [popover showAtView:self.navigationItem.rightBarButtonItem.customView withContentView:popoverView];

}
- (void)initRefresh{
    __weak typeof(self) weekSelf             = self;

    [self.tableView addHeaderWithCallback:^{
        [weekSelf loadNewStatus];
    }];
    [self.tableView addFooterWithCallback:^{
        [weekSelf loadMoreStatus];


    }];
}
- (void)openMenu{
    self.titleButton.arrowUp                 = YES;
    UITableView * tableView                  = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, 200, 300) style:UITableViewStylePlain];
    tableView.backgroundColor                = [UIColor colorWithRed:0.515 green:0.728 blue:0.000 alpha:1.000];
    DXPopover *popover                       = [DXPopover popover];
    popover.maskType                         = DXPopoverMaskTypeNone;
    [popover showAtView:self.titleButton withContentView:tableView];
//    self.titleButton.arrowUp = NO;

}
- (void)back{



}

#pragma mark - tableView DataSoure
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCStatusCell * cell                      = [RCStatusCell cellWithTableView:tableView];

    RCStatusFrame * statusFrame              = self.statusFrames[indexPath.row];
    cell.statusFrame                         = statusFrame;
    return cell;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.statusFrames.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCStatusFrame * statusFrame              = self.statusFrames[indexPath.row];

    return statusFrame.cellHigth;
}
#pragma mark - tableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSLog(@"didSelectRowAtIndexPath ");
    RCStatusDetailViewController * statusDetailC = [[RCStatusDetailViewController alloc]init];
    RCStatusFrame * statusFrame              = self.statusFrames[indexPath.row];

    statusDetailC.statusFrame = statusFrame;
    statusDetailC.reweetedStatus = NO;
    [self.navigationController pushViewController:statusDetailC animated:YES];

}
#pragma mark - 网络请求

/**
 *  加载新的微博数据
 */
- (void) loadNewStatus{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    NSDictionary *responseObject           = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"home" ofType:@"plist"]];
        // 将 "微博字典"数组 转为 "微博模型"数组
    NSArray *newStatuses                   = [RCStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];

        // 将 HWStatus数组 转为 HWStatusFrame数组
    NSArray *newFrames                     = [self statusFramesWithStatuses:newStatuses];

        // 将最新的微博数据，添加到总数组的最前面
    NSRange range                          = NSMakeRange(0, newFrames.count);
    NSIndexSet *set                        = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:set];

        // 刷新表格
        [self.tableView reloadData];

               // 显示最新微博的数量
        [self showNewStatusCount:newStatuses.count];
        [self.tableView headerEndRefreshing];

    });

    return;

    RCStatusParam * param                    = [[RCStatusParam alloc]init];
    param.access_token                       = [RCAccountTool account].access_token;
//    param.count = @20;
//    param.page = @1;
//    self.lastPage = param.page;
    RCStatusFrame * statusFrame              = [self.statusFrames firstObject];
    if (statusFrame) {
    param.since_id                           = @(statusFrame.status.idstr.longLongValue);
    }

    [RCStatusTool loadHomeStatusWithParam:param success:^(RCStatusResult *result) {
        //微博数据的数组
    NSMutableArray * statusFrames            = [self statusFramesWithStatuses:result.statuses];
        //插入最新的微博数据到最前面
        NSIndexSet * indexSet                    = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statusFrames.count)];
        [self.statusFrames insertObjects:statusFrames atIndexes:indexSet];
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];

        [self showNewStatusCount:result.statuses.count];
    } failure:^(NSError *error) {
        NSLog(@"加载数据失败========%@",error);
        [MBProgressHUD hideHUD];
        [self.tableView headerEndRefreshing];

    }];
//    }
}
/**
 *  加载更多的微博数据
 */
- (void) loadMoreStatus{
    RCStatusParam * param                    = [[RCStatusParam alloc]init];
    param.access_token                       = [RCAccountTool account].access_token;
//    param.count = @20;
//     param.page = @(4);
    // 取出最后面的那条微博
    RCStatusFrame *statusFrame               = [self.statusFrames lastObject];
    RCStatus * lastStatus                    = statusFrame.status;
    if (lastStatus) {
    param.max_id                             = @(lastStatus.idstr.longLongValue - 1);
    }
    [RCStatusTool loadHomeStatusWithParam:param success:^(RCStatusResult *result) {
        //微博数据的数组
    NSMutableArray * statusFrames            = [self statusFramesWithStatuses:result.statuses];
        [self.statusFrames addObjectsFromArray:statusFrames];
        
        [self.tableView reloadData];
        
        [self.tableView footerEndRefreshing];
        // 添加最新的模型数据
           } failure:^(NSError *error) {
        NSLog(@"加载数据失败========%@",error);
//        [MBProgressHUD hideHUD];
        [self.tableView footerEndRefreshing];

    }];
//}
}
/**
 * 返回最新的微博数据
 *
 */
- (NSMutableArray *)statusFramesWithStatuses:(NSArray *)statuses{
    NSMutableArray * newStatusTempArray      = [NSMutableArray array];
    for (RCStatus * status in statuses) {

    RCStatusFrame * statusFrame              = [[RCStatusFrame alloc]init];
    statusFrame.status                       = status;
        [newStatusTempArray addObject:statusFrame];
    }
    return newStatusTempArray;
}
/**
 * 获取用户信息
 *
 */
- (void)loadUserInfo{
    RCUserParam * param                      = [[RCUserParam alloc]init];
    param.access_token                       = [RCAccountTool account].access_token;
    param.uid                                = [[RCAccountTool account].uid longLongValue];


    [RCStatusTool userInfoWithParam:param success:^(RCUserInfoResult *result) {
        //设置标题
       	 [self.titleButton setTitle:result.name forState:UIControlStateNormal];
        //储存用户名
    RCAccount * account                      = [RCAccountTool account];
    account.name                             = result.name;

        [RCAccountTool saveAccount:account];
        //存储用户信息
        [RCUserTool saveUser:result];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

#pragma mark - 设置最新微博的提示框
- (void)showNewStatusCount:(NSUInteger )count{
    UILabel * reminderLabel                  = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    reminderLabel.textColor                  = [UIColor whiteColor];
    reminderLabel.textAlignment              = UITextAlignmentCenter;
    NSString * title                         = @"没有最新的微博";
    if (count) {
    title                                    = [NSString stringWithFormat:@"共有%d条最新的微博",count];
    }
    reminderLabel.text                       = title;
    NSTimeInterval duration                  = 1.0f;
    reminderLabel.backgroundColor            = [UIColor orangeColor];
    [self.navigationController.navigationBar insertSubview:reminderLabel atIndex:0];
    [UIView animateWithDuration:duration animations:^{
    reminderLabel.transform                  = CGAffineTransformMakeTranslation(0, 40);
        [UIView animateWithDuration:duration delay:duration options:UIViewAnimationOptionCurveLinear animations:^{
    reminderLabel.transform                  = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [reminderLabel removeFromSuperview];


        }];
    }];


}
#pragma mark - RCTopPopoverViewDelegate
- (void)topPopoverView:(RCTopPopoverView *)popoverView didClickedButtonType:(RCTopPopoverViewButtonType)buttonType{
    switch (buttonType) {
        case RCTopPopoverViewButtonTypeRefresh:
            [self.tableView headerBeginRefreshing];
            break;
            
        case RCTopPopoverViewButtonTypeSao:
            NSLog(@"RCTopPopoverViewButtonTypeSao");

            break;
    }

}
@end
