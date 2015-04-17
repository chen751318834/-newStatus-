//
//  RCToolBar.h
//  高仿微博
//
//  Created by Raychen on 15/4/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCStatus.h"
@class RCToolBar;
typedef enum{
    RCToolBarButtonTypeTransmit , //转发
    RCToolBarButtonTypeEvaluate, //评价
    RCToolBarButtonTypeCommend, //赞
}RCToolBarButtonType;

@interface RCToolBar : UIView
@property(strong,nonatomic) RCStatus * status;

@end
