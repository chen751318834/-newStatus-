//
//  RCTabBar.h
//  高仿微博
//
//  Created by Raychen on 15/4/7.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCTabBar;
@protocol RCTabBarDelegate <NSObject>

@optional
- (void)tabBarDidPlusButton:(RCTabBar *)tabBar;

@end

@interface RCTabBar : UITabBar
@property(nonatomic,weak) id<RCTabBarDelegate> delegate;
@end
