//
//  RCStatusView.m
//  高仿微博
//
//  Created by Raychen on 15/4/16.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCStatusView.h"
#import "RCOriginalStastusView.h"
#import "RCRetweetedStatusView.h"

@interface RCStatusView ()
/**
 *  原始微博的View
 */
@property(nonatomic,weak) RCOriginalStastusView * originalStastusView;
/**
 *  转发微博的View
 */
@property(nonatomic,weak) RCRetweetedStatusView * retweetedStatusView;
@end
@implementation RCStatusView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor yellowColor];
        //原始微博的View
        RCOriginalStastusView * originalStatusView = [[RCOriginalStastusView alloc]init];
        [self addSubview:originalStatusView];
//                originalStatusView.backgroundColor = [UIColor redColor];
        self.originalStastusView = originalStatusView;
        
        //转发微博的View
        RCRetweetedStatusView * retweetedStatusView = [[RCRetweetedStatusView alloc]init];
//                retweeted StatusView.backgroundColor = [UIColor greenColor];
        [self addSubview:retweetedStatusView];
        self.retweetedStatusView = retweetedStatusView;

    }
    
    return self;
    
    
}
/**
 *  设置数据，传递Frame
 */
- (void)setStatusFrame:(RCStatusFrame *)statusFrame{
    
    _statusFrame = statusFrame;
//    self.frame = statusFrame.statusContentViewF;
    self.frame = statusFrame.statusViewF;
    
    //原始微博
    
    self.originalStastusView.statusFrame = statusFrame;
    if (statusFrame.status.retweeted_status) {
        //转发微博
        self.retweetedStatusView.statusFrame = statusFrame;
        self.retweetedStatusView.hidden = NO;
    }else{
        self.retweetedStatusView.hidden = YES;
        
    }
    

}
@end
