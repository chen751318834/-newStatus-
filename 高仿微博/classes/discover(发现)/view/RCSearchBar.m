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
@property(nonatomic,weak) UILabel * label;
@end
@implementation RCSearchBar
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:13];
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 0)];
        imageView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        imageView.contentMode = UIViewContentModeCenter;
        self.leftView = imageView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.returnKeyType = UIReturnKeySearch;
    }
    return self;
}
+ (RCSearchBar *)searchBar{
    return [[self alloc]init ];
}


@end
