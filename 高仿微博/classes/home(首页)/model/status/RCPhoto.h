//
//  RCPhoto.h
//  高仿微博
//
//  Created by Raychen on 15/4/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface RCPhoto : NSObject
/**
 *  缩略图片地址，没有时不返回此字段
 */
@property(copy,nonatomic) NSString * thumbnail_pic;

/** 中等图 */
- (NSString *)bmiddle_pic;
@end
