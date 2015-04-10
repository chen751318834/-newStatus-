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
@implementation RCStatus
- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" :[RCPhoto class]};
}
/**
 *  微博创建时间
 *
 *  @return <#return value description#>
 */
- (NSString *)created_at{
    // _created_at == Fri May 09 16:30:34 +0800 2014
    // 1.获得微博的发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
//#warning 真机调试下, 必须加上这段
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *createdDate = [fmt dateFromString:_created_at];
    
    // 2..判断微博发送时间 和 现在时间 的差距
    if (createdDate.isToday) { // 今天
        if (createdDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%ld小时前", createdDate.deltaWithNow.hour];
        } else if (createdDate.deltaWithNow.minute >= 1) {
            return [NSString stringWithFormat:@"%ld分钟前", createdDate.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
    } else if (createdDate.isYesterday) { // 昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    } else if (createdDate.isThisYear) { // 今年(至少是前天)
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
 
}
- (void)setSource:(NSString *)source{
    _source = source;
    NSUInteger jianLoc = [source rangeOfString:@">"].location;
    if (jianLoc == NSNotFound) {
        _source = [source copy];
    } else {
        NSUInteger loc = jianLoc + 1;
        NSUInteger length = [source rangeOfString:@"</"].location - loc;
        source = [source substringWithRange:NSMakeRange(loc, length)];
        
        _source = [NSString stringWithFormat:@"来自%@", source];
    }
}
//- (int)reposts_count{
//   
//    return 1000;
//
//}
//- (int)comments_count{
//
//    return 10444;
//}
//- (int)attitudes_count{
//    
//    return 15444;
//}
@end
