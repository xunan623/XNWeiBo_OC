//
//  HWTabBarViewController.m
//  XNWeiBo
//
//  Created by 许楠 on 15/9/5.
//  Copyright (c) 2015年 CLT. All rights reserved.
//

#import "HWTabBarViewController.h"
#import "HWHomeViewController.h"
#import "HWMessageCenterTableViewController.h"
#import "HWDiscoverTableViewController.h"
#import "HWProfleTableViewController.h"
#import "HWNavgationViewController.h"
#import "HWTabBar.h"
#import "HWComposeViewController.h"

@interface HWTabBarViewController ()<HWTabBarDelegate>

@end

@implementation HWTabBarViewController

#pragma mark 实现tabBar的代理方法
- (void)tabBarDidClickPlusButton:(HWTabBar *)tabBar {
    HWComposeViewController *compose = [[HWComposeViewController alloc] init];
    HWNavgationViewController *nav = [[HWNavgationViewController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    HWTabBar *tabBar = [[HWTabBar alloc] init];
    tabBar.delegate = self;
    //2.更换系统自带的tabbar KVC
    [self setValue:tabBar forKey:@"tabBar"];
    
    //[self setValue:tabBar forKey:@"tabBar"]; 这行代码过后,tabbar的delegate就是HWTabBarViewController

    //不允许修改TabBar的delegate属性(这个TabBar是被TabBarViewController所管理的)
    
    //1.初始化子控制器
    HWHomeViewController *home = [[HWHomeViewController alloc] init];
    [self addClildVCWithTitle:@"首页" viewController:home image:@"tabbar_home" selectImage:@"tabbar_home_selected"];
    HWMessageCenterTableViewController *messageCenter = [[HWMessageCenterTableViewController alloc] init];
    [self addClildVCWithTitle:@"消息" viewController:messageCenter image: @"tabbar_message_center" selectImage:@"tabbar_message_center_selected"];
    HWDiscoverTableViewController *discover = [[HWDiscoverTableViewController alloc] init];
    [self addClildVCWithTitle:@"发现" viewController:discover image:@"tabbar_discover" selectImage:@"tabbar_discover_selected"];
    HWProfleTableViewController *profile = [[HWProfleTableViewController alloc] init];
    [self addClildVCWithTitle:@"我" viewController:profile image:@"tabbar_profile" selectImage:@"tabbar_profile_selected"];
    
    
    


}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSInteger count = self.tabBar.subviews.count ;
    for (int i=0; i<count; i++) {
        UIView *child = self.tabBar.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
//            NSLog(@"系统自带按钮");
            child.width = self.tabBar.width/count;
        }
    }
//    HWLog(@"%@",self.tabBar.subviews);

}

/**
 *  添加一个子控制器
 *
 *  @param title       控制器标题
 *  @param chlidVc     子控制器
 *  @param image       图片
 *  @param selectImage 选中的图片
 */
- (void)addClildVCWithTitle:(NSString *)title viewController:(UIViewController *)chlidVc image:(NSString *)image selectImage:(NSString *)selectImage {
    
    //设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = rgb(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
//    chlidVc.view.backgroundColor = XNRadColor;
//    chlidVc.tabBarItem.title = title;
//    chlidVc.navigationItem.title = title;
    chlidVc.title = title;
    [chlidVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [chlidVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    chlidVc.tabBarItem.image = [UIImage imageNamed:image];
    chlidVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [chlidVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    [chlidVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    //给传进来的控制器添加导航控制器
    HWNavgationViewController *nav = [[HWNavgationViewController alloc] initWithRootViewController:chlidVc];
    //添加为子控制器
    [self addChildViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
