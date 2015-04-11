//
//  RCTextView.m
//  高仿微博
//
//  Created by Raychen on 15/4/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCTextView.h"

@implementation RCTextView
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:18];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
        self.alwaysBounceVertical = YES;
    }
    
    return self;
    
    
}
- (void)textChange{
    [self setNeedsDisplay];
}
- (void)setPlaceHolder:(NSString *)placeHolder{
  
  _placeHolder = [placeHolder copy];
    [self  setNeedsDisplay];

}
- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    _placeHolderColor = placeHolderColor;
    [self  setNeedsDisplay];

}
- (void)drawRect:(CGRect)rect{
    if (self.hasText) return;
    NSMutableDictionary * attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = self.font;
    attr[NSForegroundColorAttributeName] = self.placeHolderColor?self.placeHolderColor:[UIColor grayColor];
    CGFloat placeHolderX = 5;
    CGFloat placeHolderY = 8;
    CGFloat placeHolderW = self.bounds.size.width - 2*placeHolderX;
    CGFloat placeHolderH = self.bounds.size.height;

    [self.placeHolder drawInRect:CGRectMake(placeHolderX, placeHolderY, placeHolderW, placeHolderH) withAttributes:attr];
}
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    [self  setNeedsDisplay];

}
- (void)setTextColor:(UIColor *)textColor{
    [super setTextColor:textColor];
    [self  setNeedsDisplay];


}
- (void)setText:(NSString *)text{
    [super setText:text];
    [self  setNeedsDisplay];


}
- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self  setNeedsDisplay];

}

@end
