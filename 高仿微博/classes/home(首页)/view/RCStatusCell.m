//
//  RCStatusCell.m
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCStatusCell.h"
#import "RCStatusFrame.h"
#import "RCStatus.h"
#import "RCStatusContentView.h"

@interface RCStatusCell ()
/**
 *  cell的View
 */
@property(nonatomic,weak) RCStatusContentView * statusContentView;
@end
@implementation RCStatusCell
#pragma mark - 懒加载
-(RCStatusContentView *)statusContentView{
    if (!_statusContentView) {
        
        RCStatusContentView * statusContentView =[[RCStatusContentView alloc]init];
        [self addSubview:statusContentView];
        self.statusContentView = statusContentView;
    }
    return _statusContentView;
}

+ (RCStatusCell *)cellWithTableView:(UITableView *)tableView{
    static NSString * ID =@"status";
    RCStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell =[[RCStatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return  cell;

}
/**
 *  设置数据，传递Frame
 *
 *  @param statusFrame <#statusFrame description#>
 */
- (void)setStatusFrame:(RCStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    //原始微博
    self.statusContentView.statusFrame = statusFrame;
    
}
@end
