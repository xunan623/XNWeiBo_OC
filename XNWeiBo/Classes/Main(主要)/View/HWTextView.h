//
//  HWTextView.h
//  XNWeiBo
//
//  Created by 许楠 on 15/11/17.
//  Copyright © 2015年 CLT. All rights reserved.
//  增强:带有占位文字

#import <UIKit/UIKit.h>

@interface HWTextView : UITextView
/** 占位文字 */
@property (nonatomic ,copy)NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic ,strong)UIColor *placeholderColor;


@end
