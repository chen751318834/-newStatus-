//
//  RCToolBar.m
//  高仿微博
//
//  Created by Raychen on 15/4/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCToolBar.h"

@implementation RCToolBar
- (void)setStatus:(RCStatus *)status{
    _status = status;


}
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
    }
    
    return self;
    
    
}
@end
