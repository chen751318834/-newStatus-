//
//  RCMeInfoHeaderView.m
//  高仿微博
//
//  Created by Raychen on 15/4/18.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCMeInfoHeaderView.h"
#import "RCUserTool.h"
#import "RCUser.h"
@interface RCMeInfoHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *userInfoLabel;

@end
@implementation RCMeInfoHeaderView
+ (RCMeInfoHeaderView *)headerView{

    return [[[NSBundle mainBundle]loadNibNamed:@"RCMeInfoHeaderView" owner:nil options:nil]lastObject];
}
- (void)awakeFromNib{
    if ([RCUserTool user].desc.length !=0) {
        
        self.userInfoLabel.text = [NSString stringWithFormat:@"简介:%@",[RCUserTool user].desc];
    }else{
      self.userInfoLabel.text = @"简介:暂无简介";
    }
}
- (IBAction)editUserInfo:(id)sender {
}
@end
