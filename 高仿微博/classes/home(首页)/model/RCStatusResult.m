//
//  RCStatusResult.m
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCStatusResult.h"
#import "MJExtension.h"
#import "RCStatus.h"
@implementation RCStatusResult
- (NSDictionary *)objectClassInArray{

    return @{@"statuses":[RCStatus class]};

}
@end
