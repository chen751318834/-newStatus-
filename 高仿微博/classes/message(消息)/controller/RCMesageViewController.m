//
//  RCMesageViewController.m
//  高仿微博
//
//  Created by Raychen on 15/4/7.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCMesageViewController.h"

@interface RCMesageViewController ()

@end

@implementation RCMesageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setUpNavigationBar];
}
/**
 *  设置导航栏
 */
- (void)setUpNavigationBar{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送消息" style:UIBarButtonItemStyleDone target:self action:@selector(sendMessage)];
    //设置文字的颜色
    NSMutableDictionary * nomalAttr = [NSMutableDictionary dictionary];
    nomalAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:nomalAttr forState:UIControlStateNormal];
    NSMutableDictionary * higthligthAttr = [NSMutableDictionary dictionary];
    nomalAttr[NSForegroundColorAttributeName] = [UIColor grayColor];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:higthligthAttr forState:UIControlStateHighlighted];
    
}

- (void)sendMessage{
    
    
    
}
@end
