//
//  RCOauthTool.h
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RCNetWorkingTool,RCOauthParam,RCOauthResult;
@interface RCOauthTool : NSObject
+ (void)accessTokenWithparam:(RCOauthParam *)param success:(void(^)(RCOauthResult * result))success failure:(void(^)(NSError * error))failure;

@end
