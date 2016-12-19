//
//  HWItemTool.m
//  XNWeiBo
//
//  Created by 许楠 on 15/9/6.
//  Copyright (c) 2015年 CLT. All rights reserved.
//

#import "HWItemTool.h"

@implementation HWItemTool
/**
 *  创建一个item
 *
 *  @param action    点击item调用的方法
 *  @param image     图片
 *  @param highImage 高亮图片
 *
 *  @return 返回UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    //    CGSize size = backBtn.currentBackgroundImage.size;
    //    backBtn.frame = CGRectMake(0, 0, size.width, size.height);
    //等价于上面的
    backBtn.size = backBtn.currentBackgroundImage.size;
    [backBtn addTarget:target  action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}
@end
