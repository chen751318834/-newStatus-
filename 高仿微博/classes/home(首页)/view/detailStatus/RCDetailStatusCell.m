//
//  RCDetailStatusCell.m
//  高仿微博
//
//  Created by Raychen on 15/4/17.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCDetailStatusCell.h"
#import "RCStatusTextView.h"
#import "RCUser.h"
#import "UIImageView+WebCache.h"
@interface RCDetailStatusCell ()
@property(nonatomic,weak) UIImageView * iconView;

@property(nonatomic,weak) UIImageView * likeView;


@property(nonatomic,weak) UILabel * userNameLabel;

@property(nonatomic,weak) UILabel * timeLabel;


@property(nonatomic,weak) RCStatusTextView * contentLabel;
@end
@implementation RCDetailStatusCell

+ (RCDetailStatusCell *)cellWithTableView:(UITableView *)tableView{
    static NSString * ID =@"detailStatus";
    RCDetailStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell =[[RCDetailStatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    return cell;

}
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        //头像
        UIImageView *iconView = [[UIImageView alloc]init];
        [self addSubview:iconView];
        self.iconView = iconView;
//        iconView.backgroundColor = [UIColor redColor];
        //赞
        UIImageView * likeView = [[UIImageView alloc]init];
        [self addSubview:likeView];
        likeView.image = [UIImage imageNamed:@"statusdetail_icon_like"];
        self.likeView = likeView;
        //用户名
        UILabel *userNameLabel = [[UILabel alloc]init];
        [self addSubview:userNameLabel];
        self.userNameLabel.textColor = [UIColor redColor];
        userNameLabel.font = [UIFont systemFontOfSize:RCUserNameFont];
        
        self.userNameLabel = userNameLabel;
        //时间
        UILabel *timeLabel = [[UILabel alloc]init];
        [self addSubview:timeLabel];
        timeLabel.font = [UIFont systemFontOfSize:RCTimeFont];
   
        //正文
        RCStatusTextView *contentLabel = [[RCStatusTextView alloc]init];
        [self addSubview:contentLabel];
//        contentLabel.font = [UIFont systemFontOfSize:RCUContentFont];
        self.contentLabel = contentLabel;

    }
    
    return self;
    
    
}
- (void)setCommentFrame:(RCCommentFrame *)commentFrame{
    _commentFrame = commentFrame;
    RCComment * comment = commentFrame.comment;
    RCUser * user = comment.user;
    //头像
    self.iconView.frame = commentFrame.iconViewF;
    [self.imageView setImageWithURL:[NSURL URLWithString:user.avatar_large] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    
    //用户名
    self.userNameLabel.frame = commentFrame.userNameLabelF;
    self.userNameLabel.text = user.name;

    
    
    //时间
    self.timeLabel.frame = commentFrame.timeLabelF;
    self.timeLabel.text = comment.text;
    
    //内容
    self.contentLabel.frame = commentFrame.contentLabelF;
    self.contentLabel.attributedText =  comment.attributedText;
    
    //赞
    self.likeView.frame = commentFrame.likeViewF;
    
}

@end
