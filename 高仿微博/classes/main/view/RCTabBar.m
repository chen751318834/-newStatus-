//
//  RCTabBar.m
//  高仿微博
//
//  Created by Raychen on 15/4/7.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCTabBar.h"
#import "UIView+Extension.h"

@interface RCTabBar ()
@property(nonatomic,weak) UIButton * plusButton;
@end
@implementation RCTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        //创建加号按钮
        UIButton * plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        plusButton.backgroundColor = [UIColor redColor];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [self addSubview:plusButton];
        [plusButton addTarget:self action:@selector(plusBUttonClicked) forControlEvents:UIControlEventTouchUpInside];
        self.plusButton = plusButton;
    }
    
    return self;
    
    
}
- (void)plusBUttonClicked{
    
    if ([self.delegate respondsToSelector:@selector(tabBarDidPlusButton:)]) {
        [self.delegate tabBarDidPlusButton:self];
    }

}
- (void)layoutSubviews{
    [super layoutSubviews];
    //布局加号按钮
    [self layoutPlusButton];
    
    //布局所有的子控件
//        NSLog(@"%@", self.subviews );
     NSUInteger tabBarButtonIndex = 0;
     NSUInteger count = self.subviews.count;
     CGFloat childW = self.width/5;
    for (int i=0; i<count; i++) {
        UIView *childView = self.subviews[i];
        if ([childView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            NSLog(@"%@",childView);
            childView.width = childW;
            childView.x = childW*tabBarButtonIndex;
            tabBarButtonIndex ++;

            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex++;
            }
        }
    }

}
/**
 *  布局加号按钮
 */
- (void)layoutPlusButton{

    CGFloat plusBuutonW = 80;
    CGFloat plusBuutonH = 50;
    CGFloat plusBuutonX = (self.size.width - plusBuutonW) *0.5;
    CGFloat plusBuutonY = (self.size.height - plusBuutonH)*0.5;
    
    self.plusButton.width = plusBuutonW;
    self.plusButton.height = plusBuutonH;
    self.plusButton.x = plusBuutonX;
    self.plusButton.y = plusBuutonY;
}
@end
