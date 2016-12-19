//
//  HWEmotionPageView.h
//  XNWeiBo
//
//  Created by 许楠 on 15/12/6.
//  Copyright © 2015年 CLT. All rights reserved.
//  用来表示一页的表情 (里面显示1-20个表情)

#import <UIKit/UIKit.h>

@interface HWEmotionPageView : UIView
/** 这一页显示的表情 (里面HWEmotion模型) */
@property (nonatomic, strong) NSArray *emotions;
@end
