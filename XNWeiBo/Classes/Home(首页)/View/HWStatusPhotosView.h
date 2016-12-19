//
//  HWStatusPhotosView.h
//  XNWeiBo
//
//  Created by 许楠 on 15/10/28.
//  Copyright © 2015年 CLT. All rights reserved.
//  cell上面的配图相册(里面会显示1~9张图片)

#import <UIKit/UIKit.h>

@interface HWStatusPhotosView : UIView

@property (nonatomic, strong) NSArray *photos;

/**
 *  计算几张图片 的大小
 */
+ (CGSize)sizeWithCount:(NSInteger)count;

@end
