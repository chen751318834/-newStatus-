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
#import "MJRefresh.h"
@interface RCHomeViewController ()
@property(nonatomic,weak) RCTitleButton * titleButton;
@property(strong,nonatomic) NSMutableArray * status;

@end

@implementation RCHomeViewController
#pragma mark - 懒加载
-(NSMutableArray *)status{
    if (!_status) {
        self.status =[NSMutableArray array];
    }
    return _status;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setUpNavigationBar];
    
//      加载新的微博数据
    [self loadNewStatus];
    //刷新控件
    [self initRefresh];
    
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
    static NSString * ID =@"status";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    RCStatus * status = self.status[indexPath.row];
    cell.textLabel.text = status.text;
    return cell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.status.count;
}
#pragma mark - 网络请求

/**
 *  加载新的微博数据
 */
- (void) loadNewStatus{

    RCStatusParam * param = [[RCStatusParam alloc]init];
    param.access_token = [RCAccountTool account].access_token;
    param.count = 50;
    param.page = 2;
            NSLog(@"=============%@",[RCAccountTool account].access_token);
//        [MBProgressHUD showMessage:@"正在加载数据....."];
    [RCStatusTool loadHomeStatusWithParam:param success:^(RCStatusResult *result) {
        NSLog(@"%@",result);
//        [MBProgressHUD hideHUDForView:self.view];
             [self.status addObjectsFromArray:result.statuses];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"加载数据失败========%@",error);
        [MBProgressHUD hideHUD];

    }];

}
- (void)initRefresh{
    [self.tableView addFooterWithCallback:^{
        
    }];
    [self.tableView addHeaderWithCallback:^{
        
    }];
}
@end
