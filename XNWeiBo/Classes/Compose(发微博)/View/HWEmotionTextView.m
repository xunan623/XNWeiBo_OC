//
//  HWEmotionTextView.m
//  XNWeiBo
//
//  Created by 许楠 on 15/12/9.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWEmotionTextView.h"
#import "UITextView+Extension.h"
#import "HWEmotionAttachment.h"

@implementation HWEmotionTextView

- (void)insertEmotion:(HWEmotion *)emotion
{
    if (emotion.code) {
        // insertText: 将文字插入到光标所在的位置
        [self insertText:emotion.code.emoji];
    }
    else if (emotion.png) {
        // 加载图片
        HWEmotionAttachment *attch = [[HWEmotionAttachment alloc] init];
        
        attch.emotion = emotion;
        
        // font的行高
        CGFloat attchWH = self.font.lineHeight;
        attch.bounds = CGRectMake(0, -4, attchWH, attchWH);
        
        // 根据附件创建一个属性文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
        
        // 插入属性文字到光标位置
        [self insertAttributeText:imageStr settingBlock:^(NSMutableAttributedString *attributedText) {
            // 设置字体
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];
        // 设置字体
//        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
//        
//        [text addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, text.length)];
       
    }

}

- (NSString *)fullText
{
    NSMutableString *fullText = [NSMutableString string];
   
    // 遍历所有的文字(图片,emoji,普通文字)
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        
        // 获得这个范围内的文字
        [self.attributedText attributedSubstringFromRange:range];
        
        // 如果是图片表情
        HWEmotionAttachment *attch = attrs[@"NSAttachment"];
        if (attch) { // 图片
            [fullText appendString:attch.emotion.chs];
        }else { // emoji 普通文字
            // 获得这个范围内的文字
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
        
    }];
    return fullText;
}













@end
