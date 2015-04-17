//
//  RCStatusDetailViewController.h
//  高仿微博
//
//  Created by Raychen on 15/4/16.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCStatus.h"
#import "RCStatusFrame.h"
@interface RCStatusDetailViewController : UIViewController

@property(strong,nonatomic) RCStatusFrame * statusFrame;
/**
 *  是否是转发微博
 */
@property (nonatomic, assign,getter=isReweetedStatus)BOOL reweetedStatus;

@end
