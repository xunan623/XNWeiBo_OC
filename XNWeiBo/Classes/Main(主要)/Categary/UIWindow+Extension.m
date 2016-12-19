//
//  UIWindow+Extension.m
//  XNWeiBo
//
//  Created by 许楠 on 15/10/3.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "HWTabBarViewController.h"
#import "NewFeatureViewController.h"

@implementation UIWindow (Extension)

+ (void)switchRootViewController
{
    NSString *key = @"CFBundleVersion";
    //存储在沙盒中得版本号(上一次的使用版本)
    NSString *lastVersion =  [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    //当前软件的版本号
    NSString *currentVersion =  [NSBundle mainBundle].infoDictionary[key];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([currentVersion isEqualToString:lastVersion]) {//版本号相同:这次打开和上次打开的版本相同
        window.rootViewController = [[HWTabBarViewController alloc] init];
    }else {
        window.rootViewController = [[NewFeatureViewController alloc] init];
        //将当前的版本号存入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }


}
- (void)switchRootViewController
{
    NSString *key = @"CFBundleVersion";
    //存储在沙盒中得版本号(上一次的使用版本)
    NSString *lastVersion =  [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    //当前软件的版本号
    NSString *currentVersion =  [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {//版本号相同:这次打开和上次打开的版本相同
        self.rootViewController = [[HWTabBarViewController alloc] init];
    }else {
        self.rootViewController = [[NewFeatureViewController alloc] init];
        //将当前的版本号存入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
}

@end
