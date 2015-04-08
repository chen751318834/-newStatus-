//
//  RCDiscoverViewController.m
//  高仿微博
//
//  Created by Raychen on 15/4/7.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCDiscoverViewController.h"
#import "RCSearchBar.h"
@interface RCDiscoverViewController () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak) RCSearchBar * searchBar;
@end

@implementation RCDiscoverViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];
}
#pragma mark 设置导航栏
- (void)setUpNavigationBar{
    RCSearchBar * searchBar = [[RCSearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    self.searchBar = searchBar;
    searchBar.placeHodler = @"大家都在搜....";
//    searchBar.inputAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    self.navigationItem.titleView = searchBar;

}

#pragma mark - tablevew delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"scrollViewDidScroll");
    [self.searchBar endEditing:YES];


}
@end
