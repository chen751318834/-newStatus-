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
- (void)viewDidLoad{

    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = nil;
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

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count>0) {
       
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back" higthligthImage:@"navigationbar_back_highlighted" targrt:self action:@selector(back)];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_more" higthligthImage:@"navigationbar_more_highlighted" targrt:self action:@selector(more)];
         viewController.hidesBottomBarWhenPushed = YES;
      }
    
    [super pushViewController:viewController animated:animated];


}
- (void)back{
    [self popViewControllerAnimated:YES];

}
- (void)more{
    [self popToRootViewControllerAnimated:YES];
    
}

@end
