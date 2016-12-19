//
//  HWEmotionPopView.h
//  XNWeiBo
//
//  Created by 许楠 on 15/12/6.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWEmotion,HWEmotionButton;
@interface HWEmotionPopView : UIView

//@property (nonatomic, strong) HWEmotion *emotion;

+ (instancetype)popView;

- (void)showFrom:(HWEmotionButton *)btn;

@end
