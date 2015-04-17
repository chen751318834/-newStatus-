//
//  RCFriendshipsResult.m
//  高仿微博
//
//  Created by Raychen on 15/4/13.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCFriendshipsResult.h"
#import "MJExtension.h"
@implementation RCFriendshipsResult
- (NSDictionary *)objectClassInArray{
    return @{@"users":[RCUser class]};

}
@end
