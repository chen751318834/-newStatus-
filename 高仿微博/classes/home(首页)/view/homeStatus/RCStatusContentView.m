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
#import "RCStatusView.h"
@interface RCStatusContentView ()


/**
 *  下面的工具条的View
 */
@property(nonatomic,weak) RCToolBar * toolBar;
@property(nonatomic,weak) RCStatusView * statusView;
@end
@implementation RCStatusContentView

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.929 alpha:1.000];

        //原始微博的View
        RCStatusView * statusView = [[RCStatusView alloc]init];
        [self addSubview:statusView];
        
        self.statusView = statusView;
        
        //原始微博的View
        RCToolBar * toolBar = [[RCToolBar alloc]init];
        [self addSubview:toolBar];
//        self.backgroundColor = [UIColor redColor];
        self.toolBar = toolBar;

        
    }
    
    return self;
    
    
}
/**
 *  设置数据，传递Frame
 *
 */
- (void)setStatusFrame:(RCStatusFrame *)statusFrame{

         _statusFrame = statusFrame;
        self.frame = statusFrame.statusContentViewF;
    self.statusView.statusFrame = statusFrame;

   
    //工具条
    self.toolBar.status = statusFrame.status;
    self.toolBar.frame =  statusFrame.toolBarF;
    }
@end
