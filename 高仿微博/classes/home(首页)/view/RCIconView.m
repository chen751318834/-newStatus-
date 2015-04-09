//
//  RCIconView.m
//  高仿微博
//
//  Created by Raychen on 15/4/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCIconView.h"
#import "UIImageView+WebCache.h"


@interface RCIconView ()
@property(nonatomic,weak) UIImageView * vView;
@end
@implementation RCIconView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        UIImageView * vView = [[UIImageView alloc]init];
        [self addSubview:vView];
        self.vView = vView;
    }
    
    return self;
    
    
}
- (void)setUser:(RCUser *)user{
    _user = user;
    [self setImageWithURL:[NSURL URLWithString:user.avatar_large] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    if (user.verified) {  //加V用户
        [self.vView setImage:[UIImage imageNamed:@"avatar_enterprise_vip"]];
        self.vView.hidden = NO;
    }else{ //非加V用户
    
        self.vView.hidden = YES;
    
    }

}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat vViewW = self.image.size.width;
    CGFloat vViewH= self.image.size.height;
    CGFloat vViewX = self.bounds.size.width - vViewW;
    CGFloat vViewY = self.bounds.size.height - vViewH;;
    
    self.vView.frame = CGRectMake(vViewX, vViewY, vViewW, vViewH);
}
@end
