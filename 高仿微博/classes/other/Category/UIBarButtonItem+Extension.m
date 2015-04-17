//
//  UIBarButtonItem+Extension.m
//  高仿微博
//
//  Created by Raychen on 15/4/7.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImage:(NSString *)image higthligthImage:(NSString *)higthligthImage targrt:(id)target action:(SEL)action{
    UIButton * button = [[UIButton alloc ]init];
    button.contentMode = UIViewContentModeCenter;
//    button.backgroundColor = [UIColor redColor];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:higthligthImage] forState:UIControlStateHighlighted];
     button.frame = CGRectMake(0, 0, button.currentImage.size.width, button.currentImage.size.height);
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button ];
    
    return item;
}


@end

