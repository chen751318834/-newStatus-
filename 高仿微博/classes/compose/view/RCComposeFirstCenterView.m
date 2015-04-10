//
//  RCComposeFirstView.m
//  高仿微博
//
//  Created by Raychen on 15/4/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCComposeFirstCenterView.h"
#import "RCComposeButton.h"
#import "UIView+Extension.h"
#define RCStatusPhotoMaxCol 3

static const CGFloat RCStatusPhotoMargin = 10;
@implementation RCComposeFirstCenterView
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUpButtonWithTitle:@"文字" image:@"tabbar_compose_idea" buttonType:RCComposeFirstCenterViewButtonTypeText];
         [self setUpButtonWithTitle:@"相册" image:@"tabbar_compose_photo"buttonType:RCComposeFirstCenterViewButtonTypePhotoLibary];
        [self setUpButtonWithTitle:@"拍摄" image:@"tabbar_compose_shooting"buttonType:RCComposeFirstCenterViewButtonTypeShoot];
        [self setUpButtonWithTitle:@"签到" image:@"tabbar_compose_lbs"buttonType:RCComposeFirstCenterViewButtonTypeSignIn];
        [self setUpButtonWithTitle:@"点评" image:@"tabbar_compose_review"buttonType:RCComposeFirstCenterViewButtonTypeComment];
        [self setUpButtonWithTitle:@"更多" image:@"tabbar_compose_more"buttonType:RCComposeFirstCenterViewButtonTypeMore];

//        [self setUpButtonWithTitle:@"好友圈" image:@"tabbar_compose_envelope"];
//        [self setUpButtonWithTitle:@"音乐" image:@"tabbar_compose_music"];
//       
//        [self setUpButtonWithTitle:@"收款" image:@"tabbar_compose_transfer"];
//        [self setUpButtonWithTitle:@"长微博" image:@"tabbar_compose_weibo"];
//        [self setUpButtonWithTitle:@"秒拍" image:@"tabbar_compose_shooting"];
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

- (void)setUpButtonWithTitle:(NSString *)title image:(NSString *)image buttonType:(RCComposeFirstCenterViewButtonType)buttonType{
    RCComposeButton * button = [[RCComposeButton alloc]init];
    button.tag = buttonType;
    button.title = title;
    [button setFont:[UIFont systemFontOfSize:14]];
    button.image = [UIImage imageNamed:image];
    [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];

}
- (void)buttonDidClicked:(RCComposeButton *)button{
    if ([self.delegate respondsToSelector:@selector(composeFirstCenterView:didClickedButtonWithButonType:)]) {
        [self.delegate composeFirstCenterView:self didClickedButtonWithButonType:(int)button.tag];
    }

}
@end
