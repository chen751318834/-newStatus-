//
//  RCFriendshipsTool.h
//  高仿微博
//
//  Created by Raychen on 15/4/13.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCFriendshipsParam.h"
#import "RCFriendshipsResult.h"
@interface RCFriendshipsTool : NSObject
+ (void)frinedShipsWithparam:(RCFriendshipsParam *)param success:(void(^)(RCFriendshipsResult * result))success failure:(void(^)(NSError * error))failure;
@end
