//
//  HWComposePhotosView.h
//  XNWeiBo
//
//  Created by 许楠 on 15/11/18.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWComposePhotosView : UIView
// 添加图片方法
- (void)addPhoto:(UIImage *)photo;

// 获取图片数组方法
//- (NSArray *)photos;

/** 获取图片数组 */
// setter 和 getter 的声明和实现 还有_addedPhtots
// 如果手动实现getter,那么就不会再自动生成getter的实现和_成员变量
// 如果手动实现setter和getter,那么就不会实现setter和getter和_成员变量

// 只能拿到我的图片 不能够赋值
@property (nonatomic, strong, readonly) NSMutableArray *photos;

//@property (nonatomic, strong, readonly) NSArray *photos;

@end
