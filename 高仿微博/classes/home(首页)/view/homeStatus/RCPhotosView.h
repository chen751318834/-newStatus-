//
//  RCPhotosView.h
//  高仿微博
//
//  Created by Raychen on 15/4/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCPhotosView : UIView
@property(strong,nonatomic) NSArray * photos;
+ (CGSize)sizeWithCount:(int)count;
@end
