//
//  RCTabBarController.m
//  高仿微博
//
//  Created by Raychen on 15/4/7.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCTabBarController.h"
#import "RCHomeViewController.h"
#import "RCMesageViewController.h"
#import "RCDiscoverViewController.h"
#import "RCMeViewController.h"
#import "RCNavigationController.h"
#import "RCTabBar.h"
@interface RCTabBarController () <RCTabBarDelegate>

@end

@implementation RCTabBarController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initChidControllers];
    RCTabBar * custunTabBar = [[RCTabBar alloc]init];
    custunTabBar.delegate = self;
    [self setValue:custunTabBar forKeyPath:@"tabBar"];
 }
/**
 *  初始化子控制器
 */
- (void)initChidControllers{
    
    //主页
        RCHomeViewController * homeC = [[RCHomeViewController alloc]init];
    [self initChidController:homeC title:@"主页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    //消息
    RCMesageViewController * messageC = [[RCMesageViewController alloc]init];

        [self initChidController:messageC title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    //发现
    RCDiscoverViewController * discoverC = [[RCDiscoverViewController alloc]init];

        [self initChidController:discoverC title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    //我
    RCMeViewController *meC = [[RCMeViewController alloc]init];
    [self initChidController:meC title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];

}
/**
 *   初始化一个控制器
 */
- (void)initChidController:(UIViewController*)childController title:(NSString *)title image:(NSString *)iamge selectedImage:(NSString *)selectedImage   {
    childController.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:iamge];
    childController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    RCNavigationController * NavC = [[RCNavigationController alloc]initWithRootViewController:childController];
    [self addChildViewController:NavC];
     //设置tabBar
//    UITabBar * tabBar = [UITabBar     appearance];
    //文字颜色
    NSMutableDictionary * normalAttr = [NSMutableDictionary dictionary];
    normalAttr[NSForegroundColorAttributeName] = [UIColor grayColor];
    [childController.tabBarItem setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    NSMutableDictionary * selctedAttr = [NSMutableDictionary dictionary];
    selctedAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childController.tabBarItem setTitleTextAttributes:selctedAttr forState:UIControlStateSelected ];
}

#pragma mark - RCTabBarDelegate
- (void)tabBarDidPlusButton:(RCTabBar *)tabBar{
//    NSLog(@"tabBarDidPlusButton");

}
@end
