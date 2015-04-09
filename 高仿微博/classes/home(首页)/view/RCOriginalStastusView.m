//
//  RCOriginalStastusView.m
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCOriginalStastusView.h"
#import "RCStatusFrame.h"
#import "RCStatus.h"
#import "RCUser.h"
#import "RCPhotosView.h"
#import "UIImageView+WebCache.h"
#import "RCIconView.h"
@interface RCOriginalStastusView ()
@property(nonatomic,weak) RCIconView * iconView;
@property(nonatomic,weak) UIImageView * vipView;


@property(nonatomic,weak) UILabel * userNameLabel;

@property(nonatomic,weak) UILabel * timeLabel;

@property(nonatomic,weak) UILabel * soureLabel;

@property(nonatomic,weak) UILabel * contentLabel;
@property(nonatomic,weak) RCPhotosView * photosView;
@end
@implementation RCOriginalStastusView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        //头像
        RCIconView *iconView = [[RCIconView alloc]init];
        [self addSubview:iconView];
        self.iconView = iconView;
        iconView.backgroundColor = [UIColor redColor];
        //用户名
        UILabel *userNameLabel = [[UILabel alloc]init];
        [self addSubview:userNameLabel];
        self.userNameLabel.textColor = [UIColor blackColor];
        userNameLabel.font = [UIFont systemFontOfSize:RCUserNameFont];

        self.userNameLabel = userNameLabel;
        //时间
        UILabel *timeLabel = [[UILabel alloc]init];
        [self addSubview:timeLabel];
        timeLabel.font = [UIFont systemFontOfSize:RCTimeFont];

        self.timeLabel = timeLabel;
        //来源
        UILabel *soureLabel = [[UILabel alloc]init];
        [self addSubview:soureLabel];
        soureLabel.font = [UIFont systemFontOfSize:RCSoureFont];
        self.soureLabel = soureLabel;
        
        //Vip
        UIImageView *vipView = [[UIImageView alloc]init];
        [self addSubview:vipView];
        self.vipView = vipView;
        //正文
        UILabel *contentLabel = [[UILabel alloc]init];
        [self addSubview:contentLabel];
        contentLabel.font = [UIFont systemFontOfSize:RCUContentFont];
        contentLabel.numberOfLines = 0;
        self.contentLabel = contentLabel;
        
        //配图
        RCPhotosView * photosView = [[RCPhotosView alloc]init];
        photosView.backgroundColor = [UIColor redColor];
        [self addSubview:photosView];
        self.photosView = photosView;

        
        
    }
    
    return self;
    
    
}
/**
 *  设置数据，传递Frame
 *
 *  @param statusFrame <#statusFrame description#>
 */
- (void)setStatusFrame:(RCStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
   //设置数据
    RCStatus * status = statusFrame.status;
    RCUser * user = status.user;
    
    self.frame = statusFrame.originalStastusViewF;

    //头像
    self.iconView.frame = statusFrame.iconViewF;
    self.iconView.user = user;
    //用户名
    self.userNameLabel.frame = statusFrame.userNameLabelF;
    self.userNameLabel.text = user.screen_name;
//    self.userNameLabel.backgroundColor = [UIColor redColor];
    //vip
    self.vipView.frame = statusFrame.vipViewF;
    if (user.isVip) {
        self.vipView.hidden = NO;
        NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.image = [UIImage imageNamed:imageName];
        
        self.userNameLabel.textColor = [UIColor orangeColor];
    }else{
        self.vipView.hidden = YES;
        self.userNameLabel.textColor = [UIColor blackColor];

    }
    
    
    //微博发送的时间
    self.timeLabel.frame = statusFrame.timeLabelF;
    self.timeLabel.text = status.created_at;
    self.timeLabel.textColor = [UIColor orangeColor];
//    self.timeLabel.backgroundColor = [UIColor blueColor];

    //微博来源
    self.soureLabel.frame = statusFrame.soureLabelF;
    self.soureLabel.text = status.source;
//    self.soureLabel.backgroundColor = [UIColor blackColor];

    //微博正文
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = status.text;
//     self.contentLabel.backgroundColor = [UIColor redColor];
     //vip
    //配图
    if (status.pic_ids.count) {
        self.photosView.frame = statusFrame.photosViewF;
        self.photosView.hidden = NO;
        self.photosView.photos = status.pic_ids;
        NSLog(@"%@",status.pic_ids);
    }else{
        self.photosView.hidden = YES;
    }
    NSLog(@"===============%@",status.pic_ids);

}
@end
