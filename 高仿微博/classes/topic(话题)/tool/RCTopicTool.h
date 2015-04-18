//
//  RCTopicTool.h
//  高仿微博
//
//  Created by Raychen on 15/4/18.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTopicParam.h"
#import "RCTopicResult.h"
@interface RCTopicTool : NSObject
+ (void)topicWithparam:(RCTopicParam *)param success:(void(^)(RCTopicResult * result))success failure:(void(^)(NSError * error))failure;
@end
