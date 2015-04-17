//
//  RCPhotoView.m
//  高仿微博
//
//  Created by Raychen on 15/4/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPhotoView.h"
#import "UIImageView+WebCache.h"


@interface RCPhotoView ()
@property(nonatomic,weak) UIImageView * gifView;
@end
@implementation RCPhotoView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        UIImageView * gifView = [[UIImageView alloc]init];
        [self addSubview:gifView];
        [gifView setImage:[UIImage imageNamed:@"timeline_image_gif"]];
        // 内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.userInteractionEnabled = YES;
        // 超出UIImageView边界的内容, 都剪掉(不显示)
        self.clipsToBounds = YES;
        self.gifView = gifView;
    }
    
    return self;
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat W = 20;
    CGFloat H = 15;
    CGFloat X = self.bounds.size.width - W;
    CGFloat Y = self.bounds.size.height - H;
    self.gifView.frame = CGRectMake(X, Y, W, H);
}
- (void)setPhoto:(RCPhoto *)photo{
    _photo = photo;
    NSString * imageString = photo.thumbnail_pic;
    [self setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    if ([imageString hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;

    
    }
}
@end
