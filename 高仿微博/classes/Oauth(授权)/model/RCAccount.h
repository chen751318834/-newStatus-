//
//  RCAccount.h
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "RCAccount.h"
@interface RCAccount : NSObject
/**
 *  用于调用access_token，接口获取授权后的access token
 */
@property(copy,nonatomic) NSString * access_token;

@property (nonatomic, strong) NSDate *expires_time; // 过期时间


@property (nonatomic, copy) NSString *name; // 用户昵称
/**
 *  access_token的生命周期
 */
@property(copy,nonatomic) NSString * remind_in;
/**
 *  当前授权用户的UID
 */
@property(strong,nonatomic) NSNumber * uid;
@end
