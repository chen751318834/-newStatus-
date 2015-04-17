//
//  RCStatus.m
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCStatus.h"
#import "MJExtension.h"
#import "RCPhoto.h"
#import "NSDate+RC.h"
#import "RCUser.h"
#import "RegexKitLite.h"
#import "HWEmotionTool.h"
#import "RCTextPart.h"
#import "HWEmotion.h"
#import "RCSpecialText.h"
#import "RCStatusTool.h"
@implementation RCStatus
MJCodingImplementation

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" :[RCPhoto class]};

}
/**
 *  微博创建时间
 *
 */
- (NSString *)created_at{
    // _created_at == Fri May 09 16:30:34 +0800 2014
  
    // 1.获得微博的发送时间
    NSDateFormatter *fmt                       = [[NSDateFormatter alloc] init];
    fmt.dateFormat                             = @"EEE MMM dd HH:mm:ss Z yyyy";
//#warning 真机调试下, 必须加上这段
    fmt.locale                                 = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *createdDate                        = [fmt dateFromString:_created_at];

    // 2..判断微博发送时间 和 现在时间 的差距
    if (createdDate.isToday) { // 今天
        if (createdDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%d小时前", createdDate.deltaWithNow.hour];
        } else if (createdDate.deltaWithNow.minute >= 1) {
            return [NSString stringWithFormat:@"%d分钟前", createdDate.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
    } else if (createdDate.isYesterday) { // 昨天
    fmt.dateFormat                             = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    } else if (createdDate.isThisYear) { // 今年(至少是前天)
    fmt.dateFormat                             = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    } else { // 非今年
    fmt.dateFormat                             = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }

}

- (void)setSource:(NSString *)source{
    _source                                    = source;
    NSUInteger jianLoc                         = [source rangeOfString:@">"].location;
    if (jianLoc == NSNotFound) {
    _source                                    = [source copy];
    } else {
    NSUInteger loc                             = jianLoc + 1;
    NSUInteger length                          = [source rangeOfString:@"</"].location - loc;
    source                                     = [source substringWithRange:NSMakeRange(loc, length)];

    _source                                    = [NSString stringWithFormat:@"来自%@", source];
    }
}
- (void)setText:(NSString *)text{
    _text                                      = [text copy];
    self.attributedText                        = [self attributedTextWithText:text];

}

- (void)setRetweeted_status:(RCStatus *)retweeted_status{
    _retweeted_status                          = retweeted_status;
    NSString * retweetedContentText            = [NSString stringWithFormat:@"@%@:%@",retweeted_status.user.name,retweeted_status.text];
    self.retweetedAttributedText               = [self attributedTextWithText:retweetedContentText];

}
/**
 *  返回一个带有属性的文字
 *
 *  @param text 普通文字
 *
 *  @return 带有属性的文字
 */
- (NSAttributedString *)attributedTextWithText:(NSString *)text{
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc]init];

    // 表情的规则
    NSString *emotionPattern                   = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    // @的规则
    NSString *atPattern                        = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    // #话题#的规则
    NSString *topicPattern                     = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    // url链接的规则
    NSString *urlPattern                       = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
 
    NSString *pattern                          = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
       //存放textPart模型的shuj
    NSMutableArray * textParts                 = [NSMutableArray array];
      //遍历所有的特殊字符
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;

    RCTextPart * part                          = [[RCTextPart alloc]init];
    part.text                                  = *capturedStrings;
    part.range                                 = *capturedRanges;
    part.SpecialText                           = YES;
    part.emotion                               = [*capturedStrings hasPrefix:@"["]&&[* capturedStrings hasSuffix:@"]"];
        [textParts addObject:part];
         }];


    //遍历所有的非特殊字符
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;

    RCTextPart * part                          = [[RCTextPart alloc]init];
    part.text                                  = *capturedStrings;
    part.range                                 = *capturedRanges;
//        part.SpecialText                           = NO;
//        part.emotion                               = NO;
                [textParts addObject:part];
    }];
     //对数组进行排序

    [textParts sortUsingComparator:^NSComparisonResult(RCTextPart * part1,  RCTextPart * part2) {
        //NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
        if (part1.range.location > part2.range.location) {
            return NSOrderedDescending;
        }
        return NSOrderedAscending;

    }];
//    NSLog(@"%@",textParts);
    UIFont * font                              = [UIFont systemFontOfSize:15];
    /**
     *  创建存放特殊字符的数组
     */
    NSMutableArray * specials = [NSMutableArray array];
    for (RCTextPart * part in  textParts) {
    NSAttributedString * subText               = nil;
              if (part.isEmotion) {
                  HWEmotion * emotion = [HWEmotionTool emotionWithChs:part.text];
                  if (emotion) {
                      NSTextAttachment * atta                    = [[NSTextAttachment alloc]init];
                      atta.image                                 = [UIImage imageNamed:emotion.png];
                      atta.bounds                                = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
                      subText                                    = [NSAttributedString attributedStringWithAttachment:atta];
                  }else{
                      subText = [[NSAttributedString alloc]initWithString:part.text];
                  
                  }
                
                  


        }else if (part.isSpecialText){
            
            subText                                    = [[NSAttributedString alloc]initWithString:part.text attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.644 green:0.712 blue:0.931 alpha:1.000]}]  ;
                //创建RCSpecialText模型
            RCSpecialText * special = [[RCSpecialText alloc]init];
            special.text = part.text;
            special.range = NSMakeRange(attributedText.length, part.text.length);
            [specials addObject:special];
            //添加RCSpecialText模型作为attributedText的属性
//            NSLog(@"specials=======%@",specials);
        }else{
            subText                                    = [[NSAttributedString alloc]initWithString:part.text];
//
        
        }
        
               [attributedText appendAttributedString:subText];

    }

    //设置字体
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
    
    [attributedText addAttribute:@"specials" value:specials range:NSMakeRange(0, 1)];
    


     return attributedText;


}
@end
