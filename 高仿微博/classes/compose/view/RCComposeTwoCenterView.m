//
//  RCComposeTwoCenterView.m
//  高仿微博
//
//  Created by Raychen on 15/4/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCComposeTwoCenterView.h"
#import "RCComposeButton.h"
#import "UIView+Extension.h"
#define RCStatusPhotoMaxCol 3

static const CGFloat RCStatusPhotoMargin = 10;
@implementation RCComposeTwoCenterView
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
  

                [self setUpButtonWithTitle:@"好友圈" image:@"tabbar_compose_envelope" buttonType:RCComposeTwoCenterViewButtonTypeFriends];
                  [self setUpButtonWithTitle:@"秒拍" image:@"tabbar_compose_shooting" buttonType:RCComposeTwoCenterViewButtonTypeMiaoPai];
                [self setUpButtonWithTitle:@"音乐" image:@"tabbar_compose_music" buttonType:RCComposeTwoCenterViewButtonTypeMusic];
        
                [self setUpButtonWithTitle:@"收款" image:@"tabbar_compose_transfer" buttonType:RCComposeTwoCenterViewButtonTypePay];
                [self setUpButtonWithTitle:@"长微博" image:@"tabbar_compose_weibo" buttonType:RCComposeTwoCenterViewButtonTypeLongStatus];
        
    }
    
    return self;
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger composeButtonCount = self.subviews.count;
    int maxCol = RCStatusPhotoMaxCol;
    CGFloat RCStatusPhotoWH = self.bounds.size.width/4;
    for (int i = 0; i<composeButtonCount; i++) {
        RCComposeButton * composeButton = self.subviews[i];
        
        int col = i % maxCol;
        composeButton.x = col * (RCStatusPhotoWH + RCStatusPhotoMargin);
        
        int row = i / maxCol;
        composeButton.y = row * (RCStatusPhotoWH + RCStatusPhotoMargin);
        composeButton.width = RCStatusPhotoWH;
        composeButton.height = RCStatusPhotoWH;
    }
    
}

- (void)setUpButtonWithTitle:(NSString *)title image:(NSString *)image buttonType:(RCComposeTwoCenterViewButtonType)buttonType{
    RCComposeButton * button = [[RCComposeButton alloc]init];
    button.tag = buttonType;
    button.title = title;
    [button setFont:[UIFont systemFontOfSize:14]];
    button.image = [UIImage imageNamed:image];
    [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
}
- (void)buttonDidClicked:(RCComposeButton *)button{
    if ([self.delegate respondsToSelector:@selector(composeTwoCenterView:didClickedButtonWithButonType:)]) {
        [self.delegate composeTwoCenterView:self didClickedButtonWithButonType:button.tag];
    }
    
}
@end
