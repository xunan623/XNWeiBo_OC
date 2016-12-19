//
//  HWItemTool.h
//  XNWeiBo
//
//  Created by 许楠 on 15/9/6.
//  Copyright (c) 2015年 CLT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWItemTool : NSObject

/**
 *  创建一个item
 *
 *  @param action    点击item调用的方法
 *  @param image     图片
 *  @param highImage 高亮图片
 *
 *  @return 返回UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end
