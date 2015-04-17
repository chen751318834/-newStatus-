//
//  RCCollectionViewCell.m
//  高仿微博
//
//  Created by Raychen on 15/4/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCCollectionViewCell.h"
@interface RCCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
@implementation RCCollectionViewCell
- (void)setNews:(RCNews *)news{
    _news = news;
    self.imageView.image = [UIImage imageNamed:news.icon];
    self.label.text = news.title;
    
    
}
@end
