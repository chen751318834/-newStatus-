//
//  RCFriendshipsViewController.m
//  高仿微博
//
//  Created by Raychen on 15/4/13.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCFriendshipsViewController.h"
#import "RCFriendshipsResult.h"
#import "RCFriendshipsParam.h"
#import "RCFriendshipsTool.h"
#import "RCAccountTool.h"
#import "RCUser.h"
#import "RCFriendShipsViewCell.h"
#import "MJRefresh.h"
#import "RCSearchFriendsResultViewController.h"
#import "RCSearchBar.h"
#import "RCTitleButton.h"
@interface RCFriendshipsViewController () <UITabBarDelegate,UITableViewDataSource,UISearchBarDelegate>
@property(strong,nonatomic) NSMutableArray * friendShips;
@property (nonatomic, assign)int lastCursor;
@property(nonatomic,weak) UIButton * cover;
@property(nonatomic,weak) UISearchBar * searchBar;
@end

@implementation RCFriendshipsViewController
-(NSMutableArray *)friendShips{
    if (!_friendShips) {
        self.friendShips =[NSMutableArray array];
    }
    return _friendShips;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate        = self;
    self.tableView.rowHeight       = 50;
    //添加遮盖
    UIButton * cover = [UIButton buttonWithType:UIButtonTypeCustom];
    cover.frame = self.view.bounds;
    cover.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.370];
    cover.hidden = YES;
    [cover addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cover];
    self.cover = cover;

    [self setUpHeaderView];

   
    [self setUpRefresh];
    
    [self setUpTitle];
    self.tableView.tableFooterView = [[UIView alloc]init];
    

}


#pragma mark - 集成刷新控件
- (void)setUpRefresh{
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewFriendShips)];
    [self.tableView headerBeginRefreshing];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreFriendShips)];


}
- (void)setUpTitle{
    RCTitleButton * titleButton = [RCTitleButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = CGRectMake(0, 0, 200, 44);
    [titleButton setTitle:@"全部关注" forState:UIControlStateNormal];
    self.navigationItem.titleView = titleButton;
    
}
#pragma mark - 网络请求
/**
 *  加载当前登录用户关注的微博列表
// */
//
//- (void)loadMoreFriendShips{
//    RCFriendshipsParam * param     = [[RCFriendshipsParam alloc]init];
//    param.access_token             = [RCAccountTool account].access_token;
//    param.uid                      = [[RCAccountTool account].uid longLongValue];
//    param.count                    = 100;
//    param.cursor                   = 3;
//    RCUser *  = [self.friendShips firstObject];
//   
//    [RCFriendshipsTool frinedShipsWithparam:param success:^(RCFriendshipsResult *result) {
//        //        NSLog(@"%@",result);
//    NSIndexSet * set               = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.users.count)];
//        [self.friendShips insertObjects:result.users atIndexes:set];
//        //        [self.friendShips addObjectsFromArray:re sult.users];
//        [self.tableView reloadData];
//        [self.tableView footerEndRefreshing];
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//        [self.tableView footerEndRefreshing];
//
//    }];
//
//
//
//}
/**
 *  加载当前登录用户关注的微博列表
 */

- (void)loadNewFriendShips{

    RCFriendshipsParam * param     = [[RCFriendshipsParam alloc]init];
    param.access_token             = [RCAccountTool account].access_token;
    param.uid                      = [[RCAccountTool account].uid longLongValue];
    param.count                    = 100;
    RCUser* user = [self.friendShips firstObject];
    
    param.cursor   = [user.idstr intValue];
    [RCFriendshipsTool frinedShipsWithparam:param success:^(RCFriendshipsResult *result) {
    NSIndexSet * set               = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.users.count)];
        [self.friendShips insertObjects:result.users atIndexes:set];
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.tableView headerEndRefreshing];

    }];

}


#pragma mark - UITabBarDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"numberOfRowsInSection");
    if (section ==1) {
        if (self.friendShips.count ==0) {
            self.tableView.footerHidden = YES;
        }
        return self.friendShips.count;

    }else{
    
        return 2;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
    RCFriendShipsViewCell * cell1  = [RCFriendShipsViewCell cellWithTableView:tableView];
    cell1.user                     = self.friendShips[indexPath.row];
        return cell1;
    }
    static NSString * ID =@"headerCell";
    UITableViewCell *cell          = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {

        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text            = @"dfsdfd";
    if (indexPath.row ==0) {
    cell.imageView.image           = [UIImage imageNamed:@"new_friend"];
    cell.textLabel.text            = @"我的群";
    }else{
    cell.textLabel.text            = @"兴趣主页";
    cell.imageView.image           = [UIImage imageNamed:@"draft"];

    }
    cell.accessoryType             = UITableViewCellAccessoryDisclosureIndicator;

    return cell;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (section == 1) {
//
//        return @"全部关注";
//    }
//    return nil;
//
//}


- (void)setUpHeaderView{
    UISearchBar * searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)] ;
    searchBar.placeholder = @"搜索全部关注";
    searchBar.delegate = self;
    self.searchBar = searchBar;
    self.tableView.tableHeaderView = searchBar;

}
#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.cover.hidden = NO;
    [self.tableView setHeaderHidden:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)cancle{
    [self.searchBar resignFirstResponder];
    [self.cover removeFromSuperview];
    [self searchBarTextDidEndEditing:self.searchBar];}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self.tableView setHeaderHidden:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self.cover removeFromSuperview];


}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}


@end
