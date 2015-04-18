//
//  RCStatusDetailViewController.m
//  高仿微博
//
//  Created by Raychen on 15/4/16.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCStatusDetailViewController.h"
#import "RCStatusView.h"
#import "UIView+Extension.h"
#import "RCStatusFrame.h"
#import "RCDetailStatusToolBar.h"
#import "UIView+Extension.h"
#import "RCDetailStatusTopView.h"
#import "RCStatusTool.h"
#import "RCCommentResult.h"
#import "RCCommentParam.h"
#import "RCComment.h"
#import "RCRepost.h"
#import "RCTransmitResult.h"
#import "RCTransmitParam.h"
#import "RCRetweetedStatusView.h"
#import "RCDetailStatusCell.h"
@interface RCStatusDetailViewController () <RCDetailStatusToolBarDelegate,UITableViewDelegate,UITableViewDataSource,RCDetailStatusTopViewDelegate>


@property(nonatomic,weak) UITableView * tableView;
@property(strong,nonatomic) RCDetailStatusTopView * topView;
@property(strong,nonatomic) NSMutableArray * commentFrames;
@property(strong,nonatomic) NSMutableArray * repostFrames;
@property(strong,nonatomic) UIImageView * emptyView;

@end

@implementation RCStatusDetailViewController
#pragma mark - 初始化
-(UIImageView *)emptyView{
    if (!_emptyView) {
        CGFloat W  = 100;
        CGFloat H = W;
        CGFloat X = (self.view.frame.size.width - W)/2;
        CGFloat Y = self.tableView.tableHeaderView.frame.size.height +50;
        
        self.emptyView =[[UIImageView alloc]initWithFrame:CGRectMake(X, Y, W, H)];
        [self.emptyView setImage:[UIImage imageNamed:@"statusdetail_icon_empty_failed"]];
        [self.tableView addSubview:_emptyView];
        self.emptyView.hidden = (self.repostFrames.count !=0 || self.commentFrames.count !=0);
        
    }
    return _emptyView;
}

-(NSMutableArray *)commentFrames{
    if (!_commentFrames) {
        self.commentFrames =[NSMutableArray array];
    }
    return _commentFrames;
}
-(NSMutableArray *)repostFrames{
    if (!_repostFrames) {
        self.repostFrames =[NSMutableArray array];
    }
    return _repostFrames;
}
-(RCDetailStatusTopView *)topView{
    if (!_topView) {

        self.topView = [[RCDetailStatusTopView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,44 )];
        self.topView.status = self.statusFrame.status;
        self.topView.delegate = self;
    
    }
    return _topView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微博正文";
    [self setUpTableView];
    self.tableView.backgroundColor                = [UIColor colorWithWhite:0.929 alpha:1.000];
    NSLog(@"%@",self.emptyView);
    [self setUpToolBar];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)setUpTableView{
    UITableView * tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.size.width, self.view.size.height - 44) style:UITableViewStylePlain];
    if (self.commentFrames.count ==0 || self.repostFrames.count == 0) {
        tableView.separatorStyle = UITableViewCellAccessoryNone;

    }
    
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.sectionHeaderHeight = 44;


    if (self.isReweetedStatus) {
        RCRetweetedStatusView * headerView = [[RCRetweetedStatusView alloc]init];
        headerView.statusFrame = self.statusFrame;
        headerView.height+=10;
        headerView.userInteractionEnabled = NO;
        headerView.backgroundColor = [UIColor colorWithWhite:0.929 alpha:1.000];
        tableView.tableHeaderView = headerView;
        

    }else{
        RCStatusView * headerView = [[RCStatusView alloc]init];
        headerView.statusFrame = self.statusFrame;
        headerView.height+=10;
        headerView.backgroundColor = [UIColor colorWithWhite:0.929 alpha:1.000];
        tableView.tableHeaderView = headerView;
    
    }
  
    self.tableView = tableView;

    
    
}
- (void)setUpToolBar{
    RCDetailStatusToolBar * toolBar = [[RCDetailStatusToolBar alloc]initWithFrame:CGRectMake(0, self.view.size.height - 44, self.view.size.width, 44)];
    [self.view addSubview:toolBar];

}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        if (self.topView.selectedButtonType == RCDetailStatusTopViewButtonTypeCommend) {

       return  self.commentFrames.count?self.commentFrames.count:0;
    }else{
        return  self.repostFrames.count?self.repostFrames.count:0;

    }
  
   
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return self.topView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCDetailStatusCell * cell = [RCDetailStatusCell cellWithTableView:tableView];
    
       if (self.topView.selectedButtonType == RCDetailStatusTopViewButtonTypeCommend) {
           if (self.commentFrames.count) {
            RCCommentFrame * cmtFrame = self.commentFrames[indexPath.row];
            cell.commentFrame         = cmtFrame;
           }

    } else{
        if (self.repostFrames.count) {
            RCCommentFrame * repost   = self.repostFrames[indexPath.row];
            cell.commentFrame         = repost;
        }

    }

    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.topView.selectedButtonType == RCDetailStatusTopViewButtonTypeCommend) {
        if (self.commentFrames.count) {
            RCCommentFrame * cmtFrame = self.commentFrames[indexPath.row];
            return cmtFrame.cellHigth;
        }
        return 0;
    } else{
        if (self.repostFrames.count) {
            RCCommentFrame * repost = self.repostFrames[indexPath.row];
            return repost.cellHigth;
        }
        return 0;
    }


}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
#pragma mark - RCDetailStatusToolBarDelegate
- (void)detailStatusToolBar:(RCDetailStatusToolBar *)toolBar didClickedButtonType:(RCDetailStatusToolBarButtonType)buttonType{
    switch (buttonType) {
        case RCDetailStatusToolBarButtonTypeTransmit:
            
            break;
        case RCDetailStatusToolBarButtonTypeEvaluate:
            
            break;
        case RCDetailStatusToolBarButtonTypeCommend:
            
            break;
            
    }
    
}

#pragma mark - RCDetailStatusTopViewDelegate
- (void)detailStatusTopView:(RCDetailStatusTopView *)topView didClickedButtonType:(RCDetailStatusTopViewButtonType)buttonType{
    [self.tableView reloadData];
    switch (buttonType) {
        case RCDetailStatusTopViewButtonTypeTransmit:
            [self loadTransmitData];

            break;
            
        case RCDetailStatusTopViewButtonTypeEvaluate:
          

            break;
        case RCDetailStatusTopViewButtonTypeCommend:
            [self loadCommentData];

            break;
    }

}
#pragma mark - 网络请求
- (NSArray *)commentFramesWithComments:(NSArray *)comments{
    NSMutableArray * commentFrames = [NSMutableArray array];
    for (RCComment * comment in comments) {
        RCCommentFrame * commentFrame = [[RCCommentFrame alloc]init];
        commentFrame.comment = comment;
        [commentFrames addObject:commentFrame];
    }
    return commentFrames;
}

#pragma mark 加载转发微博
- (void)loadTransmitData{
    RCTransmitParam * param = [RCTransmitParam param];
    param.ID = @([self.statusFrame.status.idstr longLongValue]);
    RCCommentFrame * repostFrame = [self.repostFrames firstObject];
    param.count = @100;
    if (repostFrame) {
        param.since_id = @([repostFrame.comment.idstr longLongValue]);
    }
    [RCStatusTool transmitWithParam:param success:^(RCTransmitResult *result) {
            NSIndexSet * set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.reposts.count)];
        [self.repostFrames insertObjects:[self commentFramesWithComments:result.reposts] atIndexes:set];
        //转发数
        RCStatus * status = self.statusFrame.status;
        status.reposts_count = result.total_number;
        self.topView.status = status;
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        NSLog(@"%@",error);

    }];
    
}
#pragma mark  加载评论微博

- (void)loadCommentData{
    RCCommentParam *param = [RCCommentParam param];
    param.ID = @([self.statusFrame.status.idstr longLongValue]);
   RCCommentFrame * cmt = [self.commentFrames firstObject];
    if (cmt) {
        param.since_id = @([cmt.comment.idstr longLongValue]);
    }
    [RCStatusTool commentWithParam:param success:^(RCCommentResult *result) {
        
     
        NSIndexSet * set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.comments.count)];
        
        [self.commentFrames insertObjects:[self commentFramesWithComments:result.comments] atIndexes:set];
        
        //评论数
        RCStatus * status = self.statusFrame.status;
        status.comments_count = result.total_number;
        self.topView.status = status;
        [self.tableView reloadData];
        NSLog(@"%@",result);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
    
}
@end
