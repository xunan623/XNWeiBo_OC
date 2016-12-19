//
//  UITextView+Extension.h
//  XNWeiBo
//
//  Created by 许楠 on 15/12/9.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)
- (void )insertAttributeText:(NSAttributedString *)text;
// 1.声明block
- (void)insertAttributeText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *attributedText))settingBlock;
@end
