//
//  NSDate+Extension.m
//  XNWeiBo
//
//  Created by 许楠 on 15/10/22.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear;
    // 获得某个时间的 年月日时分秒
    NSDateComponents *dateCmps = [calendar components:unit fromDate:self];
    // 当前时间
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterDay
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    NSDate *date = [fmt dateFromString:dateStr];
    now =[fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmp = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmp.year == 0 && cmp.month == 0 && cmp.day ==1;
}
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
    return [dateStr isEqualToString:nowStr];
}

@end
