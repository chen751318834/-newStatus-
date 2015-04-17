//
//  RCFollowerTool.m
//  高仿微博
//
//  Created by Raychen on 15/4/17.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCFollowerTool.h"
#import "RCNetWorkingTool.h"
#import "MJExtension.h"
@implementation RCFollowerTool
+ (void)followersWithparam:(RCFollowerParam *)param success:(void (^)(RCFollowerResult *))success failure:(void (^)(NSError *))failure{

    [RCNetWorkingTool get:@"https://api.weibo.com/2/friendships/followers.json" params:param.keyValues success:^(id json) {
        if (success) {
            RCFollowerResult * result = [RCFollowerResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
@end
