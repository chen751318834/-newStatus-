//
//  RCComposeFirstView.h
//  高仿微博
//
//  Created by Raychen on 15/4/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCComposeFirstCenterView;
typedef enum {
    RCComposeFirstCenterViewButtonTypeText,  //文字
    RCComposeFirstCenterViewButtonTypePhotoLibary,  // 相册
    RCComposeFirstCenterViewButtonTypeShoot,  // 拍摄
    RCComposeFirstCenterViewButtonTypeSignIn,  // 签到
    RCComposeFirstCenterViewButtonTypeComment,  // 点评
    RCComposeFirstCenterViewButtonTypeMore,  // 更多
}RCComposeFirstCenterViewButtonType;

@protocol RCComposeFirstCenterViewDelegate <NSObject>

@optional
- (void)composeFirstCenterView:(RCComposeFirstCenterView *)composeFirstCenterView didClickedButtonWithButonType:(RCComposeFirstCenterViewButtonType)buttonType;

@end
@interface RCComposeFirstCenterView : UIView
@property(nonatomic,weak) id<RCComposeFirstCenterViewDelegate>  delegate;
@end
