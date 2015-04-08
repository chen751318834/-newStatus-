//
//  AppDelegate.m
//  高仿微博
//
//  Created by Raychen on 15/4/7.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "AppDelegate.h"
#import "RCTabBarController.h"
#import "RCNewFeatureViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //取出储存的版本号
    NSString * oldVersion = [[NSUserDefaults standardUserDefaults] valueForKey:@"CFBundleShortVersionString"];
    //获取当前版本号
  NSDictionary * infoDict = [NSBundle mainBundle].infoDictionary;
    NSString * currentVersion = infoDict[@"CFBundleShortVersionString"];
    NSLog(@"%@",currentVersion);
    
    //储存当前版本号
    [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:@"CFBundleShortVersionString"];
    
 
    if ([currentVersion isEqualToString:oldVersion]) {//版本号相同,进入主页面
        self.window.rootViewController = [[RCTabBarController alloc]init];
    }else{ //版本号不同，进入版本新特性界面
        self.window.rootViewController = [[RCNewFeatureViewController alloc]init];

    
    }
//    self.window.rootViewController = [[RCTabBarController alloc]init];
//    self.window.rootViewController = [[RCNewFeatureViewController alloc]init];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
