//
//  RCComposeTwoCenterView.h
//  高仿微博
//
//  Created by Raychen on 15/4/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCComposeTwoCenterView;
typedef enum {
    RCComposeTwoCenterViewButtonTypeFriends,  //朋友圈
    RCComposeTwoCenterViewButtonTypeMiaoPai,  // 秒怕
    RCComposeTwoCenterViewButtonTypeMusic,  // 音乐
   RCComposeTwoCenterViewButtonTypeLongStatus,  // 长微博
    RCComposeTwoCenterViewButtonTypePay,  // 收款
}RCComposeTwoCenterViewButtonType;

@protocol RCComposeTwoCenterViewDelegate <NSObject>

@optional
- (void)composeTwoCenterView:(RCComposeTwoCenterView *)composeTwoCenterView didClickedButtonWithButonType:(RCComposeTwoCenterViewButtonType)buttonType;

@end
@interface RCComposeTwoCenterView : UIView

@property(nonatomic,weak) id<RCComposeTwoCenterViewDelegate>  delegate;

@end
