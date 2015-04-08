//
//  RCStatusTool.h
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RCStatusParam,RCStatusResult,RCNetWorkingTool;
@interface RCStatusTool : NSObject
+ (void)loadHomeStatusWithParam:(RCStatusParam *)param success:(void (^)(RCStatusResult * result))success failure:(void (^)(NSError * error))failure;
@end
