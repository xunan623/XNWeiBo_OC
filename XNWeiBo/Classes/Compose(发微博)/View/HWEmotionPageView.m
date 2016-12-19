//
//  HWEmotionPageView.m
//  XNWeiBo
//
//  Created by 许楠 on 15/12/6.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWEmotionPageView.h"
#import "HWEmotion.h"
#import "HWEmotionPopView.h"
#import "HWEmotionButton.h"
#import "HWEmotionTool.h"

@interface HWEmotionPageView()
/** 点击表情按钮后弹出的放大镜 */
@property (nonatomic, strong) HWEmotionPopView *popView;
/** 删除按钮 */
@property (nonatomic, weak) UIButton *delegateBtn;

@end


@implementation HWEmotionPageView

- (HWEmotionPopView *)popView
{
    if (!_popView) {
        self.popView = [HWEmotionPopView popView];
    }
    return _popView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.删除按钮
        UIButton *delegateBtn = [[UIButton alloc] init];
        [delegateBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [delegateBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [delegateBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:delegateBtn];
        self.delegateBtn = delegateBtn;
        
        // 添加长按手势
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressVIew:)]];
    }
    return self;
}

/**
 *  找到手指的位置
 */
- (HWEmotionButton *)emotionButtonWithLocation:(CGPoint)location
{
    NSUInteger count = self.emotions.count;
    for (int i = 0; i<count; i++) {
        HWEmotionButton *btn = self.subviews[i + 1];
        if (CGRectContainsPoint(btn.frame, location)) {
            return btn;
            // 已经找到手指所在的表情按钮,就没有必要再往下遍历
        }
    }
    return nil;

}

/**
 *  在这个方法中处理长按手势
 */
- (void)longPressVIew:(UILongPressGestureRecognizer *)recognizer
{
    
    CGPoint location = [recognizer locationInView:recognizer.view];
    HWEmotionButton *btn = [self emotionButtonWithLocation:location];
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            // 手指已经不再触摸pageView
            [self.popView removeFromSuperview];
            
            // 如果手指还在表情按钮上
            if (btn) {
                // 发出通知
                [self selectEmotion:btn.emotion];
            }
            break;
        }
        case UIGestureRecognizerStateBegan: // 手机开始(刚检测到长按)
        case UIGestureRecognizerStateChanged: {// 手机开始挪动
            [self.popView showFrom:btn];
            break;
        }
        default:
            break;
    }

}
/**
 *  根据手指的位置找出对应的表情按钮
 *
 */
- (HWEmotionButton *)emotionButtionWithLocation:(CGPoint)location
{
    // 获得手指所在的位置
    NSUInteger count = self.emotions.count;
    for (int i =0;i<count; i++) {
        HWEmotionButton *btn = self.subviews[i + 1];
        if (CGRectContainsPoint(btn.frame, location)) {
            [self.popView showFrom:btn];
            // 能来到这 已经找到表情按钮了,就没有必要再往下遍历
            return btn;
        }
    }
    return nil;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 添加按钮
    NSUInteger count = emotions.count;
    for (int i =0;i<count; i++) {
        HWEmotionButton *btn = [[HWEmotionButton alloc] init];
        
        // 设置表情数据
        btn.emotion = emotions[i];
        // 监听按钮点击
        [btn addTarget:self action:@selector(btnCLick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
        
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 内边距
    CGFloat inset = 10;
    CGFloat btnW = (self.width - 2 *inset) / 7;
    CGFloat btnH = (self.height - inset) / 3;
    // 添加按钮
    NSUInteger count = self.subviews.count;
    for (int i =0;i<count -1; i++) {
        UIButton *btn = self.subviews[i + 1];
        btn.x = inset + (i%7) *btnW;
        btn.y = inset + (i/7) *btnH;
        btn.width = btnW;
        btn.height = btnH;
    }
    
    // 设置删除按钮尺寸
    self.delegateBtn.width = btnW;
    self.delegateBtn.height = btnH;
    self.delegateBtn.y = self.height - btnH;
    self.delegateBtn.x = self.width - inset - btnW;

}
/**
 *  监听表情按钮点击
 */
- (void)btnCLick:(HWEmotionButton *)btn
{
    
    // 显示popVIew
    [self.popView showFrom:btn];
    
    // 等会让popView自动消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
   // 发出通知
    [self selectEmotion:btn.emotion];
}
#pragma mark deleteBtn
- (void)deleteClick:(UIButton *)btn
{
    // 发通知删除
    [HWNotificationCenter postNotificationName:HWEmotionDeleteNotification object:nil];

}
/**
 *  选中某个表情发出通知
 */
- (void)selectEmotion:(HWEmotion *)emotion
{
    // 将这个表情存入沙河
    [HWEmotionTool addRecentEmotion:emotion];
    
    // 发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[HWEmotionDidSelectKey] = emotion;
    [HWNotificationCenter postNotificationName:HWEmotionDidSelectNotification object:nil userInfo:userInfo];
    
}


























@end
