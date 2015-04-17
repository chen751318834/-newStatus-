//
//  RCDetailStatusTopView.h
//  高仿微博
//
//  Created by Raychen on 15/4/16.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCStatus.h"
@class RCDetailStatusTopView;
typedef enum{
    RCDetailStatusTopViewButtonTypeTransmit , //转发
    RCDetailStatusTopViewButtonTypeEvaluate, //赞
    RCDetailStatusTopViewButtonTypeCommend,  //评价
}RCDetailStatusTopViewButtonType;

@protocol  RCDetailStatusTopViewDelegate <NSObject>
@optional
- (void)detailStatusTopView:(RCDetailStatusTopView *)topView didClickedButtonType:(RCDetailStatusTopViewButtonType)buttonType;
@end
@interface RCDetailStatusTopView : UIView

@property(nonatomic,weak) id<RCDetailStatusTopViewDelegate> delegate;
@property(strong,nonatomic) RCStatus * status;
@property (nonatomic, assign)RCDetailStatusTopViewButtonType selectedButtonType;

@end
