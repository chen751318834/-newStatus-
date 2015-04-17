//
//  RCDetailStatusToolBar.m
//  高仿微博
//
//  Created by Raychen on 15/4/16.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCDetailStatusToolBar.h"

@implementation RCDetailStatusToolBar
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        UIButton * button1 = [self setUpButtonWithImage:nil buttonType:nil];
        button1.userInteractionEnabled = NO;
        [self setUpButtonWithImage:@"statusdetail_icon_retweet" buttonType:RCDetailStatusToolBarButtonTypeTransmit];
        [self setUpButtonWithImage:@"statusdetail_icon_comment" buttonType:RCDetailStatusToolBarButtonTypeEvaluate];
        [self setUpButtonWithImage:@"statusdetail_icon_like" buttonType:RCDetailStatusToolBarButtonTypeCommend];
           UIButton * button2 =  [self setUpButtonWithImage:nil buttonType:nil];
        button2.userInteractionEnabled = NO;

    }
    
    return self;
    
    
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"statusdetail_comment_background_middle_highlighted"];
    [imageView drawRect:self.frame];

}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat buttonY = 0;
    CGFloat buttonW = self.bounds.size.width/5;
    CGFloat buttonH = self.bounds.size.height;
    for (int i=0; i<self.subviews.count; i++) {
        UIButton * button = self.subviews[i ];
        CGFloat buttonX = (buttonW)*i;
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }

}
- (UIButton *)setUpButtonWithImage:(NSString *)image buttonType:(RCDetailStatusToolBarButtonType )buttonType{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:button];
    button.tag = buttonType;
    button.imageView.contentMode = UIViewContentModeScaleToFill;
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:@"statusdetail_toolbar_button_background"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"statusdetail_toolbar_button_background_highlighted"]  forState:UIControlStateHighlighted];
    
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    return  button;
    
}
- (void)buttonDidClicked:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(detailStatusToolBar:didClickedButtonType:)]) {
        [self.delegate detailStatusToolBar:self didClickedButtonType:btn.tag];
    }

}
@end
