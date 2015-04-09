//
//  RCStatusCell.h
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCStatusFrame;


@interface RCStatusCell : UITableViewCell
+ (RCStatusCell *)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,weak) RCStatusFrame * statusFrame;

@end
