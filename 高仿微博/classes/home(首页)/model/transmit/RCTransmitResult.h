//
//  RCTransmitResult.h
//  高仿微博
//
//  Created by Raychen on 15/4/17.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCTransmitResult : NSObject
@property(strong,nonatomic) NSArray * reposts;
@property (nonatomic, assign)int total_number;

@end
