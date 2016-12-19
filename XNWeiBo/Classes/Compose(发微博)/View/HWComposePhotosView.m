//
//  HWComposePhotosView.m
//  XNWeiBo
//
//  Created by 许楠 on 15/11/18.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWComposePhotosView.h"

@interface HWComposePhotosView()


@end

@implementation HWComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _photos = [NSMutableArray array];
    }
    return self;
}

- (void)addPhoto:(UIImage *)photo
{
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.image = photo;
    [self addSubview:photoView];
    
    // 存储图片
    [self.photos addObject:photo];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置图片的尺寸和位置
    NSInteger photosCount = self.subviews.count;
    int maxCol = 4;
    CGFloat imageWH = self.width/4 -10;
    CGFloat imageMargin = 10;
    for (int i = 0; i<photosCount; i++) {
        
        UIImageView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        photoView.x = col * (imageWH + imageMargin);
        
        int row = i / maxCol;
        photoView.y = row * (imageWH + imageMargin);
        photoView.width = imageWH;
        photoView.height = imageWH;
    }
}


















//-(NSMutableArray *)addedPhtots
//{
//    if (!_addedPhtots) {
//        self.addedPhtots = [NSMutableArray array];
//    }
//    return _addedPhtots;
//}

/**
 *  返回图片数组
 */

//- (NSArray *)photos
//{
//    return self.addedPhtots;
//}


//- (NSArray *)photos
//{
//    NSMutableArray *photos = [NSMutableArray array];
//    for (UIImageView *imageView in self.subviews) {
//        [photos addObject:imageView.image];
//    }
//    return nil;
//}


@end
