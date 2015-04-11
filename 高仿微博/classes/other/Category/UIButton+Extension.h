//
//  UIButton+Extension.h
//  高仿微博
//
//  Created by Raychen on 15/4/11.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)
+ (UIButton *)buttonWithImage:(UIImage *)image hightlightImage:(UIImage *)hightlightImage;
+ (UIButton *)buttonWithImage:(UIImage *)image hightlightImage:(UIImage *)hightlightImage disableImage:(UIImage *)disableImage ;
+ (UIButton *)buttonWithImage:(UIImage *)image hightlightImage:(UIImage *)hightlightImage disableImage:(UIImage *)disableImage selectedImage:(UIImage *)selectedImage;

+ (UIButton *)buttonWithImage:(UIImage *)image hightlightImage:(UIImage *)hightlightImage  selectedImage:(UIImage *)selectedImage;

@end
