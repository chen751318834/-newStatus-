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
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)showViewController:(UIViewController *)vc sender:(id)sender{
       [super showViewController:vc sender:sender];
    vc.hidesBottomBarWhenPushed = YES;
    vc.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" higthligthImage:@"navigationbar_friendsearch_highlighted"];

}
- (void)back{
//NSLog(@"backback");
   
}
@end
