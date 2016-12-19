//
//  HWComposeToolbar.h
//  XNWeiBo
//
//  Created by 许楠 on 15/11/17.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HWComposeToolbarButtonTypeCamera, // 拍照
    HWComposeToolbarButtonTypePicture, // 相册
    HWComposeToolbarButtonTypeMention, // @
    HWComposeToolbarButtonTypeTrend, // #
    HWComposeToolbarButtonTypeEmotion // 表情

} HWComposeToolbarButtonType;

@class HWComposeToolbar;
// 1.定义协议
@protocol HWComposeToolbarDelegete <NSObject>

- (void)composeToolbar:(HWComposeToolbar *)toolbar didClickButton:(HWComposeToolbarButtonType)buttonType;

@end

@interface HWComposeToolbar : UIView
// 2.指定代理
@property (nonatomic, weak) id<HWComposeToolbarDelegete> delegate;
/** 是否显示表情按钮 */
@property (nonatomic, assign) BOOL showEmotionButton;

@end
