//
//  RCPublicSettingViewController.m
//  高仿微博
//
//  Created by Raychen on 15/4/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCInformSettingViewController.h"
#import "HMCommonGroup.h"
#import "HMCommonArrowItem.h"
#import "HMCommonSwitchItem.h"
@interface RCInformSettingViewController ()

@end

@implementation RCInformSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知设置";
    [self setUpGroup0];
    [self setUpGroup1];
    [self setUpGroup2];
}

- (void)setUpGroup0{
    // 1.创建组
    HMCommonGroup *group = [HMCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HMCommonItem *me = [HMCommonArrowItem itemWithTitle:@"@我的" destVcClass:nil];
    HMCommonItem *pingjia = [HMCommonArrowItem itemWithTitle:@"评论" destVcClass:nil];
    HMCommonItem *like = [HMCommonArrowItem itemWithTitle:@"赞" destVcClass:nil];
    
    HMCommonItem *priveLetter = [HMCommonSwitchItem itemWithTitle:@"私信"];
    HMCommonItem *qun = [HMCommonSwitchItem itemWithTitle:@"群通知"];
    HMCommonItem *nulike = [HMCommonArrowItem itemWithTitle:@"未关注人私信" destVcClass:nil];
    HMCommonItem *newFrined = [HMCommonArrowItem itemWithTitle:@"新粉丝" destVcClass:nil];
    
    
    
    
    group.items = @[me,pingjia,like,priveLetter,qun,nulike,newFrined];
    
    
}
- (void)setUpGroup1{
    // 1.创建组
    HMCommonGroup *group = [HMCommonGroup group];
    [self.groups addObject:group];
    group.header = @"新微博推送通知";
    HMCommonItem *priveLetter = [HMCommonSwitchItem itemWithTitle:@"好友圈微博"];
    HMCommonItem *nulike = [HMCommonArrowItem itemWithTitle:@"特别关注微博" destVcClass:nil];
    HMCommonItem *qun = [HMCommonSwitchItem itemWithTitle:@"群微博"];
    HMCommonItem *hot = [HMCommonSwitchItem itemWithTitle:@"微博热点"];
    group.items = @[priveLetter,nulike,qun,hot];
}

- (void)setUpGroup2{
    // 1.创建组
    HMCommonGroup *group = [HMCommonGroup group];
    [self.groups addObject:group];
    
    HMCommonItem *nulike = [HMCommonArrowItem itemWithTitle:@"免打扰设置" destVcClass:nil];
    HMCommonItem *qun =  [HMCommonArrowItem itemWithTitle:@"获取新消息" destVcClass:nil];

    group.items = @[nulike,qun];
}
@end
