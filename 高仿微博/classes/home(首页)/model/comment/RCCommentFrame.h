//
//  RCCommentFrame.h
//  高仿微博
//
//  Created by Raychen on 15/4/17.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "RCComment.h"

#define RCUserNameFont 14
#define RCTimeFont 10

#define RCSoureFont 10

#define RCUContentFont 14

@interface RCCommentFrame : NSObject
@property(strong,nonatomic) RCComment * comment;

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
 *  文本的Frame
 */
@property (nonatomic, assign,readonly)CGRect contentLabelF;

/**
 *  文本的Frame
 */
@property (nonatomic, assign,readonly)CGRect likeViewF;
/**
 *  cell的高度
 */
@property (nonatomic, assign)CGFloat cellHigth;
@end
