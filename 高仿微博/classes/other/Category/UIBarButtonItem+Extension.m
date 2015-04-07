//
//  UIBarButtonItem+Extension.m
//  高仿微博
//
//  Created by Raychen on 15/4/7.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImage:(NSString *)image higthligthImage:(NSString *)higthligthImage{
    UIButton * button = [[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:higthligthImage] forState:UIControlStateHighlighted];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button ];
    
    return item;
}


@end

