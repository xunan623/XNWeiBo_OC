//
//  HWEmotionListView.h
//  XNWeiBo
//
//  Created by 许楠 on 15/11/20.
//  Copyright © 2015年 CLT. All rights reserved.
//  表情键盘顶部的表情内容

#import <UIKit/UIKit.h>

@interface HWEmotionListView : UIView
/** 表情(里面存放的是HWEmotion模型) */
@property (nonatomic, strong) NSArray *emotions;

@end
