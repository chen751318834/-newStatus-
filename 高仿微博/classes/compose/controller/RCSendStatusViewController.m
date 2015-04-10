//
//  RCSendStatusViewController.m
//  高仿微博
//
//  Created by Raychen on 15/4/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSendStatusViewController.h"
#import "RCTextView.h"
#import "RCSendStatusTool.h"
#import "RCSendStatusParam.h"
#import "RCAccountTool.h"
#import "MBProgressHUD+MJ.h"


@interface RCSendStatusViewController () <UITextViewDelegate>
@property(nonatomic,weak) RCTextView * textView;
@end
@implementation RCSendStatusViewController
#pragma mark - 初始化
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self setUpNavigationBar];
    [self setUpTextView];
}
/**
 *  设置导航栏
 */
- (void)setUpNavigationBar{

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendStatus)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.title = @"发微博";
    
    //标题
    NSString * name = [RCAccountTool account].name;
    NSString * str = [NSString stringWithFormat:@"发微博\n%@",name];
    if (name) {
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        NSMutableAttributedString * attrText = [[NSMutableAttributedString alloc]initWithString:str];
        NSRange range = NSMakeRange(0, 2);
        [attrText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:range];
        [titleLabel setAttributedText:attrText];
        
        [attrText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[str rangeOfString:name]];
        [titleLabel setAttributedText:attrText];
        self.navigationItem.titleView = titleLabel;
    }
   }
- (void)setUpTextView{
    RCTextView * textView = [[RCTextView alloc]initWithFrame:self.view.bounds];
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.placeHolder = @"分享新鲜事.....";
    [self.view addSubview:textView];
    self.textView = textView;

}
- (void)sendStatus{
    RCSendStatusParam * param = [[RCSendStatusParam alloc]init];
    param.access_token = [RCAccountTool account].access_token;
    param.status = self.textView.text;
    [RCSendStatusTool sendOneStatusWithparam:param success:^(RCSendStatusResult *result) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
        NSLog(@"%@",error);
    
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;

}
@end
