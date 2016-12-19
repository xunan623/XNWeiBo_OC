//
//  HWEmotionTabBarButton.m
//  XNWeiBo
//
//  Created by 许楠 on 15/11/24.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWEmotionTabBarButton.h"

@implementation HWEmotionTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        // 设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    // 按钮所做的一切操作都不在了
}

@end
