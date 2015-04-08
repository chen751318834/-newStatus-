//
//  RCOauthViewController.m
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCOauthViewController.h"
#import "RCOauthTool.h"
#import "RCOauthResult.h"
#import "RCOauthParam.h"
#import "RCAccountTool.h"
#import "RCTabBarController.h"
#import "RCNetWorkingTool.h"
#import "RCNewFeatureViewController.h"

#define RCAppSecret @"f79c4e56673fba83beda3893d335b70c"
#define RCGrantType @"authorization_code"
#define RCRedirectUri @"http://www.baidu.com"
#define RCAppKey @"979566339"
@interface RCOauthViewController () <UIWebViewDelegate>

@end

@implementation RCOauthViewController
#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView * webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.delegate =self;
    NSString * uslString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",RCAppKey,RCRedirectUri];
    
    
    NSURL * url = [NSURL URLWithString:uslString ];
    NSURLRequest* requrest = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:requrest];
    [self.view addSubview:webView];
    
}
#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //URL: http://www.baidu.com/?code=7341480e1d811141ce4fe7b90640048e
    NSLog(@"%@",request.URL.absoluteString);
    NSString * url =  request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    if (range.location != NSNotFound) {
        // 截取code=后面的参数值
        NSUInteger fromIndex = range.location + range.length;
       NSString *code =  [url substringFromIndex:fromIndex];
//        NSLog(@"%@",code);
        //根据code获取accessToken
        [self accessTokenWithCode:code];
        return NO;

    }

    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
 

    NSLog(@"didFailLoadWithError====%@",error);
}
#pragma mark - 私有方法
/**
 *  根据code获取accessToken
 *
 *  @param code <#code description#>
 */
- (void)accessTokenWithCode:(NSString *)code{
    RCOauthParam * param = [[RCOauthParam alloc]init];
    param.client_id = RCAppKey;
    param.client_secret = RCAppSecret;
    param.grant_type = RCGrantType;
    param.code = code;
    param.redirect_uri = RCRedirectUri;


    [RCOauthTool accessTokenWithparam:param success:^(RCOauthResult *result) {
        NSLog(@"%@",result);
        //储存账户信息
        [RCAccountTool saveAccount:(RCAccount *)result];
        //跳转到主界面
        [self enterHomeController];
    } failure:^(NSError *error) {
        NSLog(@"accessTokenWithparam========%@",error);
    }];


}
- (void)enterHomeController{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    //取出储存的版本号
    NSString * oldVersion = [[NSUserDefaults standardUserDefaults] valueForKey:@"CFBundleShortVersionString"];
    //获取当前版本号
    NSDictionary * infoDict = [NSBundle mainBundle].infoDictionary;
    NSString * currentVersion = infoDict[@"CFBundleShortVersionString"];
    NSLog(@"%@",currentVersion);
    
    //储存当前版本号
    [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([currentVersion isEqualToString:oldVersion]) {//版本号相同,进入主页面
    window.rootViewController = [[RCTabBarController alloc]init];
    }else{ //版本号不同，进入版本新特性界面
        window.rootViewController = [[RCNewFeatureViewController alloc]init];
    }

}
@end
