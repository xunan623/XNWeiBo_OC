//
//  HWStatusToolBar.h
//  XNWeiBo
//
//  Created by 许楠 on 15/10/14.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWStatus;

@interface HWStatusToolBar : UIView

+ (instancetype)toolBar;

@property (nonatomic, strong) HWStatus *status;

@end
