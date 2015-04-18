//
//  RCMeInfoViewController.m
//  高仿微博
//
//  Created by Raychen on 15/4/18.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCMeInfoViewController.h"
#import "UINavigationBar+Extension.h"
#import "RCMeInfoHeaderView.h"
#import "UIView+Extension.h"
#import "RCMeInfoTopView.h"
#import "RCMeInfoCellTopView.h"
#import "RCMeInfoHeaderView.h"
const CGFloat RCheaderImageViewH = 350;

@interface RCMeInfoViewController () <UITableViewDelegate,UITableViewDataSource,RCMeInfoCellTopViewDelegate>
@property(nonatomic,weak) UIImageView * headerImageView;
@property(strong,nonatomic) RCMeInfoCellTopView * cellTopView;
@end
@implementation RCMeInfoViewController
- (RCMeInfoCellTopView *)cellTopView{
    if (!_cellTopView) {
        self.cellTopView =[[RCMeInfoCellTopView alloc]initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, 35)];
        self.cellTopView.titles = @[@"主页",@"微博",@"相册",@"管理"];
        self.cellTopView.delegate = self;

        [self.view addSubview:_cellTopView];
    }
    return _cellTopView;
}


#pragma mark - 初始化
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpHeaderView ];
    [self setUpHeaderImageView];
}
#pragma mark 设置表格上面的view

- (void)setUpHeaderView{
    RCMeInfoTopView * topView = [RCMeInfoTopView topView];
    topView.frame = CGRectMake(0, -140, self.view.frame.size.width, 140);
    [ self.tableView insertSubview:topView atIndex:1];
    
  
    
    RCMeInfoHeaderView * headerView = [RCMeInfoHeaderView headerView];
    self.tableView.tableHeaderView = headerView;
}
#pragma mark 设置表格上面的图片
- (void)setUpHeaderImageView{
    UIImageView * headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -RCheaderImageViewH, self.view.frame.size.width, RCheaderImageViewH)];
    self.headerImageView = headerImageView;
    headerImageView.image = [UIImage imageNamed:@"headerImage"];
    [self.tableView insertSubview:headerImageView atIndex:0];
//    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.tableView.contentInset = UIEdgeInsetsMake(RCheaderImageViewH * 0.5, 0, 0, 0);
     self.tableView.sectionHeaderHeight = 35;


}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return self.cellTopView;
//    
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 24;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID =@"test";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试数据 --%d",indexPath.row];
    return cell;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor *color = [UIColor whiteColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        CGFloat alpha = 1 - ((64 - offsetY) / 64);
        [self.navigationController.navigationBar rc_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        self.navigationController.navigationBar.backgroundColor = [color colorWithAlphaComponent: 0];
    }
    
    
    // 向下拽了多少距离
    CGFloat down = -(RCheaderImageViewH * 0.5) - offsetY;
    if (down < 0) return;
    
    CGRect frame = self.headerImageView.frame;
    // 5决定图片变大的速度,值越大,速度越快
    frame.size.height = RCheaderImageViewH + down;
    self.headerImageView.frame = frame;
    NSLog(@"%f",self.cellTopView.frame.origin.y);
    //178
    NSLog(@"scrollViewDidScroll-----%f",offsetY);
  


}
#pragma mark - RCMeInfoCellTopViewDelegate
- (void)meInfoCellTopView:(RCMeInfoCellTopView *)TopView didClikedButton:(NSUInteger)index{

    NSLog(@"didClikedButton ---%d",index);
}

@end
