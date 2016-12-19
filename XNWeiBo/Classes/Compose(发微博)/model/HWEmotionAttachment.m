//
//  HWEmotionAttachment.m
//  XNWeiBo
//
//  Created by 许楠 on 15/12/12.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWEmotionAttachment.h"


@implementation HWEmotionAttachment

- (void)setEmotion:(HWEmotion *)emotion
{
    _emotion = emotion;
    self.image = [UIImage imageNamed:emotion.png];
}


@end
