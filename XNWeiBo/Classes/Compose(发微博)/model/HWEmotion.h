//
//  HWEmotion.h
//  XNWeiBo
//
//  Created by 许楠 on 15/12/2.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWEmotion : NSObject 
/** 表情的文字描述 */
@property (nonatomic ,copy)NSString *chs;
/** 表情的png图片名 */
@property (nonatomic ,copy)NSString *png;

/** emotion表情的16进制编码 */
@property (nonatomic ,copy)NSString *code;
@end
