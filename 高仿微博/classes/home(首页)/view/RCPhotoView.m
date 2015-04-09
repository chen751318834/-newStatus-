//
//  RCPhotoView.m
//  高仿微博
//
//  Created by Raychen on 15/4/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPhotoView.h"
#import "UIImageView+WebCache.h"
@implementation RCPhotoView

- (void)setPhoto:(RCPhoto *)photo{
    _photo = photo;
    [self setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
 
}
@end
