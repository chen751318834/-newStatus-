
//
//  RCSendStatusPhotoView.m
//  高仿微博
//
//  Created by Raychen on 15/4/11.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSendStatusPhotoView.h"
#import "UIView+Extension.h"
@implementation RCSendStatusPhotoView
- (void)setPhoto:(UIImage *)photo{
    _photo = photo;
    UIImageView * imageView = [[UIImageView alloc]initWithImage:photo];
    
    [self addSubview:imageView];
    
    }
- (void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    int maxCol = 3;
    NSUInteger photoMargin = 10;
    CGFloat RCStatusPhotoWH = (self.bounds.size.width - (maxCol +1)*photoMargin)/maxCol;
    for (int i = 0; i<count; i++) {
        UIImageView  * imageView = self.subviews[i];
        
        int col = i % maxCol;
        imageView.x = col * (RCStatusPhotoWH + photoMargin)+photoMargin;
        
        int row = i / maxCol;
        imageView.y = row * (RCStatusPhotoWH + photoMargin) +photoMargin;
        imageView.width = RCStatusPhotoWH;
        imageView.height = RCStatusPhotoWH;
    }
}
@end
