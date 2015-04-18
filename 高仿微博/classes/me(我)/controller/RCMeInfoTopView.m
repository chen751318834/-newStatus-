//
//  RCMeInfoTopView.m
//  高仿微博
//
//  Created by Raychen on 15/4/18.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCMeInfoTopView.h"
#import "RCUserTool.h"
#import "RCUser.h"
#import "UIImageView+WebCache.h"
#import "UIImage+RC.h"
@interface RCMeInfoTopView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *followerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vip1View;
@property (weak, nonatomic) IBOutlet UIImageView *vip2View;

@end
@implementation RCMeInfoTopView

- (void)awakeFromNib{

    RCUser * user = [RCUserTool user];
   

    [self.iconView setImageWithURL:[NSURL URLWithString:user.avatar_large] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
     self.iconView.image =   [self circleImage:image borderWidth:0 borderColor:nil];
    }];
    self.nameLabel.text = user.name;
    self.likeLabel.text = [NSString stringWithFormat:@"关注 %d",user.friends_count];
    self.followerLabel.text = [NSString stringWithFormat:@"粉丝 %d",user.followers_count];
    self.vip1View.image = [UIImage imageNamed:@"avatar_vip"];
    self.vip2View.image = [UIImage imageNamed:@"avatar_grassroot"];
}
+ (RCMeInfoTopView *)topView{
    return [[[NSBundle mainBundle]loadNibNamed:@"RCMeInfoTopView" owner:nil options:nil]lastObject];
}

- (UIImage *)circleImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    // 2.开启上下文
    CGFloat imageW = image.size.width + 2 * borderWidth;
    CGFloat imageH = image.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [image drawInRect:CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
