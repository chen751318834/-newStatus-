//
//  RCFriendshipsParam.h
//  高仿微博
//
//  Created by Raychen on 15/4/13.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCFriendshipsParam : NSObject
@property(copy,nonatomic) NSString * access_token;
/**
 *  需要查询的用户UID。
 */
@property (nonatomic, assign)long long uid;
/**
 *  	单页返回的记录条数，默认为50，最大不超过200。
 */
@property (nonatomic, assign)int count;
/**
 *  	返回结果的游标，下一页用返回值里的next_cursor，上一页用previous_cursor，默认为0。
 */
@property (nonatomic, assign)int cursor;
/**
 *  t	返回值中user字段中的status字段开关，0：返回完整status字段、1：status字段仅返回status_id，默认为1。
 */
@property (nonatomic, assign)int trim_status;



@end
