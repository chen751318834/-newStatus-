//
//  RCSettingViewController.m
//  高仿微博
//
//  Created by Raychen on 15/4/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSettingViewController.h"
#import "HMCommonItem.h"
#import "HMCommonGroup.h"
#import "HMCommonArrowItem.h"
#import "HMCommonSwitchItem.h"
#import "HMCommonLabelItem.h"
#import "HMCommonViewController.h"
#import "RCInformSettingViewController.h"
@interface RCSettingViewController ()

@end

@implementation RCSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self setUpGroup0];
    [self setUpGroup1];
    [self setUpGroup2];
    [self setUpGroup3];
}
- (void)setUpGroup0{
    // 1.创建组
    HMCommonGroup *group = [HMCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HMCommonArrowItem *account = [HMCommonArrowItem itemWithTitle:@"账号设置" destVcClass:nil];
    account.badgeValue = @"12";
    group.items = @[account];
}


- (void)setUpGroup1{
    // 1.创建组
    HMCommonGroup *group = [HMCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HMCommonArrowItem *sendSetting = [HMCommonArrowItem itemWithTitle:@"通知设置" destVcClass:[RCInformSettingViewController class]];

    HMCommonArrowItem *publicSetting = [HMCommonArrowItem itemWithTitle:@"通用设置" destVcClass:nil];
    
    HMCommonArrowItem *safe = [HMCommonArrowItem itemWithTitle:@"隐私与安全" destVcClass:nil];
    
    
    
    group.items = @[sendSetting,publicSetting,safe];
    
    
}
- (void)setUpGroup2{
    // 1.创建组
    HMCommonGroup *group = [HMCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HMCommonArrowItem *fankui = [HMCommonArrowItem itemWithTitle:@"意见反馈" destVcClass:nil];

    HMCommonArrowItem *about = [HMCommonArrowItem itemWithTitle:@"关于微博" destVcClass:nil];

    
    
    
    group.items = @[fankui,about];
    
    
}
- (void)setUpGroup3{
    // 1.创建组
    HMCommonGroup *group = [HMCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HMCommonItem *nigthMode= [HMCommonSwitchItem itemWithTitle:@"夜间模式"];
    HMCommonItem *clear = [HMCommonArrowItem itemWithTitle:@"清除缓存"];
    clear.subtitle = @"33.3MB";
    clear.operation = ^{
    
    
    
    };

    group.items = @[nigthMode,clear];
    
    
}

@end
