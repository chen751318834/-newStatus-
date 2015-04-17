//
//  RCTransmitResult.m
//  高仿微博
//
//  Created by Raychen on 15/4/17.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCTransmitResult.h"
#import "MJExtension.h"
#import "RCRepost.h"
@implementation RCTransmitResult
- (NSDictionary *)objectClassInArray{
    return @{@"reposts":[RCRepost class]};

}
@end
