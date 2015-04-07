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
@interface RCHomeViewController ()
@property(nonatomic,weak) RCTitleButton * titleButton;
@end

@implementation RCHomeViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setUpNavigationBar];
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
@end
