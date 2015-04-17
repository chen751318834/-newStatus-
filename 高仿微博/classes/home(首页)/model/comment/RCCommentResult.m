//
//  RCCommentResult.m
//  高仿微博
//
//  Created by Raychen on 15/4/17.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCCommentResult.h"
#import "RCComment.h"
#import "MJExtension.h"
@implementation RCCommentResult
- (NSDictionary *)objectClassInArray{
    return @{@"comments":[RCComment class]};
}
@end
