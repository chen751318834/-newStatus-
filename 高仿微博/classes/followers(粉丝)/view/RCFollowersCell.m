//
//  RCFollowersCell.m
//  高仿微博
//
//  Created by Raychen on 15/4/17.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCFollowersCell.h"
#import "UIImageView+WebCache.h"
#import "RCStatus.h"



@interface RCFollowersCell ()
@property(nonatomic,weak) UIButton * rightButton;
@end
@implementation RCFollowersCell

+ (RCFollowersCell *)cellWithTableView:(UITableView *)tableView{
    static NSString * ID =@"followers";
    RCFollowersCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell =[[RCFollowersCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                     reuseIdentifier:ID];
    
        
    
    
    }
    return cell;


}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIButton * rigthButton = [self setUpRigthButtonWithImage:@"statusdetail_comment_icon_like_highlighted" selectedImage:@"statusdetail_comment_icon_like_highlighted"];
        self.rightButton = rigthButton;
        self.accessoryView = self.rightButton;
        [self.detailTextLabel setTextColor:[UIColor grayColor]];
        NSLog(@"initWithStyle=====%@",self.accessoryView);

    }
    
    return  self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat W  = 44;
    CGFloat H = W;
    CGFloat X = self.frame.size.width -44;
    CGFloat Y = (self.frame.size.height -H)/2;
    self.rightButton.frame = CGRectMake(X, Y, W , H);
}
- (void)setFollower:(RCFollower *)follower{
    _follower = follower;
    [self.imageView setImageWithURL:[NSURL URLWithString:follower.avatar_large] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    self.textLabel.text = follower.name;
    self.detailTextLabel.text = follower.desc;
    

}
- (UIButton *)setUpRigthButtonWithImage:(NSString *)image selectedImage:(NSString *)selectedImage{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    [self addSubview:button];
    return button;
}
@end
