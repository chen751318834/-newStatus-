//
//  RCTopPopoverView.h
//  高仿微博
//
//  Created by Raychen on 15/4/18.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCTopPopoverView;
typedef enum{
   RCTopPopoverViewButtonTypeRefresh,
    RCTopPopoverViewButtonTypeSao
}RCTopPopoverViewButtonType;


@protocol RCTopPopoverViewDelegate <NSObject>

@optional
- (void)topPopoverView:(RCTopPopoverView *)popoverView didClickedButtonType:(RCTopPopoverViewButtonType)buttonType;

@end
@interface RCTopPopoverView : UIScrollView
@property(nonatomic,weak) id<RCTopPopoverViewDelegate> deleagte1;
@end
