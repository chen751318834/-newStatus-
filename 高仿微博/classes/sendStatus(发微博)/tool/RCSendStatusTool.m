//
//  RCSendStatusTool.m
//  高仿微博
//
//  Created by Raychen on 15/4/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSendStatusTool.h"
#import "MJExtension.h"
#import "RCNetWorkingTool.h"
@implementation RCSendStatusTool
+ (void)sendOneStatusWithparam:(RCSendStatusParam *)param success:(void (^)(RCSendStatusResult *))success failure:(void (^)(NSError *))failure{
    [RCNetWorkingTool post:@"https://api.weibo.com/2/statuses/update.json" params:param.keyValues success:^(id json) {
        if (success) {
            RCSendStatusResult *result = [RCSendStatusResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)sendOneImageStatusWithparam:(RCSendStatusParam *)param data:(NSData *)data success:(void (^)(RCSendStatusResult *))success failure:(void (^)(NSError *))failure{
    [RCNetWorkingTool post:@"https://upload.api.weibo.com/2/statuses/upload.json" params:param.keyValues data:data success:^(id json) {
        if (success) {
            RCSendStatusResult *result = [RCSendStatusResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
