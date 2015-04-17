//
//  RCCommentParam.h
//  高仿微博
//
//  Created by Raychen on 15/4/17.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCParam.h"

@interface RCCommentParam : RCParam
/**
 *  id	true	int64	需要查询的微博ID。
 */
@property(strong,nonatomic) NSNumber * ID;

/**
 *  若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 
 */
@property (nonatomic, strong)NSNumber * since_id;

/**
 * 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 */
@property (nonatomic, strong)NSNumber * max_id;
///**
// *单页返回的记录条数，最大不超过100，默认为20。
// */
@property (nonatomic,  strong)NSNumber * count;
@end
