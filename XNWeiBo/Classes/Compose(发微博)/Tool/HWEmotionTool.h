//
//  HWEmotionTool.h
//  XNWeiBo
//
//  Created by 许楠 on 15/12/20.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HWEmotion;
@interface HWEmotionTool : NSObject

// 保存
+ (void)addRecentEmotion:(HWEmotion *)emotion;

// 读取
+ (NSArray *)recentEmotions;

@end
