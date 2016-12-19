//
//  HWDropdownMenu.h
//  XNWeiBo
//
//  Created by 许楠 on 15/9/7.
//  Copyright (c) 2015年 CLT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWDropdownMenu;
//1
@protocol HWDropdownMenuDelegate <NSObject>

@optional
- (void)dropdownMenuDidDismiss:(HWDropdownMenu *)menu;
- (void)dropdownMenuDidShow:(HWDropdownMenu *)menu;

@end

@interface HWDropdownMenu : UIView
//2
@property (nonatomic,weak)id <HWDropdownMenuDelegate>delegate;

+(instancetype)menu;

- (void)showFrom:(UIView *)from;
-(void)dismiss;

/**
 *  内容
 */
@property (nonatomic,strong)UIView *content;
/**
 *  内容控制器
 */
@property (nonatomic,strong)UIViewController *contentController;


@end
