//
//  RCRetweetedStatusView.m
//  高仿微博
//
//  Created by Raychen on 15/4/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCRetweetedStatusView.h"
#import "RCPhotosView.h"
#import "RCStatusTextView.h"
#import "RCStatusDetailViewController.h"
@interface RCRetweetedStatusView ()
/**
 * 正文
 */
@property(nonatomic,weak) RCStatusTextView * retweetedContentLabel;
/**
 *  配图
 */
@property(nonatomic,weak) RCPhotosView * retweetedPhotosView;
@end
@implementation RCRetweetedStatusView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.929 alpha:1.000];
//        self.backgroundColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.519 alpha:1.000];
         //正文
        RCStatusTextView * retweetedContentLabel = [[RCStatusTextView alloc]init];
        retweetedContentLabel.font = [UIFont systemFontOfSize:RCReweetedStatusContentFont];
        [self addSubview:retweetedContentLabel];
        self.retweetedContentLabel = retweetedContentLabel;
        //配图
        RCPhotosView * retweetedPhotosView = [[RCPhotosView alloc]init];
        [self addSubview:retweetedPhotosView];
        self.retweetedPhotosView = retweetedPhotosView;
    }
    
    return self;
    
    
}
/**
 *  跳转转发微博的石头
 *
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan");
  UITabBarController * tabBarC =  (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
   UINavigationController * navC = (UINavigationController *) tabBarC.selectedViewController;
    RCStatusDetailViewController * detailC = [[RCStatusDetailViewController alloc]init];
//    CGRect reweetedViewF = self.statusFrame.retweetedStatusViewF;
    detailC.statusFrame = self.statusFrame;
    detailC.reweetedStatus = YES;

    [navC pushViewController:detailC animated:YES];
    

}
/**
 *  设置数据，传递Frame
 *
 */
- (void)setStatusFrame:(RCStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    self.frame = statusFrame.retweetedStatusViewF;
    
    RCStatus * status = statusFrame.status;
    
    //正文
    self.retweetedContentLabel.frame = statusFrame.retweetedContentLabelF;

    self.retweetedContentLabel.attributedText =status.retweetedAttributedText;

   
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
