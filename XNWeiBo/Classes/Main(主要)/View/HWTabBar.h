//
//  HWTabBar.h
//  XNWeiBo
//
//  Created by 许楠 on 15/9/7.
//  Copyright (c) 2015年 CLT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWTabBar;

@protocol HWTabBarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidClickPlusButton:(HWTabBar *)tabBar;

@end

@interface HWTabBar : UITabBar

@property (nonatomic,weak)id <HWTabBarDelegate> delegate;

@end
