//
//  RCStatusFrame.h
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RCStatus.h"
static const CGFloat RCUserNameFont = 14;
static const CGFloat RCTimeFont = 10;
static const CGFloat RCSoureFont = 10;
static const CGFloat RCUContentFont = 14;
static const CGFloat RCReweetedStatusContentFont = 14;
@interface RCStatusFrame : NSObject
/**
 *  cell的View的Frame
 */
@property(nonatomic,assign,readonly) CGRect  statusContentViewF;

/*****************************************************/
/************ 原创微博整体 **********/
@property(nonatomic,assign,readonly) CGRect originalStastusViewF;

/**
 *  头像的Frame
 */
@property (nonatomic, assign,readonly)CGRect iconViewF;
/**
 *  用户名的Frame */
@property (nonatomic, assign,readonly)CGRect userNameLabelF;
/**
 *  时间的Frame
 */
@property (nonatomic, assign,readonly)CGRect timeLabelF;
/**
 *  微博来源的Frame
 */
@property (nonatomic, assign,readonly)CGRect soureLabelF;
/**
 *  vip的Frame
 */
@property (nonatomic, assign,readonly)CGRect vipViewF;
/**
 *  文本的Frame
 */
@property (nonatomic, assign,readonly)CGRect contentLabelF;
/**
 *  配图的Frame
 */
@property (nonatomic, assign,readonly)CGRect photosViewF;
/*****************************************************/
/************ 转发微博整体 **********/
@property (nonatomic, assign,readonly)CGRect retweetedStatusViewF;
/**
 * 正文
 */
@property(nonatomic,assign,readonly)CGRect retweetedContentLabelF;
/**
 *  配图
 */
@property(nonatomic,assign,readonly)CGRect retweetedPhotosViewF;
/************ 下面的工具条整体 **********/
@property (nonatomic, assign,readonly)CGRect toolBarF;
/**
 *  微博模型
 */
@property(strong,nonatomic) RCStatus * status;
/**
 *  cell的高度
 */
@property (nonatomic, assign)CGFloat cellHigth;
@property(nonatomic,assign,readonly) CGRect statusViewF;

@end
