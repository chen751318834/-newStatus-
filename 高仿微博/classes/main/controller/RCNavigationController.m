//
//  RCNavigationController.m
//  高仿微博
//
//  Created by Raychen on 15/4/7.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface RCNavigationController ()

@end

@implementation RCNavigationController
+(void)initialize{
//      UINavigationBar * navigationBar = [UINavigationBar appearance];
//    [navigationBar setBackgroundColor:[UIColor colorWithRed:1.000 green:0.737 blue:0.000 alpha:1.000]];
//    UINavigationItem * item = [UINavigationItem alloc];

    [self setUpNavigationBarItem];

}
+ (void)setUpNavigationBarItem{
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    // 设置文字颜色
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    // 去掉阴影
    textAttrs[NSBaselineOffsetAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
    // 设置文字字体
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    
    
    NSMutableDictionary * higthligthAttr = [NSMutableDictionary dictionary];
    higthligthAttr[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:higthligthAttr forState:UIControlStateHighlighted];
    
    NSMutableDictionary * disableAttr = [NSMutableDictionary dictionary];
    disableAttr[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.3] ;
    [item setTitleTextAttributes:disableAttr forState:UIControlStateDisabled];

   


}
- (void)showViewController:(UIViewController *)vc sender:(id)sender{
       [super showViewController:vc sender:sender];
    vc.hidesBottomBarWhenPushed = YES;
    vc.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" higthligthImage:@"navigationbar_friendsearch_highlighted"];

}



@end
