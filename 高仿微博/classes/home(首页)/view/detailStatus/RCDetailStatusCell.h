//
//  RCDetailStatusCell.h
//  高仿微博
//
//  Created by Raychen on 15/4/17.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCCommentFrame.h"
@interface RCDetailStatusCell : UITableViewCell
@property(strong,nonatomic) RCCommentFrame * commentFrame;
+ (RCDetailStatusCell *)cellWithTableView:(UITableView *)tableView;
@end
