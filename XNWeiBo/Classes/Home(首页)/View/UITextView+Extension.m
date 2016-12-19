//
//  UITextView+Extension.m
//  XNWeiBo
//
//  Created by 许楠 on 15/12/9.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)
- (void)insertAttributeText:(NSAttributedString *)text
{
    
    [self insertAttributeText:text settingBlock:nil];
    
    /* selectedRange:
     1.控制textView的文字选中范围
     2.如果selectedRange.length为0,相当是用来控制 selectedRange.location 是 textView的光标位置
     
     关于textView文字的字体
     1.如果是普通文字,文字大小由textView.font控制
     2.如果是属性文字,(attribu)
     */
}


- (void)insertAttributeText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *attributedText))settingBlock
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    // 拼接之前的文字(图片和普通文字)
    [attributedText appendAttributedString:self.attributedText];
    
    // 拼接图片
    NSUInteger loc = self.selectedRange.location;
//    [attributedText insertAttributedString:text atIndex:loc];
    [attributedText replaceCharactersInRange:self.selectedRange withAttributedString:text];
    
    // 调用外面传进来的代码
    if (settingBlock) {
        settingBlock(attributedText);
    }
    
//    [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
    self.attributedText = attributedText;
    
    // 移动光标到表情后面
    self.selectedRange = NSMakeRange(loc +1, 0);
}



































@end
