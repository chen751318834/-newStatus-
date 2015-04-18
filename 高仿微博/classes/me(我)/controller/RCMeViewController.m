//
//  RCMeViewController.m
//  高仿微博
//
//  Created by Raychen on 15/4/7.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCMeViewController.h"
#import "RCSettingViewController.h"
#import "HMCommonGroup.h"
#import "HMCommonArrowItem.h"
#import "RCMeHeaderVIew.h"
#import "RCUserTool.h"
#import "RCUser.h"
#import "RCFriendshipsViewController.h"
#import "RCFollowerViewController.h"
#import "RCMeInfoViewController.h"
#import "UIImage+RC.h"
@interface RCMeViewController () <RCMeHeaderVIewDelegate>

@end

@implementation RCMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 40, 0);
    [self setUpHeaderView];
    // 设置导航栏
    [self setUpNavigationBar];
    
    [self setUpGroups];
}
- (void)setUpHeaderView{
    
    RCMeHeaderVIew * headView = [RCMeHeaderVIew headerView];
    headView.delegate = self;
    self.tableView.tableHeaderView = headView;
    
}
/**
 *  设置导航栏
 */
- (void)setUpNavigationBar{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(openSetting)];
}

- (void)openSetting{
    
    [self.navigationController pushViewController:[[RCSettingViewController alloc]init] animated:YES];
    
}
- (void)setUpGroups{
    RCUser * user = [RCUserTool user];
    [self setUpGroup0:user];
    [self setUpGroup1:user];
    [self setUpGroup2];
    [self setUpGroup3];
    [self setUpGroup4];
    
    
    
}
- (void)setUpGroup0:(RCUser *)user{
    // 1.创建组
    HMCommonGroup *group = [HMCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HMCommonArrowItem *newFriend = [HMCommonArrowItem itemWithIcon:@"collect" title:@"新的好友" destVcClass:nil];
    
    
    
    NSString * statusMbTitle = [NSString stringWithFormat:@"微博等级 Lv%d",user.mbrank+7];

    HMCommonArrowItem *statusMb = [HMCommonArrowItem itemWithIcon:@"collect" title:statusMbTitle  destVcClass:nil];
//    statusMb.subtitle = [NSString stringWithFormat:@"Lv%d",user.mbrank];

    
    
    group.items = @[newFriend,statusMb];

    
}
- (void)setUpGroup1:(RCUser *)user{
    // 1.创建组
    HMCommonGroup *group = [HMCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HMCommonArrowItem *myphoto = [HMCommonArrowItem itemWithIcon:@"album" title:@"我的相册" destVcClass:nil];
    HMCommonArrowItem *mysc = [HMCommonArrowItem itemWithIcon:@"collect" title:[NSString stringWithFormat:@"我的收藏(%d)",user.favourites_count] destVcClass:nil];
    
    HMCommonArrowItem *zan = [HMCommonArrowItem itemWithIcon:@"like" title:@"赞" destVcClass:nil];
    
    
    
    group.items = @[myphoto,mysc,zan];

    
}
- (void)setUpGroup2{
    // 1.创建组
    HMCommonGroup *group = [HMCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HMCommonArrowItem *statusPay = [HMCommonArrowItem itemWithIcon:@"pay" title:@"微博支付" destVcClass:nil];
    HMCommonArrowItem *prices = [HMCommonArrowItem itemWithIcon:@"vip" title:@"个性化" destVcClass:nil];
    
    
    
    group.items = @[statusPay,prices];
    
}
- (void)setUpGroup3{
    
    // 1.创建组
    HMCommonGroup *group = [HMCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HMCommonArrowItem *hotStatus = [HMCommonArrowItem itemWithIcon:@"draft" title:@"草稿纸" destVcClass:nil];

    
    
    group.items = @[hotStatus];
}
- (void)setUpGroup4{
    
    // 1.创建组
    HMCommonGroup *group = [HMCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HMCommonArrowItem *more = [HMCommonArrowItem itemWithIcon:@"collect" title:@"更多" destVcClass:nil];
    
    
    
    group.items = @[more];
    
}
#pragma mark - RCMeHeaderVIewDelegate
- (void)meHeaderVIew:(RCMeHeaderVIew *)headerView didCilckedButtonType:(RCMeHeaderVIewButtonType)buttonType{
    switch (buttonType) {
        case RCMeHeaderVIewButtonTypeStauts:
            break;
        case RCMeHeaderVIewButtonTypeFriends:
            [self.navigationController pushViewController:[[RCFriendshipsViewController alloc] init] animated:YES];

            break;
        case RCMeHeaderVIewButtonTypeFollowers:
                        [self.navigationController pushViewController:[[RCFollowerViewController alloc] init] animated:YES];
            break;
        default:
            break;
    }
}

- (void)meHeaderVIewDidHeaderView:(RCMeHeaderVIew *)headerView{
    
    [self.navigationController pushViewController:[[RCMeInfoViewController alloc] init] animated:YES];

}
@end
