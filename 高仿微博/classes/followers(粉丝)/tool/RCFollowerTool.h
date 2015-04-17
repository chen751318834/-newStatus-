//
//  RCFollowerTool.h
//  高仿微博
//
//  Created by Raychen on 15/4/17.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCFollowerParam.h"
#import "RCFollowerResult.h"
@interface RCFollowerTool : NSObject
+ (void)followersWithparam:(RCFollowerParam *)param success:(void(^)(RCFollowerResult * result))success failure:(void(^)(NSError * error))failure;
@end
