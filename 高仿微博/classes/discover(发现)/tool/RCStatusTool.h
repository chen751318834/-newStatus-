//
//  RCStatusTool.h
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RCStatusParam,RCStatusResult,RCNetWorkingTool,RCUserParam,RCUserInfoResult,RCStatus,RCCommentParam,RCCommentResult,RCTransmitParam,RCTransmitResult;
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
/**
 * 获取用户微博的评论
 *
 */
+ (void)commentWithParam:(RCCommentParam *)param success:(void (^)(RCCommentResult * result))success failure:(void (^)(NSError * error))failure;
/**
 *  转发微博
 *
 */
+ (void)transmitWithParam:(RCTransmitParam *)param success:(void (^)(RCTransmitResult * result))success failure:(void (^)(NSError * error))failure;
/**
 *  从数据库里读取微博数组
 *
 *  @param param 微博参数
 *
 *  @return 微博数组
 */
+ (NSArray *)statusesWithParam:(RCStatusParam *)param;
/**
 *  储存微博数组到数据库
 *
 *  @param statuses 微博数组
 */
+ (void)saveStatuses:(NSArray *)statuses;

@end
