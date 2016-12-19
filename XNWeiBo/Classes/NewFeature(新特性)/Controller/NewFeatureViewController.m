//
//  NewFeatureViewController.m
//  XNWeiBo
//
//  Created by 许楠 on 15/9/9.
//  Copyright (c) 2015年 CLT. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "HWTabBarViewController.h"

#define HWNewFeatureCount 4

@interface NewFeatureViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)UIScrollView *scrollview;

@end

@implementation NewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //首先创建scrollview 显示新特性
    UIScrollView *scrollview = [[UIScrollView alloc] init];
    scrollview.frame = self.view.bounds;
    scrollview.delegate = self;
    scrollview.pagingEnabled = YES;
    //弹簧效果
    scrollview.bounces = NO;
    [self.view addSubview:scrollview];
    self.scrollview = scrollview;
    CGFloat scrollW = scrollview.width;
    CGFloat scrollH = scrollview.height;

    //2.添加图片到scrollview
    for (int i=0; i<HWNewFeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i *scrollW;
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage imageNamed:name];
        [scrollview addSubview:imageView];
        
        //如果是最后一个imageview,就往里面添加内容
        if (i == HWNewFeatureCount -1) {
            [self setupLastImageView:imageView];
        }
    }
    //scrollView里面可能存在其他子控件(这些子控件是系统默认存在的)
    
    //3.设置scorllview的其他尺寸
    //如果想让某个方向上不能滚动,那么这个方向对应的尺寸数值传0可
    scrollview.contentSize = CGSizeMake(self.view.width*HWNewFeatureCount, 0);
    scrollview.showsHorizontalScrollIndicator = NO;
    
    //4.添加pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = HWNewFeatureCount;
    pageControl.y = scrollH -50;
    pageControl.centerX =scrollW * 0.5;
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = rgb(189, 189, 189);
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
}

#pragma mark 最后的imageView
/**
 *  初始化最后一个imageView
 *
 *  @param imageView 最后一个imageView
 */
-(void)setupLastImageView:(UIImageView *)imageView {
    imageView.userInteractionEnabled = YES;
    //1.分享给大家(checkbox)
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.width = 150;
    shareBtn.height = 30;
    shareBtn.centerX = imageView.width/2;
    shareBtn.centerY = imageView.height*0.65;
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];
   // top left bottom right
    //contentEdgeInsets 会影响按钮内部的所有内容(里面的imageView和titleLabel)
//    [shareBtn setBackgroundColor:[UIColor redColor]];
    //EdgeInsets 自切 相当于div中得padding
//    shareBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
    
    //titleEdgeInsets 这个只影响title的位置
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    //imageEdgeInsets 这个只影响imageView的位置
    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    
    //2.开始微博
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageView.height * 0.75;
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startWeiBo) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];

}
#pragma mark 开始微博
- (void)startWeiBo {
    //切换到HWTabBarViewController
    /*切换控制器的手段:
    1.push 控制器是可以返回的
    2.model modal
    3.切换window的根控制器rootViewController
     */
    UIWindow *window =  [UIApplication sharedApplication].keyWindow ;
    HWTabBarViewController *tabbar = [[HWTabBarViewController alloc] init];
    window.rootViewController =tabbar;
}

#pragma mark 分享给大家
- (void)shareClick:(UIButton *)btn {
    btn.selected = !btn.selected;
}

-(void)dealloc
{
    NSLog(@"dealloc");
}
#pragma mark scrollview
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%@",self.scrollview.subviews);
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    double page = scrollView.contentOffset.x/scrollView.width;
    self.pageControl.currentPage = (int)(page+0.5);
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 一个空间用肉眼看不见 有哪些可能
 1.根本没有实例化这个控件
 2.没有设置尺寸
 3.控件的颜色可能和父控件的背景色一样(实际上已经显示)
 4.透明度alpha <= 0.01
 5.hidden = yes
 6.没有添加到父控件中
 7.被其他控件挡住了
 8.位置不对
 9.再次检查父控件发生了以上的情况
 10.特殊情况 : 
    比如UIImageView没有设置image属性,或者图片名不对
    UILabel没有设置文字,或者跟父控件的颜色一样
    UIPageControl没有设置总页数,不会显示小圆点
 */

@end
