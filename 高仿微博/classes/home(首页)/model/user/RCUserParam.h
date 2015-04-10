//
//  RCUserParam.h
//  高仿微博
//
//  Created by Raychen on 15/4/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCUserParam : NSObject
/**
 *  采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 */
@property(copy,nonatomic) NSString * access_token;
/**
 *  需要查询的用户ID。
 */
//@property(strong,nonatomic) NSNumber * uid;
@property (nonatomic, assign)long long uid;



@end
