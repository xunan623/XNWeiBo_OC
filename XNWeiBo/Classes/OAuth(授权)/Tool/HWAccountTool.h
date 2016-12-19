//
//  HWAccountTool.h
//  XNWeiBo
//
//  Created by 许楠 on 15/9/24.
//  Copyright © 2015年 CLT. All rights reserved.
//  处理账号相关的素有信息:存储账号,取出账号

#import <Foundation/Foundation.h>
#import "HWAccount.h"

@interface HWAccountTool : NSObject
//存储账号信息
+ (void)saveAccount:(HWAccount *)account;

//返回账号信息 如果账号过期 返回nil
+ (HWAccount *)account;

@end
