//
//  RCsSendStatusController.m
//  高仿微博
//
//  Created by Raychen on 15/4/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCComposeViewController.h"
#import "RCComposeFirstCenterView.h"
#import "RCComposeTwoCenterView.h"
#import "RCSendStatusViewController.h"
#import "RCNavigationController.h"
@interface RCComposeViewController ()  <RCComposeFirstCenterViewDelegate,RCComposeTwoCenterViewDelegate>
@property(nonatomic,weak) RCComposeFirstCenterView * firstCenterView;
@property(nonatomic,weak) RCComposeTwoCenterView * twoCenterView;

@end
@implementation RCComposeViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置最下面的退出按钮
    [self setUpExitButton];
    //设置上方的图片
    [self setUpComposeSlogan];
    // 设置中间按钮的view
    [self setUpComposeCenterView];
     //添加手势
    [self addGestureRecognizer];
   
  }
- (void)addGestureRecognizer{
    UITapGestureRecognizer * viewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
    
    //    UIPanGestureRecognizer
    [self.view addGestureRecognizer:viewTap];
    
    UISwipeGestureRecognizer * twoCenterViewSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeView)];
    twoCenterViewSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.twoCenterView addGestureRecognizer:twoCenterViewSwipe];

}
- (void)dealloc{
    [self.view resignFirstResponder];
}
#pragma mark - 手势事件处理
/**
 *  点击view
 */
- (void)tapView{
    [self eixtButtonDidClicked];
    
}
/**
 *  滑动第二个中间视图控件
 */
- (void)SwipeView{
    [UIView animateWithDuration:0.5f animations:^{
          self.twoCenterView.transform = CGAffineTransformIdentity;
        self.firstCenterView.transform = CGAffineTransformIdentity;
      
    }];
    
}
/**
 *  设置中间按钮的view
 */
- (void)setUpComposeCenterView{
    CGFloat  screenH = self.view.bounds.size.height;
    CGFloat  screenW = self.view.bounds.size.width;

    RCComposeFirstCenterView * firstCenterView = [[RCComposeFirstCenterView alloc]
    initWithFrame:CGRectMake(35, 1.5*screenH/3 , screenW, screenH/2)];
    firstCenterView.delegate = self;
    [self.view addSubview:firstCenterView];
    self.firstCenterView  = firstCenterView;

    RCComposeTwoCenterView * twoCenterView = [[RCComposeTwoCenterView alloc]initWithFrame:CGRectMake(35 +screenW, 1.5*screenH/3 , screenW, screenH/2)];
    twoCenterView.delegate = self;
    [self.view addSubview:twoCenterView];
//    twoCenterView.backgroundColor = [UIColor redColor];
    self.twoCenterView = twoCenterView;

}

/**
 *  设置上方的图片
 */
- (void)setUpComposeSlogan{

    UIImageView * composeSloganView = [[UIImageView alloc]init];
//    composeSloganView.backgroundColor = [UIColor redColor];
    composeSloganView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height/3);
    composeSloganView.contentMode = UIViewContentModeCenter;
    [composeSloganView setImage:[UIImage imageNamed:@"compose_slogan"]];
    [self.view addSubview:composeSloganView];
    


}
/**
 *  设置最下面的退出按钮
 */
- (void)setUpExitButton{
    
    //创建退出按钮
    
    UIButton * exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitButton setImage:[UIImage imageNamed:@"camera_cancel_highlighted"] forState:UIControlStateNormal];
    [exitButton setBackgroundImage:[UIImage imageNamed:@"tabbar_background"] forState:UIControlStateNormal];
    [exitButton addTarget:self action:@selector(eixtButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    exitButton.adjustsImageWhenHighlighted = NO;
    CGFloat exitButtonW =self.view.bounds.size.width;
    exitButton.imageView.contentMode = UIViewContentModeCenter;
    CGFloat exitButtonH =44;
    CGFloat exitButtonX =(self.view.bounds.size.width- exitButtonW)*0.5;
    CGFloat exitButtonY =self.view.bounds.size.height- exitButtonH;
 
    
    exitButton.frame = CGRectMake(exitButtonX, exitButtonY, exitButtonW, exitButtonH);
    [self.view addSubview:exitButton];


}
/**
 *  退出当前控制器
 */
- (void)eixtButtonDidClicked{
    [UIView animateWithDuration:0.5f animations:^{
        if (self.firstCenterView.frame.origin.x == 35) {
            self.firstCenterView.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height);
        }else{
            self.twoCenterView.transform = CGAffineTransformMakeTranslation(-self.view.bounds.size.width, self.view.frame.size.height);
        
        }
           } completion:^(BOOL finished) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

#pragma mark - RCComposeFirstCenterViewDelegate,RCComposeTwoCenterViewDelegate
- (void)composeFirstCenterView:(RCComposeFirstCenterView *)composeFirstCenterView didClickedButtonWithButonType:(RCComposeFirstCenterViewButtonType)buttonType{
    switch (buttonType) {
        case RCComposeFirstCenterViewButtonTypeText:  //文字
            [self presentSendStatusController];
            break;
        case RCComposeFirstCenterViewButtonTypePhotoLibary:
            
            break;
        case RCComposeFirstCenterViewButtonTypeComment:
            
            break;
        case RCComposeFirstCenterViewButtonTypeSignIn:
            
            break;
        case RCComposeFirstCenterViewButtonTypeShoot:
            
            break;
        case RCComposeFirstCenterViewButtonTypeMore:
            [UIView animateWithDuration:0.5f animations:^{
                self.firstCenterView.transform = CGAffineTransformMakeTranslation(-self.view.bounds.size.width, 0);
                         self.twoCenterView.transform = CGAffineTransformMakeTranslation(-self.view.bounds.size.width, 0);
                           }];
            break;
   

    
}
}

- (void)composeTwoCenterView:(RCComposeTwoCenterView *)composeTwoCenterView didClickedButtonWithButonType:(RCComposeTwoCenterViewButtonType)buttonType{
    switch (buttonType) {
        case RCComposeTwoCenterViewButtonTypeFriends:
            
            break;
        case RCComposeTwoCenterViewButtonTypeMiaoPai:
            
            break;
        case RCComposeTwoCenterViewButtonTypeMusic:
            
            break;
        case RCComposeTwoCenterViewButtonTypePay:
            
            break;
        case RCComposeTwoCenterViewButtonTypeLongStatus:
            
            break;
            
        default:
            break;
    }
}
- (void)presentSendStatusController{
    RCSendStatusViewController * sendStatusC = [[RCSendStatusViewController alloc]init];
    UINavigationController * sendStatusNavC = [[UINavigationController alloc]initWithRootViewController:sendStatusC];
    [self presentViewController:sendStatusNavC animated:YES completion:nil];
}
@end
