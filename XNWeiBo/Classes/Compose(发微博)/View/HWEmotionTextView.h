//
//  HWEmotionTextView.h
//  XNWeiBo
//
//  Created by 许楠 on 15/12/9.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWTextView.h"
#import "HWEmotion.h"

@interface HWEmotionTextView : HWTextView
- (void)insertEmotion:(HWEmotion *)emotion;

- (NSString *)fullText;

@end
