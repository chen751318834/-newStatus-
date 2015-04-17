//
//  RCUserTool.m
//  高仿微博
//
//  Created by Raychen on 15/4/13.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCUserTool.h"
#define RCUserPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"user.plist"]
@implementation RCUserTool
+ (RCUser *)user{

    return [NSKeyedUnarchiver unarchiveObjectWithFile:RCUserPath];
}
+ (void)saveUser:(RCUser *)user{
    [NSKeyedArchiver archiveRootObject:user toFile:RCUserPath];

}
@end
