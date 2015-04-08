//
//  RCOauthParam.h
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCParam.h"
@interface RCOauthParam : RCParam
/**
 *  申请应用时分配的AppKey
 */
@property(copy,nonatomic) NSString * client_id;
/**
 *  申请应用时分配的AppSecret
 */
@property(copy,nonatomic) NSString * client_secret;
/**
 *  请求的类型，填写authorization_code
 */
@property(copy,nonatomic) NSString * grant_type;
/**
 *  调用authorize获得的code值。
 */
@property(copy,nonatomic) NSString * code;
/**
 *  回调地址，需需与注册应用里的回调地址一致。
 */
@property(copy,nonatomic) NSString * redirect_uri;
@end
