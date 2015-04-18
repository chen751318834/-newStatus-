//
//  RCWebPageViewController.m
//  高仿微博
//
//  Created by Raychen on 15/4/18.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCWebPageViewController.h"
#import "MBProgressHUD+MJ.h"
@interface RCWebPageViewController () <UIWebViewDelegate>

@end

@implementation RCWebPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView * webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    webView.delegate = self;
    NSURL * url = [NSURL URLWithString:self.text];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

}
#pragma mark - UIWebViewDelegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD showError:@"网页不存在..."];

}
//
//- (void)webViewDidStartLoad:(UIWebView *)webView{
//    [MBProgressHUD showMessage:@"正在加载网页..." toView:self.view];
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    [MBProgressHUD hideHUDForView:self.view];
//}
@end
