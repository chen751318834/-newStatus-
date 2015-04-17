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
@implementation RCFollowersCell

+ (RCFollowersCell *)cellWithTableView:(UITableView *)tableView{
    static NSString * ID =@"followers";
    RCFollowersCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell =[[RCFollowersCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        cell.accessoryView = [self setUpRigthButtonWithImage:@"" selectedImage:@""];
    }
    return cell;


}
- (void)setFollower:(RCFollower *)follower{
    _follower = follower;
    [self.imageView setImageWithURL:[NSURL URLWithString:follower.avatar_large] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    self.textLabel.text = follower.name;
    self.detailTextLabel.text = follower.status.text;
    

}
+ (UIButton *)setUpRigthButtonWithImage:(NSString *)image selectedImage:(NSString *)selectedImage{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    return button;
}
@end
