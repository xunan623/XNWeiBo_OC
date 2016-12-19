//
//  HWEmotionKeyboard.m
//  XNWeiBo
//
//  Created by 许楠 on 15/11/19.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWEmotionKeyboard.h"
#import "HWEmotionListView.h"
#import "HWEmotionTabBar.h"
#import "HWEmotion.h"
#import "MJExtension.h"
#import "HWEmotionTool.h"

@interface HWEmotionKeyboard()<HWEmotionTabBarDelegate> // 4.遵循代理
/** 表情内容 */
@property (nonatomic, strong) HWEmotionListView *recentListView;
@property (nonatomic, strong) HWEmotionListView *defaultListView;
@property (nonatomic, strong) HWEmotionListView *emojiListView;
@property (nonatomic, strong) HWEmotionListView *lxhListView;

/** 保存正在显示的view */
@property (nonatomic, weak) HWEmotionListView *showingListView;

/** tabbar */
@property (nonatomic, weak) HWEmotionTabBar *tabBar;

@end

@implementation HWEmotionKeyboard

#pragma mark 懒加载
- (HWEmotionListView *)recentListView
{
    if (!_recentListView) {
        self.recentListView = [[HWEmotionListView alloc] init];
        self.recentListView.emotions = [HWEmotionTool recentEmotions];

    }
    return _recentListView;
}
- (HWEmotionListView *)defaultListView
{
    if (!_defaultListView) {
        self.defaultListView = [[HWEmotionListView alloc] init];
        NSString * path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        NSArray *defaultEmotion = [NSArray arrayWithContentsOfFile:path];
        self.defaultListView.emotions = [HWEmotion objectArrayWithKeyValuesArray:defaultEmotion];

    }
    return _defaultListView;
}
- (HWEmotionListView *)emojiListView
{
    if (!_emojiListView) {
        self.emojiListView = [[HWEmotionListView alloc] init];
        NSString * path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        NSArray *emojiEmotions = [NSArray arrayWithContentsOfFile:path];
        self.emojiListView.emotions = [HWEmotion objectArrayWithKeyValuesArray:emojiEmotions];

    }
    return _emojiListView;
}
- (HWEmotionListView *)lxhListView
{
    if (!_lxhListView) {
        self.lxhListView = [[HWEmotionListView alloc] init];
        NSString * path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        NSArray *lxhEmotions = [NSArray arrayWithContentsOfFile:path];
        self.lxhListView.emotions = [HWEmotion objectArrayWithKeyValuesArray:lxhEmotions];
    }
    return _lxhListView;
}

#pragma mark 初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 2.tabbar
        HWEmotionTabBar *tabBar = [[HWEmotionTabBar alloc] init];
        tabBar.delegate = self; // 5.指定代理
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        // 监听表情选中的通知
        // 监听表情选中
        [HWNotificationCenter addObserver:self selector:@selector(HWEmotionDidSelect) name:HWEmotionDidSelectNotification object:nil];
    }
    return self;
}

- (void)HWEmotionDidSelect
{
    self.recentListView.emotions = [HWEmotionTool recentEmotions];
}

- (void)dealloc
{
    [HWNotificationCenter removeObserver:self];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 2.tabbar
    self.tabBar.height = 37;
    self.tabBar.y = self.height - self.tabBar.height;
    self.tabBar.width = self.width;
    
    // 1.表情内容
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.tabBar.y;

}
#pragma mark HWEmotionTabBarDelegate 实现代理方法
- (void)emotionTabBar:(HWEmotionTabBar *)tabbar didSelectButton:(HWEmotionTabBarButtonType)buttonType
{
    // 移除正在显示的listView控件
    [self.showingListView removeFromSuperview];
    
    // 根据按钮类型 切换contentView上面的listView
    switch (buttonType) {
        case HWEmotionTabBarButtonRecent: // 最近
            // 加载沙河中的数据
//            self.recentListView.emotions = [HWEmotionTool recentEmotions];
            [self addSubview:self.recentListView];
            NSLog(@"最近");
            break;
        case HWEmotionTabBarButtonDefault: { // 默认
            [self addSubview:self.defaultListView];

            NSLog(@"默认");
            break;
        }
        case HWEmotionTabBarButtonEmoji: { // emoji
            [self addSubview:self.emojiListView];

            NSLog(@"emoji");
            break;
        }
        case HWEmotionTabBarButtonLxh: { // 浪小花
            NSLog(@"浪小花");
            [self addSubview:self.lxhListView];
            break;
        }

    }
    
    // 设置正在显示的listView
    self.showingListView = [self.subviews lastObject];
    
    // 重新计算子控件的frame 会在恰当的时刻调用layoutSubviews重新布局子控件
    [self setNeedsLayout];
    

}






























@end
