//
//  RCParam.m
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCParam.h"
#import "RCAccountTool.h"
@implementation RCParam
+ (id)param{
    return  [[self alloc]init];
}
- (instancetype)init{
    if ([super init]) {
        self.access_token = [RCAccountTool account].access_token;
    }
    return self;
}
@end
