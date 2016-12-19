//
//  HWEmotionPopView.m
//  XNWeiBo
//
//  Created by 许楠 on 15/12/6.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWEmotionPopView.h"
#import "HWEmotion.h"
#import "HWEmotionButton.h"

@interface HWEmotionPopView()

@property (weak, nonatomic) IBOutlet HWEmotionButton *emotionBtn;


@end

@implementation HWEmotionPopView

+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HWEmotionPopView" owner:nil options:nil] lastObject];
}

//- (void)setEmotion:(HWEmotion *)emotion
//{
//    _emotion = emotion;
//    self.emotionBtn.emotion = emotion;
//}


- (void)showFrom:(HWEmotionButton *)btn
{
    if (btn == nil) return ;
    
    // 给popView传递数据
    self.emotionBtn.emotion = btn.emotion;
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 计算出被点击的按钮在window中的frame
    CGRect btnFrame = [btn convertRect:btn.bounds toView:window];
    
    self.y = CGRectGetMidY(btnFrame) - self.height;
    self.centerX = CGRectGetMidX(btnFrame);
}





































@end
