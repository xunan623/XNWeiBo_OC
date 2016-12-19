//
//  HWEmotionTabBar.m
//  XNWeiBo
//
//  Created by 许楠 on 15/11/20.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWEmotionTabBar.h"
#import "HWEmotionTabBarButton.h"

@interface HWEmotionTabBar()

@property (nonatomic, weak) HWEmotionTabBarButton *selectedBtn;

@end

@implementation HWEmotionTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtn:@"最近" buttonType:HWEmotionTabBarButtonRecent];
        [self setupBtn:@"默认" buttonType:HWEmotionTabBarButtonDefault];
//        [self btnClick:[self setupBtn:@"默认" buttonType:HWEmotionTabBarButtonDefault]];
        [self setupBtn:@"Emoji" buttonType:HWEmotionTabBarButtonEmoji];
        [self setupBtn:@"浪小花" buttonType:HWEmotionTabBarButtonLxh];

    }
    return self;
}

/**
 *  创建一个按钮
 */
- (HWEmotionTabBarButton *)setupBtn:(NSString *)title buttonType:(HWEmotionTabBarButtonType)buttonType
{
    // 创建按钮
    HWEmotionTabBarButton *btn = [[HWEmotionTabBarButton alloc] init];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    
    
    // 绑定类型
    btn.tag = buttonType;
    // 设置背景图片
    NSString *image = nil;
    NSString *selectedImage = nil;
    if (self.subviews.count == 0) {
        image = @"compose_emotion_table_left_normal";
        selectedImage = @"compose_emotion_table_left_selected";
    } else if (self.subviews.count == 3) {
        image = @"compose_emotion_table_right_normal";
        selectedImage = @"compose_emotion_table_right_selected";
    } else {
        image = @"compose_emotion_table_mid_normal";
        selectedImage = @"compose_emotion_table_mid_selected";
    }
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateDisabled];

    [self addSubview:btn];
    return btn;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0 ; i < btnCount; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
        btn.x = i *btnW;
    }
}
/**
 *  按钮点击
 */
- (void)btnClick:(HWEmotionTabBarButton *)btn
{
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
    // 3.通知代理
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:(HWEmotionTabBarButtonType)btn.tag];
    }
}

/**
 *  重写setDelegate
 */

- (void)setDelegate:(id<HWEmotionTabBarDelegate>)delegate
{
    _delegate = delegate;
    
    // 默认选中
    [self btnClick:[self viewWithTag:HWEmotionTabBarButtonDefault]];
    
}





















@end
