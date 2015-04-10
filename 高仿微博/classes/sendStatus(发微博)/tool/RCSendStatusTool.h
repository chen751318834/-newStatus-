//
//  RCSendStatusTool.h
//  高仿微博
//
//  Created by Raychen on 15/4/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCSendStatusParam.h"
#import "RCSendStatusResult.h"
@interface RCSendStatusTool : NSObject
/**
 *  发送一条只有文字的微博
 *
 */
+ (void)sendOneStatusWithparam:(RCSendStatusParam *)param success:(void(^)(RCSendStatusResult * result))success failure:(void(^)(NSError * error))failure;

@end
