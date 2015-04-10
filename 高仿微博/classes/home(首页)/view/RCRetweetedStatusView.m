//
//  RCRetweetedStatusView.m
//  高仿微博
//
//  Created by Raychen on 15/4/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCRetweetedStatusView.h"
#import "RCPhotosView.h"


@interface RCRetweetedStatusView ()
/**
 * 正文
 */
@property(nonatomic,weak) UILabel * retweetedContentLabel;
/**
 *  配图
 */
@property(nonatomic,weak) RCPhotosView * retweetedPhotosView;
@end
@implementation RCRetweetedStatusView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor colorWithWhite:0.929 alpha:1.000];
//        self.backgroundColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.519 alpha:1.000];
         //正文
        UILabel * retweetedContentLabel = [[UILabel alloc]init];
        retweetedContentLabel.font = [UIFont systemFontOfSize:RCReweetedStatusContentFont];
        retweetedContentLabel.numberOfLines = 0;
        [self addSubview:retweetedContentLabel];
//        retweetedContentLabel.backgroundColor = [UIColor yellowColor];
        self.retweetedContentLabel = retweetedContentLabel;
        //配图
        RCPhotosView * retweetedPhotosView = [[RCPhotosView alloc]init];
        [self addSubview:retweetedPhotosView];
        self.retweetedPhotosView = retweetedPhotosView;
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
    self.frame = statusFrame.retweetedStatusViewF;
    
    RCStatus * status = statusFrame.status;
//    RCUser * user = status.user;
    
    //正文
    self.retweetedContentLabel.frame = statusFrame.retweetedContentLabelF;

         self.retweetedContentLabel.text = [NSString stringWithFormat:@"@%@:%@",status.retweeted_status.user.name,status.retweeted_status.text];

   
    //配图
    self.retweetedPhotosView.frame = statusFrame.retweetedPhotosViewF;
    if (status.retweeted_status.pic_urls.count) {  //有配图
        
        self.retweetedPhotosView.hidden = NO;
        self.retweetedPhotosView.photos = status.retweeted_status.pic_urls;
    }else{
        self.retweetedPhotosView.hidden = YES;

    
    }
}
@end
