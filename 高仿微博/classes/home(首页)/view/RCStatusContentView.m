//
//  RCStatusContentView.m
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCStatusContentView.h"
#import "RCOriginalStastusView.h"
#import "RCStatusFrame.h"
#import "RCRetweetedStatusView.h"
#import "RCToolBar.h"

@interface RCStatusContentView ()
/**
 *  原始微博的View
 */
@property(nonatomic,weak) RCOriginalStastusView * originalStastusView;
/**
 *  转发微博的View
 */
@property(nonatomic,weak) RCRetweetedStatusView * retweetedStatusView;
/**
 *  下面的工具条的View
 */
@property(nonatomic,weak) RCToolBar * toolBar;
@end
@implementation RCStatusContentView

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        //原始微博的View
        RCOriginalStastusView * originalStatusView = [[RCOriginalStastusView alloc]init];
        [self addSubview:originalStatusView];
        self.originalStastusView = originalStatusView;
        
        //原始微博的View
        RCRetweetedStatusView * retweetedStatusView = [[RCRetweetedStatusView alloc]init];
        [self addSubview:retweetedStatusView];
        self.retweetedStatusView = retweetedStatusView;

        
        //原始微博的View
        RCToolBar * toolBar = [[RCToolBar alloc]init];
        [self addSubview:toolBar];
        self.toolBar = toolBar;

        
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
    //原始微博
    self.originalStastusView.statusFrame = statusFrame;
    self.frame = statusFrame.statusContentViewF;
    if (statusFrame.status.retweeted_status) {
        //转发微博
        self.retweetedStatusView.statusFrame = statusFrame;
        self.retweetedStatusView.hidden = NO;
    }else{
        self.retweetedStatusView.hidden = YES;

    }
   
    //工具条
    self.toolBar.status = statusFrame.status;
    self.toolBar.frame =  statusFrame.toolBarF;
    }
@end
