//
//  RCDetailStatusToolBar.h
//  高仿微博
//
//  Created by Raychen on 15/4/16.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCDetailStatusToolBar;
typedef enum{
   RCDetailStatusToolBarButtonTypeTransmit , //转发
   RCDetailStatusToolBarButtonTypeEvaluate, //评价
    RCDetailStatusToolBarButtonTypeCommend, //赞
}RCDetailStatusToolBarButtonType;


@protocol  RCDetailStatusToolBarDelegate <NSObject>

@optional

- (void)detailStatusToolBar:(RCDetailStatusToolBar *)toolBar didClickedButtonType:(RCDetailStatusToolBarButtonType)buttonType;
@end
@interface RCDetailStatusToolBar : UIView
@property(nonatomic,weak) id<RCDetailStatusToolBarDelegate> delegate;
@end
