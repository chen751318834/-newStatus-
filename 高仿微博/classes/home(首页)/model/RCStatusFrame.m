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
static const CGFloat RCMargin = 5;

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

    CGSize  userNameLabelSize = [self.status.user.screen_name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:RCUserNameFont]} context:nil].size;
    _userNameLabelF = CGRectMake(userNameX, userNameY, userNameLabelSize.width, userNameLabelSize.height);
     //Vip
    CGFloat vipX = CGRectGetMaxX(_userNameLabelF)+RCMargin;
    CGFloat vipY = userNameX;
    CGFloat vipW = 10;
    CGFloat vipH = 10;
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
    CGSize  contentLabelSize = [self.status.text boundingRectWithSize:CGSizeMake( [UIScreen mainScreen].bounds.size.width - 4*contentX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:RCUContentFont]} context:nil].size;
    _contentLabelF = CGRectMake(contentX, contentY, contentLabelSize.width, contentLabelSize.height);
    CGFloat originalStastusViewH = 0;

    if (self.status.pic_ids.count) {  //有配图
        CGFloat  photosViewX = contentX;
        CGFloat  photosViewY = CGRectGetMaxY(_contentLabelF)+RCMargin;
        CGSize photosViewSize = [RCPhotosView sizeWithCount:status.pic_ids.count];
        _photosViewF = CGRectMake(photosViewX, photosViewY, photosViewSize.width, photosViewSize.height);
        originalStastusViewH = CGRectGetMaxY(_photosViewF) +RCMargin;
        
    }else {    //没有有配图
    
        originalStastusViewH = CGRectGetMaxY(_contentLabelF)+RCMargin;
    }
    
   //原始微博的View
    CGFloat originalStastusViewX = iconX;
    CGFloat originalStastusViewY = iconY;
    CGFloat originalStastusViewW = [UIScreen mainScreen].bounds.size.width - 2*RCMargin;
    _originalStastusViewF = CGRectMake(originalStastusViewX, originalStastusViewY, originalStastusViewW,originalStastusViewH);
    
        CGFloat toolBarY = CGRectGetMaxY(_originalStastusViewF)+RCMargin;
    if (status.retweeted_status) {  //有转发微博
        
        toolBarY = CGRectGetMaxY(_retweetedStatusViewF)+RCMargin;
        
        
        //转发微博的View
        CGFloat reweetedStatusViewH = 0;
        CGFloat reweetedStatusViewX = originalStastusViewX;
        CGFloat reweetedStatusViewY = CGRectGetMaxY(_originalStastusViewF) + RCMargin;
        CGFloat reweetedStatusViewW = originalStastusViewW;
      
        //转发正文
        CGFloat reweetedContentLabelX = RCMargin;
        CGFloat reweetedContentLabelY = RCMargin;
        CGFloat reweetedContentLabelW = reweetedStatusViewW;
        CGSize  contentLabelSize = [self.status.text boundingRectWithSize:CGSizeMake( reweetedContentLabelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:RCReweetedStatusContentFont]} context:nil].size;

        _retweetedContentLabelF = CGRectMake(reweetedContentLabelX, reweetedContentLabelY, contentLabelSize.width, contentLabelSize.height);
        
        //转发微博的配图
        if (status.retweeted_status.pic_ids.count) {
//            CGFloat retweetedPhotosViewH = 0;
            CGFloat retweetedPhotosViewX = originalStastusViewX;
            CGFloat retweetedPhotosViewY = CGRectGetMaxY(_originalStastusViewF) + RCMargin;
           CGSize retweetedPhotosViewSize = [RCPhotosView sizeWithCount:status.retweeted_status.pic_ids.count];
//            CGFloat retweetedPhotosViewW = originalStastusViewW;
            _retweetedPhotosViewF = CGRectMake(retweetedPhotosViewX, retweetedPhotosViewY, retweetedPhotosViewSize.width, retweetedPhotosViewSize.height);
            
            reweetedStatusViewH = CGRectGetMaxY(_retweetedPhotosViewF)+ RCMargin;
        }else{
        
            reweetedStatusViewH = CGRectGetMaxY(_retweetedContentLabelF)+ RCMargin;

        
        }
        
               _retweetedStatusViewF = CGRectMake(reweetedStatusViewX, reweetedStatusViewY, reweetedStatusViewW,reweetedStatusViewH);
        
        //cell的View
        _statusContentViewF = _retweetedStatusViewF;
    }else{  //没有转发微博
        
        
        //cell的View
        _statusContentViewF = _originalStastusViewF;
    }

    
    //工具条的view
    CGFloat toolBarX = originalStastusViewX;
    CGFloat toolBarW = originalStastusViewW;
    CGFloat toolBarH = 44;

    _toolBarF =  CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);


    //cell的高度
    _cellHigth = CGRectGetMaxY(_toolBarF)+ RCMargin;
}
@end
