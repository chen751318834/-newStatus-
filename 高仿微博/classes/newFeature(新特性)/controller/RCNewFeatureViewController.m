//
//  RCNewFeatureViewController.m
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCNewFeatureViewController.h"
#import "RCNewFeatureView.h"
#import "RCTabBarController.h"

@interface RCNewFeatureViewController () <RCNewFeatureViewDelegate>

@end
@implementation RCNewFeatureViewController
#pragma mark - 初始化
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    RCNewFeatureView * newFeatureView = [[RCNewFeatureView alloc]initWithFrame:self.view.bounds];
    newFeatureView.delegate = self;

    [self.view addSubview:newFeatureView];
}
#pragma mark - RCNewFeatureViewDelegate
- (void)newFeatureViewDidEnterAppButton:(RCNewFeatureView *)newFeatureView{
    UIWindow * keyWindow = [UIApplication sharedApplication ].keyWindow;
    keyWindow.rootViewController = [[RCTabBarController alloc]init];

}

- (void)newFeatureViewDidShareButton:(RCNewFeatureView *)newFeatureView{
 
}
@end
