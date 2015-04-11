//
//  RCSendStatusParam.h
//  高仿微博
//
//  Created by Raychen on 15/4/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCSendStatusParam : NSObject


@property(copy,nonatomic) NSString * access_token;
/**
 *  要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 */
@property(copy,nonatomic) NSString * status;
/**
 *  要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
 */
@property(strong,nonatomic) NSData * pic;


@end
