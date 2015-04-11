//
//  UIButton+Extension.m
//  高仿微博
//
//  Created by Raychen on 15/4/11.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

+ (UIButton *)buttonWithImage:(UIImage *)image hightlightImage:(UIImage *)hightlightImage disableImage:(UIImage *)disableImage selectedImage:(UIImage *)selectedImage{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:hightlightImage forState:UIControlStateHighlighted];
    [button setImage:disableImage forState:UIControlStateDisabled];
     [button setImage:selectedImage forState:UIControlStateSelected];
    return button;
}
+ (UIButton *)buttonWithImage:(UIImage *)image hightlightImage:(UIImage *)hightlightImage disableImage:(UIImage *)disableImage{
    return [self buttonWithImage:image hightlightImage:hightlightImage disableImage:disableImage selectedImage:nil];
}
+ (UIButton *)buttonWithImage:(UIImage *)image hightlightImage:(UIImage *)hightlightImage{
    return  [self buttonWithImage:image hightlightImage:hightlightImage disableImage:nil];
}


+ (UIButton *)buttonWithImage:(UIImage *)image hightlightImage:(UIImage *)hightlightImage  selectedImage:(UIImage *)selectedImage{
    return [self buttonWithImage:image hightlightImage:hightlightImage disableImage:nil selectedImage:selectedImage];

}
@end
