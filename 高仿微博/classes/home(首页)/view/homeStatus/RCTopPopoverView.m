//
//  RCTopPopoverView.m
//  高仿微博
//
//  Created by Raychen on 15/4/18.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCTopPopoverView.h"
#import "UIButton+Extension.h"
@implementation RCTopPopoverView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
//        [UIButton bu];
       UIButton * refreshButton = [self setUpButtonWithTitle:@"刷新  " image:@"navigationbar_pop_highlighted" buttonType:RCTopPopoverViewButtonTypeRefresh];
        refreshButton.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
                [self setUpButtonWithTitle:@" 扫一扫" image:@"navigationbar_pop_highlighted" buttonType:RCTopPopoverViewButtonTypeSao];
        self.contentSize = CGSizeMake(0, 100);

    }
    
    return self;
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat X = 0;

    CGFloat W  = self.bounds.size.width;
    CGFloat H = self.bounds.size.height/2;

    for (int i=0; i<self.subviews.count; i++) {
        UIButton * button = self.subviews[i ];
            CGFloat Y = i*H;
        button.frame = CGRectMake(X, Y, W, H);
    }
}
- (UIButton *)setUpButtonWithTitle:(NSString *)title image:(NSString *)image buttonType:(RCTopPopoverViewButtonType )buttonType{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = buttonType;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//    button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];

    [self addSubview:button];
    return  button;
    
}
- (void)buttonDidClicked:(UIButton *)button{

    if ([self.deleagte1 respondsToSelector:@selector(topPopoverView:didClickedButtonType:)]) {
        [self.deleagte1 topPopoverView:self didClickedButtonType:button.tag];
    }

}
@end
