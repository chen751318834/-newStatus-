//
//  RCFollowerResult.m
//  高仿微博
//
//  Created by Raychen on 15/4/17.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCFollowerResult.h"
#import "RCFollower.h"

#import "MJExtension.h"
@implementation RCFollowerResult
- (NSDictionary *)objectClassInArray{
    return @{@"users":[RCFollower class]};

}
@end
