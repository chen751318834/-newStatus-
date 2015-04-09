//
//  RCPhotosView.m
//  高仿微博
//
//  Created by Raychen on 15/4/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPhotosView.h"
#import "RCPhotoView.h"
#import "UIView+Extension.h"
#define RCStatusPhotoMaxCol(count) ((count==4)?2:3)
static const CGFloat RCStatusPhotoWH = 70;
static const CGFloat RCStatusPhotoMargin = 10;

@implementation RCPhotosView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
    }
    
    return self;
    
    
}
- (void)setPhotos:(NSArray *)photos{

    _photos = photos;
    NSUInteger photosCount = photos.count;
    
    
    // 创建足够数量的图片控件
    // 这里的self.subviews.count不要单独赋值给其他变量
    while (self.subviews.count < photosCount) {
        RCPhotoView *photoView = [[RCPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        RCPhotoView *photoView = self.subviews[i];
        
        if (i < photosCount) { // 显示
            photoView.photo = photos[i];
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
         NSUInteger photosCount = self.subviews.count;
        int maxCol = RCStatusPhotoMaxCol(photosCount);
        for (int i = 0; i<photosCount; i++) {
            RCPhotosView * photoView = self.subviews[i];
            
            int col = i % maxCol;
            photoView.x = col * (RCStatusPhotoWH + RCStatusPhotoMargin);
            
            int row = i / maxCol;
            photoView.y = row * (RCStatusPhotoWH + RCStatusPhotoMargin);
            photoView.width = RCStatusPhotoWH;
            photoView.height = RCStatusPhotoWH;
        }
    
}
+ (CGSize)sizeWithCount:(int)count
{
    // 最大列数（一行最多有多少列）
    NSUInteger maxCols = RCStatusPhotoMaxCol(count);
    
    ///Users/apple/Desktop/课堂共享/05-iPhone项目/1018/代码/黑马微博2期35-相册/黑马微博2期/Classes/Home(首页)/View/HWStatusPhotosView.m 列数
    NSUInteger cols = (count >= maxCols)? maxCols : count;
    CGFloat photosW = cols * RCStatusPhotoWH + (cols - 1) * RCStatusPhotoMargin;
    
    // 行数
    NSUInteger rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * RCStatusPhotoWH + (rows - 1) * RCStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}
@end
