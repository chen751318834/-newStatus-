//
//  RCSearchBar.m
//  高仿微博
//
//  Created by Raychen on 15/4/7.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSearchBar.h"
#import "UIView+Extension.h"


@interface RCSearchBar ()
@property(nonatomic,weak) UIImageView * imageView;
@property(nonatomic,weak) UILabel * label;
@end
@implementation RCSearchBar
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.backgroundColor = [UIColor redColor];
        imageView.image = [UIImage imageNamed:@"navigationbar_friendsearch"];
        self.imageView = imageView;
        self.rightView = imageView;
        
        UILabel * label = [[UILabel alloc]init];

        self.label = label;
        [self addSubview:label];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //占位文字
    CGFloat labelX = 30 ;
    CGFloat labelY = 0 ;
    CGFloat labelW = 200 ;
    CGFloat labelH = 44 ;
    self.label.x = labelX;
    self.label.y = labelY;
    self.label.width = labelW;
    self.label.height = labelH;
   
    //左边的图片
    CGFloat imageViewX = 0 ;
    CGFloat imageViewY = (self.height - self.imageView.height)*0.2 ;
    CGFloat imageViewW = 30 ;
    CGFloat imageViewH = 30 ;
    self.imageView.x = imageViewX;
    self.imageView.y = imageViewY;
    self.imageView.width = imageViewW;
    self.imageView.height = imageViewH;

}

- (void)setPlaceHodler:(NSString *)placeHodler{
    
    _placeHodler =  [placeHodler copy];
    self.label.text = placeHodler;
    
    
}
- (void)setColor:(UIColor *)color{
    _color = color;
    self.label.textColor = color;
    
}
@end
