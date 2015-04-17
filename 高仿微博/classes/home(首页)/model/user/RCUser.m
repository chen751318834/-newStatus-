//
//  RCUser.m
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCUser.h"
#import "MJExtension.h"
@implementation RCUser
MJCodingImplementation
- (BOOL)isVip
{
    return self.mbtype > 2;
}
- (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"desc":@"description"};

}
@end
