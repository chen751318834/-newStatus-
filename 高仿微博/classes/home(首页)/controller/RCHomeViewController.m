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
@interface RCHomeViewController ()
@property(nonatomic,weak) RCTitleButton * titleButton;
/**
 *  存放微博数据，子控件的frame，cell的高度的数组
 */
@property(strong,nonatomic) NSMutableArray * statusFrames;
@property(strong,nonatomic) NSNumber * lastPage;

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
    // 设置导航栏
    [self setUpNavigationBar];
    

    //刷新控件
    [self initRefresh];
    
    [self.tableView headerBeginRefreshing];
    
}
/**
 *  设置导航栏
 */
- (void)setUpNavigationBar{
 
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" higthligthImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_pop" higthligthImage:@"navigationbar_pop_highlighted"];
    RCTitleButton * titleButton = [[RCTitleButton alloc]init];
    self.titleButton = titleButton;
   [titleButton setTitle:@"首页" forState:UIControlStateNormal];
//    titleButton .backgroundColor = [UIColor redColor];
    [titleButton addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;

}
- (void)initRefresh{
    __weak typeof(self) weekSelf = self;
    
    [self.tableView addHeaderWithCallback:^{
        [weekSelf loadNewStatus];
        
    }];
    [self.tableView addFooterWithCallback:^{
        [weekSelf loadMoreStatus];
        
        
    }];
}
- (void)openMenu{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, 200, 300) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor colorWithRed:0.515 green:0.728 blue:0.000 alpha:1.000];
    DXPopover *popover = [DXPopover popover];
    popover.maskType = DXPopoverMaskTypeNone;
    [popover showAtView:self.titleButton withContentView:tableView];


}
- (void)back{



}

#pragma mark - tableView DataSoure
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCStatusCell * cell = [RCStatusCell cellWithTableView:tableView];
    
    RCStatusFrame * statusFrame = self.statusFrames[indexPath.row];
    cell.statusFrame = statusFrame;
    return cell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.statusFrames.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCStatusFrame * statusFrame = self.statusFrames[indexPath.row];
   
    return statusFrame.cellHigth;
}
#pragma mark - tableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
#pragma mark - 网络请求

/**
 *  加载新的微博数据
 */
- (void) loadNewStatus{

    RCStatusParam * param = [[RCStatusParam alloc]init];
    param.access_token = [RCAccountTool account].access_token;
//    param.count = @20;
//    param.page = @1;
//    self.lastPage = param.page;
    RCStatusFrame * statusFrame = [self.statusFrames firstObject];
    if (statusFrame) {
          param.since_id = @(statusFrame.status.idstr.longLongValue);
    }
//            NSLog(@"=============%@",[RCAccountTool account].access_token);
//        [MBProgressHUD showMessage:@"正在加载数据....."];
    [RCStatusTool loadHomeStatusWithParam:param success:^(RCStatusResult *result) {
        //微博数据的数组
        NSMutableArray * newStatusesFrames = [self statusFramesWithStatuses:result.statuses];
         //插入最新的微博数据到最前面
        NSIndexSet * indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newStatusesFrames.count)];
        [self.statusFrames insertObjects:newStatusesFrames atIndexes:indexSet];
          [self.tableView reloadData];
         [self.tableView headerEndRefreshing];
//        NSLog(@"======%@",result.statuses);

    } failure:^(NSError *error) {
        NSLog(@"加载数据失败========%@",error);
        [MBProgressHUD hideHUD];
        [self.tableView headerEndRefreshing];

    }];
}
/**
 *  加载更多的微博数据
 */
- (void) loadMoreStatus{
    RCStatusParam * param = [[RCStatusParam alloc]init];
    param.access_token = [RCAccountTool account].access_token;
//    param.count = @20;
//     param.page = @(4);
    // 取出最后面的那条微博
    RCStatusFrame *statusFrame = [self.statusFrames lastObject];
    RCStatus * lastStatus = statusFrame.status;
    if (lastStatus) {
        param.max_id = @(lastStatus.idstr.longLongValue - 1);
    }
    //        [MBProgressHUD showMessage:@"正在加载数据....."];
    [RCStatusTool loadHomeStatusWithParam:param success:^(RCStatusResult *result) {
        //微博数据的数组
        NSMutableArray * newStatusesFrames = [self statusFramesWithStatuses:result.statuses];
        
        // 添加最新的模型数据
        [self.statusFrames addObjectsFromArray:newStatusesFrames];
        
        [self.tableView reloadData];
        
        [self.tableView footerEndRefreshing];

    } failure:^(NSError *error) {
        NSLog(@"加载数据失败========%@",error);
//        [MBProgressHUD hideHUD];
        [self.tableView footerEndRefreshing];
        
    }];
}
/**
 * 返回最新的微博数据
 *
 */
- (NSMutableArray *)statusFramesWithStatuses:(NSArray *)statuses{
    NSMutableArray * newStatusTempArray = [NSMutableArray array];
    for (RCStatus * status in statuses) {
        
        RCStatusFrame * statusFrame = [[RCStatusFrame alloc]init];
        statusFrame.status = status;
        [newStatusTempArray addObject:statusFrame];
    }
    return newStatusTempArray;
}

@end
