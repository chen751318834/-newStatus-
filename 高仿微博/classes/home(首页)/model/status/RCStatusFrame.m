//
//  RCStatusFrame.m
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCStatusFrame.h"
#import "RCPhotosView.h"
/**
 *  子控件之间的间距
 */
static const CGFloat RCMargin = 10;

@implementation RCStatusFrame
/**
 *  计算子控件的Frame
 *
 *  @param status
 */
- (void)setStatus:(RCStatus *)status{
    _status = status;
    
     //头像
    CGFloat iconX = RCMargin;
    CGFloat iconY = RCMargin;
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    _iconViewF = CGRectMake(iconX, iconY, iconW, iconH);
    //用户名
    CGFloat userNameX = CGRectGetMaxX(_iconViewF)+RCMargin;
    CGFloat userNameY = iconY;

    CGSize  userNameLabelSize = [self.status.user.name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:RCUserNameFont]} context:nil].size;
    _userNameLabelF = CGRectMake(userNameX, userNameY, userNameLabelSize.width, userNameLabelSize.height);
     //Vip
    CGFloat vipX = CGRectGetMaxX(_userNameLabelF)+RCMargin;
    CGFloat vipY = userNameY;
    CGFloat vipW = 17;
    CGFloat vipH = 17;
    _vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    
    //微博发送时间
    CGFloat  timeX = userNameX;
    CGFloat  timeY = CGRectGetMaxY(_userNameLabelF)+RCMargin;
    CGSize  timeLabelSize = [self.status.created_at boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:RCTimeFont]} context:nil].size;
    _timeLabelF = CGRectMake(timeX, timeY, timeLabelSize.width, timeLabelSize.height);
    
    //微博来源
    CGFloat  soureX = CGRectGetMaxX(_timeLabelF)+RCMargin;
    CGFloat  soureY = timeY;
    CGSize  soureLabelSize = [self.status.source boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:RCSoureFont]} context:nil].size;
    _soureLabelF = CGRectMake(soureX, soureY, soureLabelSize.width, soureLabelSize.height);
    
    
    //正文

    CGFloat  contentX = iconX;
    CGFloat  contentY = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_timeLabelF))+ RCMargin;
    CGSize  contentLabelSize = [status.attributedText boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2*contentX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    _contentLabelF = CGRectMake(contentX, contentY, contentLabelSize.width, contentLabelSize.height);
    CGFloat originalStastusViewH = 0;

    if (self.status.pic_urls.count) {  //有配图
        CGFloat  photosViewX = contentX;
        CGFloat  photosViewY = CGRectGetMaxY(_contentLabelF)+RCMargin;
        CGSize photosViewSize = [RCPhotosView sizeWithCount:status.pic_urls.count];
        _photosViewF = CGRectMake(photosViewX, photosViewY, photosViewSize.width, photosViewSize.height);
        originalStastusViewH = CGRectGetMaxY(_photosViewF) +RCMargin;
        
    }else {    //没有有配图
    
        originalStastusViewH = CGRectGetMaxY(_contentLabelF)+RCMargin;
    }
    
   //原始微博的View
    CGFloat originalStastusViewX = 0;
    CGFloat originalStastusViewY = 0;
    CGFloat originalStastusViewW = [UIScreen mainScreen].bounds.size.width - 4*originalStastusViewX;
    _originalStastusViewF = CGRectMake(originalStastusViewX, originalStastusViewY, originalStastusViewW,originalStastusViewH);
    
        CGFloat toolBarY = 0;
    CGFloat statusContentViewH= 0;
        CGFloat stastusViewH = 0;
    if (status.retweeted_status) {  //有转发微博
//        
        //转发微博的View
        CGFloat reweetedStatusViewX = 0;
        CGFloat reweetedStatusViewY = CGRectGetMaxY(_originalStastusViewF) + RCMargin;
        CGFloat reweetedStatusViewW = originalStastusViewW;
        CGFloat reweetedStatusViewH = 0;
//
//        //转发正文
        CGFloat reweetedContentLabelX = RCMargin;
        CGFloat reweetedContentLabelY = 0;
        CGFloat reweetedContentLabelW = reweetedStatusViewW- 2*RCMargin;
        CGSize  reweetedContentLabelSize = [status.retweetedAttributedText boundingRectWithSize:CGSizeMake(reweetedContentLabelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
//
        _retweetedContentLabelF = CGRectMake(reweetedContentLabelX, reweetedContentLabelY, reweetedContentLabelSize.width, reweetedContentLabelSize.height);
//
        //转发微博的配图
        if (status.retweeted_status.pic_urls.count) {
////            CGFloat retweetedPhotosViewH = 0;
            CGFloat retweetedPhotosViewX = reweetedContentLabelX;
            CGFloat retweetedPhotosViewY = CGRectGetMaxY(_retweetedContentLabelF) + RCMargin;
           CGSize retweetedPhotosViewSize = [RCPhotosView sizeWithCount:status.retweeted_status.pic_urls.count];
////            CGFloat retweetedPhotosViewW = originalStastusViewW;
            _retweetedPhotosViewF = CGRectMake(retweetedPhotosViewX, retweetedPhotosViewY, retweetedPhotosViewSize.width, retweetedPhotosViewSize.height);
//
            reweetedStatusViewH = CGRectGetMaxY(_retweetedPhotosViewF)+ RCMargin;
        }else{
        
            reweetedStatusViewH = CGRectGetMaxY(_retweetedContentLabelF)+ RCMargin;
   
        }
        
               _retweetedStatusViewF = CGRectMake(reweetedStatusViewX, reweetedStatusViewY, reweetedStatusViewW,reweetedStatusViewH);
        
          toolBarY = CGRectGetMaxY(_retweetedStatusViewF)+1;
        stastusViewH = CGRectGetMaxY(_retweetedStatusViewF);
    }else{  //没有转发微博
        toolBarY = CGRectGetMaxY(_originalStastusViewF)+1;
        stastusViewH = CGRectGetMaxY(_originalStastusViewF);

    }
    CGFloat stastusViewX = 0;
    CGFloat stastusViewY = 0;
    CGFloat stastusViewW = [UIScreen mainScreen].bounds.size.width - 4*originalStastusViewX;


    _statusViewF = CGRectMake(stastusViewX, stastusViewY, stastusViewW,stastusViewH);

    
    //工具条的view
    CGFloat toolBarX = originalStastusViewX;
    CGFloat toolBarW = originalStastusViewW;
    CGFloat toolBarH = 40;

    _toolBarF =  CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    statusContentViewH = CGRectGetMaxY(_toolBarF) +RCMargin*0.25;

    CGFloat statusContentViewX = 0;
    CGFloat statusContentViewY= 0;
    CGFloat statusContentViewW = [UIScreen mainScreen].bounds.size.width;
    
    //cell的View
    _statusContentViewF = CGRectMake(statusContentViewX, statusContentViewY, statusContentViewW, statusContentViewH);
    
    //cell的高度
    _cellHigth = CGRectGetMaxY(_statusContentViewF);
}

@end
