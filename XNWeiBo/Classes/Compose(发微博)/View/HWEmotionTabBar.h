//
//  HWEmotionTabBar.h
//  XNWeiBo
//
//  Created by 许楠 on 15/11/20.
//  Copyright © 2015年 CLT. All rights reserved.
//  表情键盘底部的选项卡

#import <UIKit/UIKit.h>

typedef enum {
    HWEmotionTabBarButtonRecent, // 最近
    HWEmotionTabBarButtonDefault, // 基本
    HWEmotionTabBarButtonEmoji, // emoji
    HWEmotionTabBarButtonLxh, // 浪小花

} HWEmotionTabBarButtonType;

@class HWEmotionTabBar;

// 1.定制协议
@protocol HWEmotionTabBarDelegate <NSObject>

@optional

- (void)emotionTabBar:(HWEmotionTabBar *)tabbar didSelectButton:(HWEmotionTabBarButtonType)buttonType;

@end

@interface HWEmotionTabBar : UIView

// 2.指定代理
@property (nonatomic, weak) id<HWEmotionTabBarDelegate> delegate;

@end
