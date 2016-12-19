//
//  HWTabBar.m
//  XNWeiBo
//
//  Created by 许楠 on 15/9/7.
//  Copyright (c) 2015年 CLT. All rights reserved.
//

#import "HWTabBar.h"
@interface HWTabBar()
@property (nonatomic,weak)UIButton *plusBtn;
@end
@implementation HWTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //3.添加一个按钮到tabbar中
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}
/**
 *  加号按钮点击
 */
- (void)plusClick {
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //1.设置加号按钮的位置
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height *0.5;
    
    //2.设置其他tabbarButton的位置和尺寸
    //self.subviews.count
    CGFloat tabbarButtonW = self.width/5;
    CGFloat tabbarButtonIndex = 0;

    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            //设置宽度
            child.width = tabbarButtonW;
            //设置x
            child.x = tabbarButtonIndex *tabbarButtonW;
            //增加索引
            tabbarButtonIndex ++;
            if (tabbarButtonIndex == 2) {
                tabbarButtonIndex ++;
            }
        }
    }
    
//    HWLog(@"%@",self.subviews);
}

@end
