//
//  RCDisCoverHeaderView.m
//  高仿微博
//
//  Created by Raychen on 15/4/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCDisCoverHeaderView.h"
#import "MJExtension.h"
#import "RCNews.h"
#import "RCCollectionViewCell.h"
static const NSUInteger sectionCount = 100;

@interface RCDisCoverHeaderView ()  <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *topLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *topRigthbutton;
@property (weak, nonatomic) IBOutlet UIButton *bottomLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *hotIdeaButton;
@property(strong,nonatomic) NSArray * newses;

@property(strong,nonatomic) NSTimer * timer;
@end
@implementation RCDisCoverHeaderView
+ (RCDisCoverHeaderView *)headerView{
    return [[[NSBundle mainBundle] loadNibNamed:@"RCDisCoverHeaderView" owner:nil options:nil]lastObject];
    
}
-(NSArray *)newses{
    if (!_newses) {
        self.newses =[RCNews objectArrayWithFilename:@"newses.plist"];
//        self.pageControl.numberOfPages = self.newses.count;
    }
    return _newses;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
//        for (RCNews * news in self.newses) {
//            NSLog(@"%@   %@",news.icon,news.title);
//
//        }
        //注册collectionView
        [self.collectionView registerNib:[UINib nibWithNibName:@"RCCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"news"];
        self.collectionView.delegate = self;

        //滚动到中间
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:0 inSection:sectionCount*0.5];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        
        //添加定时器
//        [self addTimer];
    }
    return self;
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
/**
 *  添加定时器
 */
- (void)addTimer{
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
    
}
/**
 *  移除定时器
 */
- (void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}
- (NSIndexPath *)resetedIndexPath{
    NSIndexPath * currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    //滚动到最中间
    NSIndexPath * currentReSetIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:sectionCount*0.5];
    
    [self.collectionView scrollToItemAtIndexPath:currentReSetIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentReSetIndexPath;
}
- (void)nextPage{
    //获取当前滚动位置
    NSIndexPath * currentIndexPath = [self resetedIndexPath];
    NSInteger nextItem = currentIndexPath.item +1;
    NSInteger nextSection = currentIndexPath.section;
    
    //滚动到下一页
    if (nextItem == self.newses.count) {
        nextItem = 0;
        nextSection ++;
        
    }
    NSIndexPath * nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.newses.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return sectionCount;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RCCollectionViewCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"news" forIndexPath:indexPath];
    cell.news = self.newses[indexPath.item];
    return cell;
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self addTimer];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self resetedIndexPath];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    int currentPage = (int)(scrollView.contentOffset.x /scrollView.bounds.size.width+0.5)%self.newses.count;
//    self.pageControl.currentPage = currentPage;
    
}

@end
