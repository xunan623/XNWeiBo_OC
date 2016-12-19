//
//  HWEmotion.m
//  XNWeiBo
//
//  Created by 许楠 on 15/12/2.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWEmotion.h"
#import "MJExtension.h"

@interface HWEmotion() <NSCoding>

@end

@implementation HWEmotion

// 读取对象 存入对象
MJCodingImplementation

/**
 *  从文件中解析对象的时候调用
 */
//-(instancetype)initWithCoder:(NSCoder *)decoder
//{
//    if (self = [super init]) {
//        self.chs = [decoder decodeObjectForKey:@"chs"];
//        self.png = [decoder decodeObjectForKey:@"png"];
//        self.code = [decoder decodeObjectForKey:@"code"];
//
//    }
//    return self;
//}
///**
// *  将内容写入文件时候调用
// */
//- (void)encodeWithCoder:(NSCoder *)encoder
//{
//    [encoder encodeObject:self.chs forKey:@"chs"];
//    [encoder encodeObject:self.png forKey:@"png"];
//    [encoder encodeObject:self.code forKey:@"code"];
//}

/**
 *  用来比较两个对象是否一样  比较两个对象
 */
- (BOOL)isEqual:(HWEmotion *)other
{
//    if (self == other) {
//        return YES;
//    } else {
//        return NO;
//    }
//    
    return [self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code];
}









@end
