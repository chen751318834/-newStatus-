//
//  RCTextView.m
//  高仿微博
//
//  Created by Raychen on 15/4/15.
//  Copyright (c) 2015年 raychen. All rights reserved.
//  显示正文的textview

#import "RCStatusTextView.h"
#import "RCSpecialText.h"
#define RCStatusTextViewCoverTag 10
@implementation RCStatusTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        self.editable = NO;
        self.scrollEnabled = NO;
        NSLog(@"%@",NSStringFromUIEdgeInsets(self.contentInset));

    }
    
    return self;
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint  point = [touch locationInView:touch.view];
    //取出存放 RCSpecialText模型的数组
       NSArray * specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
//    NSLog(@"%@",specials);
    //是否是特殊字符
    BOOL isSpecial = NO;
    //遍历 RCSpecialText模型的数组
    for (RCSpecialText * special in specials) {
        //设置选中的range
        self.selectedRange = special.range;
        //，根据selectedTextRange取得选中的rect

       NSArray * rects = [self selectionRectsForRange:self.selectedTextRange];
        // 清空选中范围
        self.selectedRange = NSMakeRange(0, 0);
        //遍历 rects

        for (UITextSelectionRect * selectedRect in rects) {
       
            CGRect rect = selectedRect.rect;
            if (rect.size.width == 0 && rect.size.height == 0) {
                continue;
            }
            if (CGRectContainsPoint(rect, point)) {
                isSpecial = YES;    //是特殊字符

                break;
            }
        }
        if (isSpecial) {     //如果是特殊字符

            for (UITextSelectionRect * selectedRect in rects) {
                
                CGRect rect = selectedRect.rect;
                if (rect.size.width == 0 && rect.size.height == 0) {
                    continue;
                }
                //插入点中时的背景
                UIView * cover = [[UIView alloc]init];
                cover.tag = RCStatusTextViewCoverTag;
                cover.layer.cornerRadius = 5;
                cover.backgroundColor = [UIColor greenColor];
                cover.frame = rect;
                [self insertSubview:cover atIndex:0];
           }
            break;

        }
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self touchesCancelled:touches withEvent:event];
    });

}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    //移除背景
    for (UIView * view in self.subviews) {
        if (view.tag == RCStatusTextViewCoverTag) {
            [view removeFromSuperview];
        }
    }
    
}
/**
 *  处理当前点击的位置把事件交给谁处理
 *  返回YES 自己处理
    返回NO 交给别的view处理
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{

    //取出存放 RCSpecialText模型的数组
    NSArray * specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    //遍历 RCSpecialText模型的数组
    for (RCSpecialText * special in specials) {
        //设置选中的range
        self.selectedRange = special.range;
        //，根据selectedTextRange取得选中的rect
        
        NSArray * rects = [self selectionRectsForRange:self.selectedTextRange];
        // 清空选中范围
        self.selectedRange = NSMakeRange(0, 0);
        //遍历 rects
        
        for (UITextSelectionRect * selectedRect in rects) {
            
            CGRect rect = selectedRect.rect;
            if (rect.size.width == 0 && rect.size.height == 0) {
                continue;
            }
            if (CGRectContainsPoint(rect, point)) {
                return YES;
            }
            
        }}

    return NO;
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return [super hitTest:point withEvent:event];
}
@end
