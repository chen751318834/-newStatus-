//
//  RCFriendShipsViewCell.m
//  高仿微博
//
//  Created by Raychen on 15/4/13.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCFriendShipsViewCell.h"
#import "UIImageView+WebCache.h"
#import "RCStatus.h"
@implementation RCFriendShipsViewCell
+ (RCFriendShipsViewCell *)cellWithTableView:(UITableView *)tableView{
    static NSString * ID =@"frinedShips";
    RCFriendShipsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell =[[RCFriendShipsViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:ID];
    }
    cell.detailTextLabel.textColor = [UIColor grayColor];
//    cell.accessoryView = [uibu];
    return cell;

}
- (void)setUser:(RCUser *)user{
    _user = user;
    RCStatus * status = user.status;
    self.textLabel.text = user.name;
    [self.imageView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    self.detailTextLabel.text = status.text;
}

@end
