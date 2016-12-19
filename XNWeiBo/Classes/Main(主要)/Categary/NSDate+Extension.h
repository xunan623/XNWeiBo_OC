//
//  NSDate+Extension.h
//  XNWeiBo
//
//  Created by 许楠 on 15/10/22.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear;
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterDay;
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday;
@end
