//
//  RCFriendshipsTool.m
//  高仿微博
//
//  Created by Raychen on 15/4/13.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCFriendshipsTool.h"
#import "MJExtension.h"
#import "RCNetWorkingTool.h"
@implementation RCFriendshipsTool
+ (void)frinedShipsWithparam:(RCFriendshipsParam *)param success:(void (^)(RCFriendshipsResult *))success failure:(void (^)(NSError *))failure{
    
    [RCNetWorkingTool get:@"https://api.weibo.com/2/friendships/friends.json" params:param.keyValues success:^(id json) {
        if (success) {
            RCFriendshipsResult * result = [RCFriendshipsResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
