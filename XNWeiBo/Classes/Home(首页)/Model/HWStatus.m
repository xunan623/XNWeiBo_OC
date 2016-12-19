//
//  HWStatus.m
//  XNWeiBo
//
//  Created by 许楠 on 15/10/5.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWStatus.h"
#import "HWUser.h"
#import "MJExtension.h"
#import "HWPhoto.h"

@implementation HWStatus

-(NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [HWPhoto class]};
}
/**
 *  重新get方法 得到最新数据  每次加载cell的时候都会调用get方法
 */
-(NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(声明字符串里面每个数字和单词的含义)
    // E:星期
    // M:月份
    // H:小时
    // m:分钟
    // s:秒
    // y:年
    // d:天
    // 如果是美国时间 要设置时间地区
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
   // 微博的创建日期
    NSDate *createDate = [fmt dateFromString:_created_at];
    // 当前时间
    NSDate *now = [NSDate date];
    // 日历对象(方便比较两个日期之间的差距)
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit 想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear |
                          NSCalendarUnitMonth |
                          NSCalendarUnitDay |
                          NSCalendarUnitHour |
                          NSCalendarUnitMinute |
                          NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    if ([createDate isThisYear]) { // 今年
        if ([createDate isYesterDay]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else if ([createDate isToday]) { // 今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",cmps.hour];
            } else if (cmps.minute >=1 ) {
                return [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
            } else {
                return @"刚刚";
            }
        } else { // 今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
    
    return _created_at;
}
/**
 *  获得一次
 */
- (void)setSource:(NSString *)source
{
    // 正则表达式 NSRegularExpression
    // 截取 NSString
    if (source.length>0) {
        NSRange range;
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString:@"</"].location - range.location;
        _source = [NSString stringWithFormat:@"来自 %@",[source substringWithRange:range]];
    } else {
        _source = source;
    }
    
}

































@end
