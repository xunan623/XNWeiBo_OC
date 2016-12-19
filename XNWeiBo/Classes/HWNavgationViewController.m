//
//  HWNavgationViewController.m
//  XNWeiBo
//
//  Created by 许楠 on 15/9/6.
//  Copyright (c) 2015年 CLT. All rights reserved.
//

#import "HWNavgationViewController.h"

@interface HWNavgationViewController ()

@end

@implementation HWNavgationViewController
//第一次使用的时候调用
+ (void)initialize
{
    //设置整个项目的所有的item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //设置普通状态
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16.0f];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置不可用状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSFontAttributeName] = textAttrs[NSFontAttributeName];
    disableTextAttrs[NSForegroundColorAttributeName] = rgb(69, 69, 69);
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/**
 *  重写这个方法的目的:能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 *  @param animated       动画
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    NSLog(@"%ld --- %@",self.viewControllers.count,viewController);
    
    if (self.viewControllers.count >0) { //这是push进来的控制器不是第一个控制器
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(backClick) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(moreClick) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
        /* 自动显示和隐藏 */
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];

}

    
- (void)backClick {
    [self popViewControllerAnimated:YES];
}

- (void)moreClick {
    [self popToRootViewControllerAnimated:YES];
}

@end
