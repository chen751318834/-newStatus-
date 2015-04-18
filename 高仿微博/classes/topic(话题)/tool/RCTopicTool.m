//
//  RCTopicTool.m
//  高仿微博
//
//  Created by Raychen on 15/4/18.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCTopicTool.h"
#import "MJExtension.h"
#import "RCNetWorkingTool.h"
@implementation RCTopicTool
+ (void)topicWithparam:(RCTopicParam *)param success:(void (^)(RCTopicResult *))success failure:(void (^)(NSError *))failure{

    
    [RCNetWorkingTool get:@"https://api.weibo.com/2/search/topics.json" params:param.keyValues success:^(id json) {
        if (success) {
            RCTopicResult * result = [RCTopicResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
