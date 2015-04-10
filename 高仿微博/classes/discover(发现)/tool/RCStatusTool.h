//
//  RCStatusTool.h
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RCStatusParam,RCStatusResult,RCNetWorkingTool,RCUserParam,RCUserInfoResult;
@interface RCStatusTool : NSObject
/**
 *  加载当前登录用户关注的微博
 *
 */
+ (void)loadHomeStatusWithParam:(RCStatusParam *)param success:(void (^)(RCStatusResult * result))success failure:(void (^)(NSError * error))failure;
/**
 *  获取当前登录用户信息
 */
+ (void)userInfoWithParam:(RCUserParam *)param success:(void (^)(RCUserInfoResult * result))success failure:(void (^)(NSError * error))failure;
@end
