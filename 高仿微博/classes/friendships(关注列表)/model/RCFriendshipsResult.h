//
//  RCFriendshipsResult.h
//  高仿微博
//
//  Created by Raychen on 15/4/13.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCUser.h"
#import "RCStatus.h"
@interface RCFriendshipsResult : NSObject
@property(strong,nonatomic) NSArray * users;

@property (nonatomic, assign)int total_number;

@end
