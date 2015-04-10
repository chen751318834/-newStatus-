//
//  RCPhoto.m
//  高仿微博
//
//  Created by Raychen on 15/4/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPhoto.h"

@implementation RCPhoto
- (NSString *)bmiddle_pic
{
    return [self.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}
@end
