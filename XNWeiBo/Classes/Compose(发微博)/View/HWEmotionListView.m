//
//  HWEmotionListView.m
//  XNWeiBo
//
//  Created by 许楠 on 15/11/20.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWEmotionListView.h"
#import "HWEmotionPageView.h"

// 每一页表情个数
#define HWEmotionPageSize 20
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface HWEmotionListView()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation HWEmotionListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        // 1.UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.userInteractionEnabled = NO;
        pageControl.hidesForSinglePage = YES;
        // 设置内部的圆点图片 KVC修改系统属性
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"currentPageImage"];
        
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.pageControl
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    // 2.scrollView
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    self.scrollView.x = self.scrollView.y = 0;
    
    // 3.设置scrollView内部每一页的尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i<count; i++) {
        UIView *pageVIew = self.scrollView.subviews[i];
        pageVIew.height = self.scrollView.height;
        pageVIew.width = ScreenWidth;
        pageVIew.x = pageVIew.width * i;
        pageVIew.y = 0;
    }
}

/**
 *   根据emotions,创建对应的个数表情
 */
- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 删除之前的控件
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger count =  (emotions.count + HWEmotionPageSize - 1)/HWEmotionPageSize;
    
    // 1.设置页数
    self.pageControl.numberOfPages = count;
    
    // 2.创建用来显示每一页的表情控件
    for (int i = 0; i <self.pageControl.numberOfPages; i ++) {
        HWEmotionPageView *pageView = [[HWEmotionPageView alloc] init];
        
        // 计算表情范围
        NSRange range ;
        range.location = i* HWEmotionPageSize; // 0
        
        // left 剩余表情个数
        NSUInteger left = emotions.count - range.location;
        if (left >= HWEmotionPageSize) { // 这一页足够20
            range.length = HWEmotionPageSize; // 20
        }else{
            range.length = left;
        }
        
        // 设置这一页的表情
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
        
    }
    
    // 1页20个
    // 总共55个
    
    // 3.设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(count * ScreenWidth, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    [self setNeedsLayout];
}
#pragma mark scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNum = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(pageNum + 0.5);
    
}

@end




























