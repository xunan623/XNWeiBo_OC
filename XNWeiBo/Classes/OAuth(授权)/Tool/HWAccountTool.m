//
//  HWAccountTool.m
//  XNWeiBo
//
//  Created by 许楠 on 15/9/24.
//  Copyright © 2015年 CLT. All rights reserved.
//

//账号的存储路径
#define HWAccountPath [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),@"account.archive"]

#import "HWAccountTool.h"
#import "HWAccount.h"
@implementation HWAccountTool


+(void)saveAccount:(HWAccount *)account
{
    //NSKeyedArchiver  自定义对象的存储  不再用writeToFile方法
    [NSKeyedArchiver archiveRootObject:account toFile:HWAccountPath];
}

+ (HWAccount *)account
{
    //加载模型
    HWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:HWAccountPath];
    //验证账号
    long long expires_in = [account.expires_in longLongValue];
    
    //获取过期时间
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    NSDate *now = [NSDate date];
    //如果now>expiresTime 就是过期
    /*
     NSOrderedAscending = -1L, 升序, 右边>左边
     NSOrderedSame, 一样
     NSOrderedDescending   降序 右边<左边
     */
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending ) { //过期
        return nil;
    }
//    HWLog(@"%@ %@",expiresTime,now);
    return account;
}

@end
