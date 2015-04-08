//
//  RCNewFeatureView.m
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCNewFeatureView.h"
static const NSUInteger imageCount = 4;
@interface RCNewFeatureView () <UIScrollViewDelegate>
@property(nonatomic,weak) UIScrollView * scrollView;
@property(nonatomic,weak) UIPageControl * control;
@property(strong,nonatomic) NSMutableArray * images;
@property(nonatomic,weak) UIButton * selectedShareButton;

@end
@implementation RCNewFeatureView
-(NSArray *)images{
    if (!_images) {
        self.images =[NSMutableArray array];
    }
    return _images;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        //添加scrollview
        UIScrollView * scrollView = [[UIScrollView alloc]init];
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
//        scrollView.backgroundColor = [UIColor redColor];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;

        //添加图片
        for (int i=0; i<imageCount; i++) {
            UIImageView * imageView = [[UIImageView alloc]init];
            imageView.userInteractionEnabled = YES;
          NSString *  iamgeName = [NSString stringWithFormat:@"new_feature_%d",i+1];
            imageView.image = [UIImage imageNamed:iamgeName];
            [self.scrollView addSubview:imageView];
            [self.images addObject:imageView];

        }
        //添加control
        UIPageControl * control = [[UIPageControl alloc]init];
        control.numberOfPages = imageCount;
        control.pageIndicatorTintColor = [UIColor grayColor];
        control.currentPageIndicatorTintColor = [UIColor orangeColor];
        self.control = control;
        [self addSubview:control];
        
       
           }
    
    return self;
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat imageViewY = 0;
    CGFloat imageViewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat imageViewH = [UIScreen mainScreen].bounds.size.height;
    
    self.scrollView.frame = CGRectMake(0, 0,imageViewW,imageViewH);
    
    NSUInteger count = self.images.count;
 
    for (int i=0; i<count; i++) {
        UIImageView * imageView = self.images[i];
        CGFloat imageViewX = i*imageViewW;
        
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
        //在最后的一张图片上添加控件
        if (i == 3) {
            //分享按钮
            [self initShareButton:imageView];
            //进入应用按钮
            [self initEnterButton:imageView];
          
        }
    }
    self.scrollView.contentSize = CGSizeMake(imageViewW *imageCount , imageViewH);
    
    //pageConrtrol
    CGFloat  controlW = 100;
    CGFloat  controlH = 20;
    CGFloat contronX = (imageViewW - controlW )*0.5;
    CGFloat controlY = imageViewH - controlH - 40;
    self.control.frame = CGRectMake(contronX, controlY, controlW, controlH);
    NSLog(@"%@",self.scrollView.subviews);
}
#pragma mark - scrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int currentP = (int)( scrollView.contentOffset.x/scrollView.bounds.size.width+0.5);
    self.control.currentPage =currentP;

}
/**
 *  添加分享按钮
 *
 */
- (void)initShareButton:(UIImageView *)imageView{
    UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageView addSubview:shareButton];
    [shareButton addTarget:self action:@selector(shareButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setTitle:@"分享到微博" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor colorWithRed:0.049 green:0.190 blue:0.256 alpha:1.000] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true" ] forState:UIControlStateSelected];
   
    //点击进入按钮
    [imageView addSubview: shareButton];
    CGFloat W = 200 ;
    CGFloat H = 40;
    CGFloat X = (self.frame.size.width - W)*0.5 ;
    CGFloat Y = self.bounds.size.height - 200 ;
    
    
    shareButton.frame = CGRectMake(X, Y, W, H);
}
/**
 *  添加进入应用按钮
 *
 */
- (void)initEnterButton:(UIImageView *)imageView{
    UIButton * enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageView addSubview:enterButton];
    //    shareButton.frame = [];
    //点击进入按钮
    [imageView addSubview: enterButton];
    [enterButton setTitle:@"点击进入" forState:UIControlStateNormal];
       [enterButton setTitleColor:[UIColor colorWithRed:0.049 green:0.190 blue:0.256 alpha:1.000] forState:UIControlStateNormal];
      [enterButton setTitleColor:[UIColor colorWithRed:0.049 green:0.499 blue:0.256 alpha:1.000] forState:UIControlStateHighlighted];
    [enterButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [enterButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [enterButton addTarget:self action:@selector(enterButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat W = 100 ;
    CGFloat H = 40;
    CGFloat X = (self.frame.size.width - W)*0.5 ;
    CGFloat Y = self.bounds.size.height - 150 ;
    
    enterButton.frame = CGRectMake(X, Y, W, H);
}
#pragma mark - 点击事件
/**
 *  点击分享按钮
 */
- (void)shareButtonDidClicked:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(newFeatureViewDidShareButton:)]) {
        [self.delegate newFeatureViewDidShareButton:self];
    }
//    self.selectedShareButton.selected = NO;
//    button.selected = YES;
//    self.selectedShareButton = button;
    button.selected = !button.isSelected;

}
- (void)enterButtonDidClicked{

    if ([self.delegate respondsToSelector:@selector(newFeatureViewDidEnterAppButton:)]) {
        [self.delegate newFeatureViewDidEnterAppButton:self];
    }

}
@end
