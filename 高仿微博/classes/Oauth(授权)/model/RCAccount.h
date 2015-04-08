//
//  RCAccount.h
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCOauthResult.h"

@interface RCAccount : RCOauthResult
@property (nonatomic, strong) NSDate *expires_time; // 过期时间
@end
