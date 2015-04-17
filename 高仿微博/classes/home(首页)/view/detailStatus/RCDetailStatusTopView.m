//
//  RCDetailStatusTopView.m
//  高仿微博
//
//  Created by Raychen on 15/4/16.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCDetailStatusTopView.h"

#import "RCStatus.h"
@interface RCArrowButton :UIButton

@end
@implementation RCArrowButton

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeCenter;
        self.titleLabel.contentMode = UIViewContentModeCenter;
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    
    return self;
    
    
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat X =(self.frame.size.width - [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.width)/2;
    CGFloat Y = 0;
    CGFloat W = self.bounds.size.width;
    CGFloat H = self.bounds.size.height *0.8;
    return CGRectMake(X, Y, W, H);
    
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat X = 0;
    CGFloat Y = self.bounds.size.height *0.8;
    CGFloat W = self.bounds.size.width;
    CGFloat H = self.bounds.size.height *0.2;
    return CGRectMake(X, Y, W, H);

}




@end
@interface RCDetailStatusTopView ()
@property(nonatomic,weak) UIButton * selectedButton;
@property(nonatomic,weak) UIView * silder1;
@property(nonatomic,weak) UIView * silder2;
@property(nonatomic,weak) RCArrowButton * transmitButton;
@property(nonatomic,weak) RCArrowButton * evaluateButton;
@property(nonatomic,weak) RCArrowButton * commendButton;
@end
@implementation RCDetailStatusTopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
       RCArrowButton * transmitButton = [self setUpButtonWithTitle:@"转发" buttonType:RCDetailStatusTopViewButtonTypeTransmit];
        self.transmitButton = transmitButton;
              RCArrowButton * commendButton =  [self setUpButtonWithTitle:@"评论" buttonType:RCDetailStatusTopViewButtonTypeCommend];
        self.commendButton = commendButton;
              RCArrowButton * evaluateButton =  [self setUpButtonWithTitle:@"赞" buttonType:RCDetailStatusTopViewButtonTypeEvaluate];
        self.evaluateButton = evaluateButton;
        UIView * silder1 = [[UIView alloc]init];
        [self addSubview:silder1];
        silder1.backgroundColor = [UIColor colorWithWhite:0.929 alpha:1.000];

        self.silder1 = silder1;
        UIView * silder2 = [[UIView alloc]init];
        [self addSubview:silder2];
        silder2.backgroundColor = [UIColor colorWithWhite:0.929 alpha:1.000];
        
        self.silder2 = silder2;
        
        
    }
    
    return self;
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat buttonY = 0;
    CGFloat buttonW = self.bounds.size.width/5;
    CGFloat buttonH = self.bounds.size.height;
    for (int i=0; i<self.subviews.count; i++) {
        UIButton * button = self.subviews[i ];
        if (i==2) {
            i+=2;
        }
        CGFloat buttonX = (buttonW)*i;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
    self.silder1.frame = CGRectMake(0, self.frame.size.height -1, self.frame.size.width, 1);
    self.silder2.frame = CGRectMake(self.bounds.size.width/5, 10, 1, self.frame.size.height-20);

}
- (RCArrowButton *)setUpButtonWithTitle:(NSString *)title buttonType:(RCDetailStatusTopViewButtonType )buttonType{
    RCArrowButton * button =[RCArrowButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:button];
    button.tag = buttonType;
    button.font = [UIFont systemFontOfSize:14];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];

    button.contentMode = UIViewContentModeScaleAspectFill;
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
      [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];

    [button setImage:[UIImage imageNamed:@"statusdetail_segmented_bottom_arrow"] forState:UIControlStateSelected];
    button.imageView.contentMode = UIViewContentModeBottom;
    
    [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];

    return  button;
    
}
- (void)setDelegate:(id<RCDetailStatusTopViewDelegate>)delegate{
    _delegate = delegate;
        [self buttonDidClicked:self.transmitButton];
    
}
- (void)buttonDidClicked:(RCArrowButton *)btn{
    if ([self.delegate respondsToSelector:@selector(detailStatusTopView:didClickedButtonType:)]) {
        [self.delegate detailStatusTopView:self didClickedButtonType:btn.tag];
    }

    self.selectedButtonType = btn.tag;
    self.selectedButton.selected = NO;
    btn.selected = YES;
    self.selectedButton = btn;



}
- (void)setStatus:(RCStatus *)status{
    _status = status;
    NSString *reposts_countString = @"转发";
    if (status.reposts_count) {
        reposts_countString = [NSString stringWithFormat:@"转发 %d",status.reposts_count];
    }
    [self.transmitButton setTitle:reposts_countString forState:UIControlStateNormal];
    [self.transmitButton setTitle:reposts_countString forState:UIControlStateSelected];


    NSString *comments_countString = @"评论";
    if (status.comments_count) {
        comments_countString = [NSString stringWithFormat:@"评论 %d",status.comments_count];
    }
    [self.commendButton setTitle:comments_countString forState:UIControlStateNormal];
    [self.commendButton setTitle:comments_countString forState:UIControlStateSelected];


    NSString *attitudes_countString = @"赞";
    if (status.attitudes_count) {
        attitudes_countString = [NSString stringWithFormat:@"赞 %d",status.attitudes_count];
    }
    [self.evaluateButton setTitle:attitudes_countString forState:UIControlStateNormal];
    [self.evaluateButton setTitle:attitudes_countString forState:UIControlStateSelected];


    
    
}

@end
