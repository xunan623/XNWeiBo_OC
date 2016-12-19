//
//  HWUser.h
//  XNWeiBo
//
//  Created by 许楠 on 15/10/5.
//  Copyright © 2015年 CLT. All rights reserved.
//  用户模型

#import <Foundation/Foundation.h>

typedef enum {
    HWUserTypeNone = -1, // 没有认证
    HWUserTypePersonal = 0, // 个人认证
    HWUserTypeOrgEnterprice = 2, // 企业官方:CSDN,EOE,搜狐新闻客户端
    HWUserTypeMedia = 3, // 媒体官方:程序员杂志,苹果汇
    HWUserTypeOrgWebsite = 5, // 网站官方:猫扑
    HWUserTypeDaren = 220 // 微博达人
} HWUserVerifiedType;

@interface HWUser : NSObject
/** string 好友显示名称 */
@property (nonatomic ,copy)NSString *name;
/** string 字符串类型的用户UID */
@property (nonatomic ,copy)NSString *idstr;
/** 用户头像地址 50*50像素 */
@property (nonatomic ,copy)NSString *profile_image_url;
/** 会员类型 值 > 2 才代表会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;
/** 是否是会员 */
@property (nonatomic, assign, getter=isVip) BOOL vip;
/** 认证类型 */
@property (nonatomic, assign) HWUserVerifiedType verified_type;

@end
