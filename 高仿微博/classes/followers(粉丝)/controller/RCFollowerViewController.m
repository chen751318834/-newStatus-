//
//  RCFollowerViewController.m
//  高仿微博
//
//  Created by Raychen on 15/4/17.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCFollowerViewController.h"
#import "RCFollowerTool.h"
#import "RCFollowerParam.h"
#import "RCFollowerResult.h"
#import "RCAccountTool.h"
#import "RCFollower.h"
#import "RCFollowersCell.h"
@interface RCFollowerViewController ()
@property(strong,nonatomic) NSMutableArray * followers;

@end

@implementation RCFollowerViewController
-(NSMutableArray *)followers{
    if (!_followers) {
        self.followers =[NSMutableArray array];
    }
    return _followers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"粉丝";
    [self loadFollowers];
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.followers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCFollowersCell * cell = [RCFollowersCell cellWithTableView:tableView];
    
    RCFollower * follower = self.followers[indexPath.row];
    cell.follower = follower;
   
    return cell;
    
}
#pragma mark - 网络请求
#pragma mark  加载粉丝

- (void)loadFollowers{
    RCFollowerParam * param = [RCFollowerParam param];
    param.uid = [[RCAccountTool account].uid longLongValue];
    [RCFollowerTool followersWithparam:param success:^(RCFollowerResult *result) {
        NSIndexSet * set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.users.count)];
        [self.followers insertObjects:result.users atIndexes:set];
        [self.tableView reloadData];
    
    } failure:^(NSError *error) {
    
    }];

}

@end
