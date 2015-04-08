//
//  RCOauthTool.m
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCOauthTool.h"
#import "RCNetWorkingTool.h"
#import "RCOauthParam.h"
#import "RCOauthResult.h"
#import "MJExtension.h"
@implementation RCOauthTool
+ (void)accessTokenWithparam:(RCOauthParam *)param success:(void (^)(RCOauthResult *))success failure:(void (^)(NSError *))failure{
    [RCNetWorkingTool post:@"https://api.weibo.com/oauth2/access_token" params:param.keyValues success:^(id json) {
        if (success) {
               RCOauthResult *result = [RCOauthResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
@end
