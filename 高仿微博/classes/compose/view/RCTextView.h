//
//  RCTextView.h
//  高仿微博
//
//  Created by Raychen on 15/4/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCTextView : UITextView
/**
 *  占位文字
 */
@property(copy,nonatomic) NSString * placeHolder;
/**
 *  占位文字的颜色
 */
@property(strong,nonatomic) UIColor * placeHolderColor;



@end
