//
//  RCStatusTool.m
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCStatusTool.h"
#import "RCNetWorkingTool.h"
#import "RCStatusParam.h"
#import "RCStatusResult.h"
#import "MJExtension.h"
#import "RCUserParam.h"
#import "RCUserInfoResult.h"
@implementation RCStatusTool
+ (void)loadHomeStatusWithParam:(RCStatusParam *)param success:(void (^)(RCStatusResult *))success failure:(void (^)(NSError *))failure{

    [RCNetWorkingTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:param.keyValues success:^(id json) {
        if (success) {
            RCStatusResult * result = [RCStatusResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)userInfoWithParam:(RCUserParam *)param success:(void (^)(RCUserInfoResult *))success failure:(void (^)(NSError *))failure{
    
    [RCNetWorkingTool get:@"https://api.weibo.com/2/users/show.json" params:param.keyValues success:^(id json) {
        if (success) {
            RCUserInfoResult * result = [RCUserInfoResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
@end
