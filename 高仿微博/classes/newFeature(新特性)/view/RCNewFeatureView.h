//
//  RCNewFeatureView.h
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCNewFeatureView;
@protocol RCNewFeatureViewDelegate <NSObject>

@optional
- (void)newFeatureViewDidEnterAppButton:(RCNewFeatureView *)newFeatureView;
- (void)newFeatureViewDidShareButton:(RCNewFeatureView *)newFeatureView;
@end


@interface RCNewFeatureView : UIView
@property(nonatomic,weak) id<RCNewFeatureViewDelegate> delegate;
@end
