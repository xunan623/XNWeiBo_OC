//
//  HWEmotionButton.m
//  XNWeiBo
//
//  Created by 许楠 on 15/12/7.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWEmotionButton.h"
#import "HWEmotion.h"

@implementation HWEmotionButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        [self setup];
    }
    return self;
}

/**
 *  xib中创建的调用这个方法  storyboard
 */
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:40];
        [self setup];
    }
    return self;
}

- (void)setup
{
    // 按钮高亮的时候,不要调整图片为灰色
    self.adjustsImageWhenHighlighted = NO;
}

/**
 *  这个方法在initWithCoder:方法调用完成后调用
 */
-(void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)setEmotion:(HWEmotion *)emotion
{
    _emotion = emotion;
    if (emotion.png) {
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    }
    else if (emotion.code) {
        // 设置emoji
        [self setTitle:[emotion.code emoji] forState:UIControlStateNormal];
    }
}

@end

