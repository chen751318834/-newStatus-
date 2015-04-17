//
//  RCFriendShipsViewCell.h
//  高仿微博
//
//  Created by Raychen on 15/4/13.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCUser.h"
@interface RCFriendShipsViewCell : UITableViewCell
+ (RCFriendShipsViewCell *)cellWithTableView:(UITableView *)tableView;
@property(strong,nonatomic) RCUser * user;

@end
