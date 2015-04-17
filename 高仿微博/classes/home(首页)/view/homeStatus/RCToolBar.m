//
//  RCToolBar.m
//  高仿微博
//
//  Created by Raychen on 15/4/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCToolBar.h"



@interface RCToolBar ()
@property(nonatomic,weak) UIImageView * backImageView;
@property(nonatomic,weak) UIImageView * sliderImageView;
@property(strong,nonatomic) NSMutableArray * buttons;
@property(strong,nonatomic) NSMutableArray * silders;
@property(nonatomic,weak) UIButton * retweetButton;
@property(nonatomic,weak) UIButton * commentButton;
@property(nonatomic,weak) UIButton * unlikeButton;


@end
@implementation RCToolBar
- (void)setStatus:(RCStatus *)status{
    _status = status;

    [self setUpWithButton:self.retweetButton count:status.reposts_count title:@"转发"];
    [self setUpWithButton:self.commentButton count:status.comments_count title:@"评论"];
    [self setUpWithButton:self.unlikeButton count:status.attitudes_count title:@"赞"];

}




- (void)setUpWithButton:(UIButton *)button count:(int)count title:(NSString *)title {
    if (count ==0) {
        [button setTitle:title forState:UIControlStateNormal];
    }else{
        
        //小于1000
        if (count <10000) {  //小于1000
            title = [NSString stringWithFormat:@"%d",count];
        }else if(count >10000){    //大于一万
            title = [NSString stringWithFormat:@"%.1f万",count/10000.0];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        
        //大于14000  -> 1.4万
        
        //大于10445  -> 1万
        [button setTitle:title forState:UIControlStateNormal];
        
        
    }

}
-(NSMutableArray *)buttons{
    if (!_buttons) {
        self.buttons =[NSMutableArray array];
    }
    return _buttons;
}
-(NSMutableArray *)silders{
    if (!_silders) {
        self.silders =[NSMutableArray array];
    }
    return _silders;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
        UIImageView * backImageView = [[UIImageView alloc]init];
        [self addSubview:backImageView];
        [backImageView setImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        backImageView.userInteractionEnabled = YES;
        [self setUpSliderView];
        self.backImageView = backImageView;
        UIButton *retweetButton = [self setUpButtonWithTitle:@"转发" image:@"timeline_icon_retweet" buttonType:RCToolBarButtonTypeTransmit];
        self.retweetButton = retweetButton;
        UIButton *commentButton =[self setUpButtonWithTitle:@"评价" image:@"timeline_icon_comment" buttonType:RCToolBarButtonTypeEvaluate];
        self.commentButton = commentButton;
        UIButton *unlikeButton = [self setUpButtonWithTitle:@"赞" image:@"timeline_icon_unlike" buttonType:RCToolBarButtonTypeCommend];
        self.unlikeButton = unlikeButton;



    }
    
    return self;
    
    
}
- (void)setUpSliderView{
    for (int i=0; i<2; i++) {
        UIImageView * sliderImageView = [[UIImageView alloc]init];
        [self addSubview:sliderImageView];
        [sliderImageView setImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted"]];
        sliderImageView.userInteractionEnabled = YES;
        [self.silders addObject:sliderImageView];
    }
}
- (UIButton *)setUpButtonWithTitle:(NSString *)title image:(NSString *)image buttonType:(RCToolBarButtonType )buttonType{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.backImageView addSubview:button];
    [button setTitle:title forState:UIControlStateNormal];
    button.font = [UIFont systemFontOfSize:12];
    button.tag = buttonType;
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted"] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons addObject:button];
    return  button;
    
}
- (void)buttonDidClicked:(UIButton *)button{
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
        self.backImageView.frame = self.bounds;
        CGFloat buttonY = 0;
        CGFloat buttonW = (self.bounds.size.width-2)/3;
        CGFloat buttonH = self.bounds.size.height;
    for (int i=0; i<self.buttons.count; i++) {
        UIButton * button = self.buttons[i ];
        CGFloat buttonX = (buttonW+1)*i;
     
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
    CGFloat sliderY = 5;
    CGFloat sliderW = 1;
    CGFloat sliderH = self.bounds.size.height - 2* sliderY;
    for (int i=0; i<self.silders.count; i++) {
        UIButton * button = self.silders[i ];
        CGFloat  sliderX = sliderW*(i+1)*(buttonW);
        button.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
    }
}
@end
