//
//  AppDelegate.m
//  XNWeiBo
//
//  Created by 许楠 on 15/9/5.
//  Copyright (c) 2015年 CLT. All rights reserved.
//

#import "AppDelegate.h"
#import "HWOAuthViewController.h"
#import "HWAccountTool.h"
#import "HWAccount.h"
#import <SDWebImageManager.h>
@interface AppDelegate ()

@property (nonatomic, assign) UIBackgroundTaskIdentifier task;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //iOS8允许用户推送消息
    if ([[UIDevice currentDevice] systemVersion].floatValue >=8.0) {
        UIUserNotificationType type=UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    }
    
    //1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    //2.显示窗口
    [self.window makeKeyAndVisible];
    HWAccountTool *account = [HWAccountTool account];
    
    if (account) { //上次已经登录成功过
        [self.window switchRootViewController];
    } else {
        //2.设置根控制器
        self.window.rootViewController= [[HWOAuthViewController alloc] init];
    }
    
    //很多重复代码->将重复代码抽取到一个方法中
    //1.相同代码放在一个方法中
    //2.不同的东西变成参数
    //3.在使用到这段代码的这个地方调用方法,传递参数
    

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
/**
 *  当app进入后台也调用
 *
 *  @param application <#application description#>
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    /**
     *  app的状态
     *  1.死亡状态：没有打开app
     *  2.前台运行状态
     *  3.后台暂停状态：停止一切动画、定时器、多媒体、联网操作，很难再作其他操作
     *  4.后台运行状态
     */
    // 向操作系统申请后台运行的资格，能维持多久，是不确定的
//    self.task = [application beginBackgroundTaskWithExpirationHandler:^{
//        // 当申请的后台运行时间已经结束（过期），就会调用这个block
//        
//        // 赶紧结束任务
//        [application endBackgroundTask:self.task];
//    }];
    __block UIBackgroundTaskIdentifier task= [application beginBackgroundTaskWithExpirationHandler:^{
        // 当申请的后台运行时间已经结束（过期），就会调用这个block
        
        // 赶紧结束任务
        [application endBackgroundTask:task];
    }];

    
    // 1.定义变量 UIBackgroundTaskIdentifier task
    // 2.执行右边的代码
    // 3. 将右边方法的返回值赋值给task
    
    // 在Info.plst中设置后台模式：Required background modes == App plays audio or streams audio/video using AirPlay
    // 搞一个0kb的MP3文件，没有声音
    // 循环播放
    
    
    
    // 以前的后台模式只有3种
    // 保持网络连接
    // 多媒体应用
    // VOIP:网络电话
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//收到磁盘警告的情况下
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *manger = [SDWebImageManager sharedManager];
    // 1.取消下载
    [manger cancelAll];
    // 2.清除内存中得所有图片
    [manger.imageCache clearMemory];
}


//2.设置根控制器
//UITabBarController *tabbarVc = [[UITabBarController alloc] init];
//self.window.rootViewController = tabbarVc;
//
//UIViewController *vc1 = [[UIViewController alloc] init];
//vc1.view.backgroundColor = XNRadColor;
//vc1.tabBarItem.title = @"首页";
////设置文字的样式
//NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//textAttrs[NSForegroundColorAttributeName] = rgb(123, 123, 123);
//NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
//selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
//[vc1.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
//[vc1.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//vc1.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
////声明这张图片以后按照原始的样子显示出来  不要自动渲染成其他颜色(比如蓝色)
//vc1.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//
//
//UIViewController *vc2 = [[UIViewController alloc] init];
//vc2.view.backgroundColor = XNRadColor;
//[vc2.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
//[vc2.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//
//vc2.tabBarItem.title = @"消息";
//vc2.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center"];
//vc2.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_message_center_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//UIViewController *vc3 = [[UIViewController alloc] init];
//vc3.view.backgroundColor = XNRadColor;
//[vc3.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//
//[vc3.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
//vc3.tabBarItem.title = @"发现";
//vc3.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
//vc3.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_discover_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//UIViewController *vc4 = [[UIViewController alloc] init];
//vc4.view.backgroundColor = XNRadColor;
//vc4.tabBarItem.title = @"我";
//[vc4.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//[vc4.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
//vc4.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"];
//vc4.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_profile_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//3.设置子控制器
//    tabbarVc.viewControllers = @[vc1,vc2,vc3,vc4,vc5];
//[tabbarVc addChildViewController:vc1];
//[tabbarVc addChildViewController:vc2];
//
//[tabbarVc addChildViewController:vc3];
//
//[tabbarVc addChildViewController:vc4];

@end
