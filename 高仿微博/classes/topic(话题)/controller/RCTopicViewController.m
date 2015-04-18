//
//  RCTopicViewController.m
//  高仿微博
//
//  Created by Raychen on 15/4/18.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCTopicViewController.h"
#import "RCTopicResult.h"
#import "RCTopicParam.h"
#import "RCTopicTool.h"
@interface RCTopicViewController ()

@end

@implementation RCTopicViewController
#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor blueColor];
    [self setUpNavigastionBar];
    RCTopicParam * param = [RCTopicParam param];
    param.q = self.text;
    [RCTopicTool topicWithparam:param success:^(RCTopicResult *result) {
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)setUpNavigastionBar{
 
    self.title = @"话题";
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}


@end
