//
//  RCAccountTool.m
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAccountTool.h"
#import "RCAccount.h"
#define RCAccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.plist"]
@implementation RCAccountTool
+ (RCAccount *)account{
    // 判断账号(accessToken)是否过期
    RCAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:RCAccountFilepath];
    
//    // 当前时间
//    NSDate *now = [NSDate date];
//    // 比较当前时间 和 账号的过期时间
//    if ([account.expires_time compare:now ] == NSOrderedAscending) { // 过期
//        return nil; // 直接返回nil
//    }
    
    return account;
}
+ (void)saveAccount:(RCAccount *)account{
  
    [NSKeyedArchiver archiveRootObject:account toFile:RCAccountFilepath];

}

@end
