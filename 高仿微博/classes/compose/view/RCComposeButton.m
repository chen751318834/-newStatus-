//
//  RCComposeButton.m
//  高仿微博
//
//  Created by Raychen on 15/4/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCComposeButton.h"

@implementation RCComposeButton
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeCenter;
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.contentMode = UIViewContentModeCenter;
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
//        self.titleLabel.backgroundColor = [UIColor yellowColor];
//        self.showsTouchWhenHighlighted = YES;
    }
    
    return self;
    
    
}
- (void)setTitle:(NSString *)title{
    _title = [title copy];
    [self setTitle:title forState:UIControlStateNormal];
}
- (void)setImage:(UIImage *)image{
    _image = image;
    [self setImage:image forState:UIControlStateNormal];
//    [self setImage:image forState:UIControlStateHighlighted];

}
- (void)layoutSubviews{
    [super layoutSubviews];
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat X = 0 ;
    CGFloat Y = 0 ;
    CGFloat W = self.bounds.size.width ;
    CGFloat H = self.bounds.size.height*0.7 ;

    return CGRectMake(X, Y, W, H);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat X =( self.bounds.size.width  - [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.width)*0.5;
    CGFloat Y = self.bounds.size.height*0.7 ;
    CGFloat W = self.bounds.size.width ;
    CGFloat H = self.bounds.size.height*0.3 ;
    
    return CGRectMake(X, Y, W, H);

}
@end
