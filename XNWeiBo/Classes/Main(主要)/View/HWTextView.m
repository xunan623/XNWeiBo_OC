//
//  HWTextView.m
//  XNWeiBo
//
//  Created by 许楠 on 15/11/17.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWTextView.h"

@implementation HWTextView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 通知
        // 当UITextView的文字发生改变时,UITextView自己会发出一个 UITextViewTextDidChangeNotification 通知
        [HWNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
/**
 *  监听文字改变
 */
- (void)textDidChange
{
    // 重绘(重新调用drawRect) 下一个循环重画
    [self setNeedsDisplay];
}
/**
 *  占位文字重写
 */
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}
/**
 *  占位文字颜色重写
 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}
/**
 *  重写textView.text属性方法
 */
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}
/**
 *  重写textView.font属性方法
 */
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

/**
 *  重画
 */
- (void)drawRect:(CGRect)rect {
//    [self.placeholderColor set];
//    UIRectFill(CGRectMake(20, 20, 30, 30));
    
    // 如果有输入文字,就直接返回,不画占位文字
    if (self.hasText) return;
    // 文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    // 画文字
//    [self.placeholder drawAtPoint:CGPointMake(5, 8) withAttributes:attrs];
    CGFloat x = 5;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat y = 8;
    CGFloat H = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w, H);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}








@end
