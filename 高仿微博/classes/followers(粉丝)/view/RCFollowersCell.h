//
//  RCFollowersCell.h
//  高仿微博
//
//  Created by Raychen on 15/4/17.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCFollower.h"
@interface RCFollowersCell : UITableViewCell
+ (RCFollowersCell *)cellWithTableView:(UITableView *)tableView;
@property(strong,nonatomic) RCFollower * follower;

@end
