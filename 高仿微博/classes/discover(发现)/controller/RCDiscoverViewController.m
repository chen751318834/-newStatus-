//
//  RCDiscoverViewController.m
//  高仿微博
//
//  Created by Raychen on 15/4/7.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCDiscoverViewController.h"
#import "RCSearchBar.h"
#import "HMCommonGroup.h"
#import "HMCommonItem.h"
@interface RCDiscoverViewController () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak) RCSearchBar * searchBar;
@end

@implementation RCDiscoverViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];
    [self setupGroups];

}
#pragma mark 设置导航栏
- (void)setUpNavigationBar{
    RCSearchBar * searchBar = [[RCSearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    self.searchBar = searchBar;
    searchBar.placeholder = @"大家都在搜....";
//    searchBar.inputAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    self.navigationItem.titleView = searchBar;

}

#pragma mark - tablevew delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"scrollViewDidScroll");
    [self.searchBar endEditing:YES];

}

- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    
}
- (void)setupGroup0
{
    // 1.创建组
    HMCommonGroup *group = [HMCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HMCommonItem *hotStatus = [HMCommonItem itemWithTitle:@"热门微博" icon:@"hot_status"];
    HMCommonItem *findPerson = [HMCommonItem itemWithTitle:@"找人" icon:@"find_people"];
    findPerson.badgeValue = @"10";
    
    
    group.items = @[hotStatus,findPerson];
}
- (void)setupGroup1
{
    // 1.创建组
    HMCommonGroup *group = [HMCommonGroup group];
    [self.groups addObject:group];
    // 2.设置组的所有行数据

    HMCommonItem *gameCenter = [HMCommonItem itemWithTitle:@"游戏中心" icon:@"game_center"];
    HMCommonItem *app = [HMCommonItem itemWithTitle:@"应用" icon:@"app"];
    HMCommonItem *ambitus = [HMCommonItem itemWithTitle:@"周边" icon:@"near"];
    HMCommonItem *todaycity = [HMCommonItem itemWithTitle:@"今日宜宾" icon:@"cast"];


 
    group.items = @[gameCenter,app,ambitus,todaycity];
    
}
- (void)setupGroup2
{
    // 1.创建组
    HMCommonGroup *group = [HMCommonGroup group];
    [self.groups addObject:group];
    // 2.设置组的所有行数据
    HMCommonItem *movie = [HMCommonItem itemWithTitle:@"电影" icon:@"movie"];
    HMCommonItem *music = [HMCommonItem itemWithTitle:@"听歌" icon:@"music"];
    HMCommonItem *more = [HMCommonItem itemWithTitle:@"更多频道" icon:@"more"];

    group.items = @[movie,music,more];
}

@end
