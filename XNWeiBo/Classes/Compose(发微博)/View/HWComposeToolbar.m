//
//  HWComposeToolbar.m
//  XNWeiBo
//
//  Created by 许楠 on 15/11/17.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWComposeToolbar.h"

@interface HWComposeToolbar()

@property (nonatomic, weak) UIButton *emotionButton;

@end

@implementation HWComposeToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        // 初始化按钮
        [self setupBtn:@"compose_camerabutton_background" hightImage:@"compose_camerabutton_background_highlighted" tag:HWComposeToolbarButtonTypeCamera];
        [self setupBtn:@"compose_toolbar_picture" hightImage:@"compose_toolbar_picture_highlighted" tag:HWComposeToolbarButtonTypePicture];
        [self setupBtn:@"compose_mentionbutton_background" hightImage:@"compose_mentionbutton_background_highlighted" tag:HWComposeToolbarButtonTypeMention];
        [self setupBtn:@"compose_trendbutton_background" hightImage:@"compose_trendbutton_background_highlighted" tag:HWComposeToolbarButtonTypeTrend];
        self.emotionButton = [self setupBtn:@"compose_emoticonbutton_background" hightImage:@"compose_emoticonbutton_background_highlighted" tag:HWComposeToolbarButtonTypeEmotion];
        
    }
    return self;
}

- (void)setShowEmotionButton:(BOOL)showEmotionButton
{
    _showEmotionButton = showEmotionButton;
    
    if (showEmotionButton) {
        // 显示键盘图标
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    } else {
        // 显示表情键盘
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}

/**
 *  创建一个按钮
 */
- (UIButton *)setupBtn:(NSString *)image hightImage:(NSString *)highImage tag:(HWComposeToolbarButtonType)tag
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [self addSubview:btn];
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    // 设置所有按钮的frame
    for (NSUInteger i = 0 ; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.x = i *btnW;
        btn.width = btnW;
        btn.height = btnH;
    }
}

#pragma mark - 五个按钮点击
- (void)btnClick:(UIButton *)btn
{
    // 3.触发方法
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
//        NSUInteger index = (NSUInteger)(btn.x / btn.width);
        [self.delegate composeToolbar:self didClickButton:(int)btn.tag];
    }
}


@end


















