//
//  HWEmotionTool.m
//  XNWeiBo
//
//  Created by 许楠 on 15/12/20.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWEmotionTool.h"
#import "HWEmotion.h"

// 最近的表情存储路径
#define HWRecentEmotionsPath [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),@"emotions.archive"]



@implementation HWEmotionTool

static NSMutableArray *_recentEmotions;

+ (void)initialize
{
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:HWRecentEmotionsPath];
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
}

// 保存
+ (void)addRecentEmotion:(HWEmotion *)emotion
{
    
    // 删除重复的表情
    [_recentEmotions removeObject:emotion];

    // 将表情放在最前面
    [_recentEmotions insertObject:emotion atIndex:0];
    
    // 写入沙河
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:HWRecentEmotionsPath];
}

/**
 *  返回HWEmotion模型的数组
 */
+ (NSArray *)recentEmotions
{
    return _recentEmotions;
}





//    for (int i = 0; i<emotions.count; i++) {
//        HWEmotion *e = emotions[i];
//        if ([e.chs isEqualToString:emotion.chs] || [e.code isEqualToString:emotion.code]) {
//            [emotions removeObject:e];
//        }
//    }










@end
