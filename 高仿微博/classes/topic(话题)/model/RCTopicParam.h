//
//  RCTopicParam.h
//  高仿微博
//
//  Created by Raychen on 15/4/18.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCParam.h"

@interface RCTopicParam : RCParam

/**
 *  搜索的话题关键字，必须进行URLencode，utf-8编码。
 */
@property(copy,nonatomic) NSString * q;
@property (nonatomic, assign)int count;
@property (nonatomic, assign)int page;


@end
