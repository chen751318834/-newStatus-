//
//  RCStatus.h
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCUser.h"
@interface RCStatus : NSObject
/**
 *  微博创建时间
 */
@property(copy,nonatomic) NSString * created_at;
/**
 *  微博ID
 */
@property(copy,nonatomic) NSString * idstr;
/**
 *  微博信息内容
 */
@property(copy,nonatomic) NSString * text;
/**
 *  	微博来源
 */
@property(copy,nonatomic) NSString * source;
/**
 *  是否已收藏，true：是，false：否
 */
@property (nonatomic, assign)BOOL favorited;
/**
 *  是否被截断，true：是，false：否
 
 */
@property (nonatomic, assign)BOOL truncated;
/**
 *  转发数
 */
@property (nonatomic, assign)int reposts_count;
/**
 * 评论数
 */
@property (nonatomic, assign)int comments_count;
/**
 *  表态数
 */
@property (nonatomic, assign)int attitudes_count;


/**
 被转发的原微博信息字段，当该微博为转发微博时返回
 */
@property(strong,nonatomic) RCStatus * retweeted_status;
/**
 *  微博作者的用户信息字段
 */
@property(strong,nonatomic) RCUser * user;
/**
 *  	微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
 */
@property(strong,nonatomic) NSArray * pic_ids;


@end
