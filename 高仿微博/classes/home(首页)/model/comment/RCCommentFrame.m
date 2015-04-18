//
//  RCCommentFrame.m
//  高仿微博
//
//  Created by Raychen on 15/4/17.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCCommentFrame.h"
/**
 *  子控件之间的间距
 */
static const CGFloat RCMargin = 10;
@implementation RCCommentFrame
- (void)setComment:(RCComment *)comment{
    _comment = comment;
    
    //头像
    CGFloat iconX = RCMargin;
    CGFloat iconY = RCMargin;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    _iconViewF = CGRectMake(iconX, iconY, iconW, iconH);
    //用户名
    CGFloat userNameX = CGRectGetMaxX(_iconViewF)+RCMargin;
    CGFloat userNameY = iconY;
    
    CGSize  userNameLabelSize = [self.comment.user.name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:RCUserNameFont]} context:nil].size;
    _userNameLabelF = CGRectMake(userNameX, userNameY, userNameLabelSize.width, userNameLabelSize.height);

    
    //微博发送时间
    CGFloat  timeX = userNameX;
    CGFloat  timeY = CGRectGetMaxY(_userNameLabelF)+RCMargin;
    CGSize  timeLabelSize = [self.comment.created_at boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:RCTimeFont]} context:nil].size;
    _timeLabelF = CGRectMake(timeX, timeY, timeLabelSize.width, timeLabelSize.height);
    
    

    
    
    //正文
    
    CGFloat  contentX = iconX;
    CGFloat  contentY = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_timeLabelF))+ RCMargin;
    CGSize  contentLabelSize = [comment.attributedText boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2*contentX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    _contentLabelF = CGRectMake(contentX, contentY, contentLabelSize.width, contentLabelSize.height);
    
    
    //微博发送时间
    CGFloat  likeViewX = [UIScreen mainScreen].bounds.size.width - 40;
    CGFloat  likeViewY = userNameY +RCMargin/2;;
    CGFloat  likeViewW = 20;
    CGFloat  likeViewH = likeViewW;
        _likeViewF = CGRectMake(likeViewX, likeViewY, likeViewW,likeViewH);
    
    _cellHigth = CGRectGetMaxY(_contentLabelF)+RCMargin*2;

}
@end
