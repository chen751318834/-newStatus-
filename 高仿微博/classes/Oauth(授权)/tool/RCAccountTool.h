//
//  RCAccountTool.h
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCAccount.h"
@interface RCAccountTool : NSObject
/**
 *  获取账户信息
 *
 *  @return 账户模型
 */
+ (RCAccount *)account;
/**
 *  保存账户信息
 *
  */
+ (void)saveAccount:(RCAccount *)account;
@end
