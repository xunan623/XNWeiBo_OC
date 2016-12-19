//
//  HWStatus.h
//  XNWeiBo
//
//  Created by 许楠 on 15/10/5.
//  Copyright © 2015年 CLT. All rights reserved.
//  微博模型

#import <Foundation/Foundation.h>
@class HWUser;
@interface HWStatus : NSObject
/** string 好友显示名称 */
@property (nonatomic ,copy) NSString *idstr;

/** string 微博信息内容 */
@property (nonatomic ,copy) NSString *text;

/** object 微博作者的用户信息字段 详细 */
@property (nonatomic ,strong) HWUser *user;

/** string 微博创建时间 */
@property (nonatomic ,copy) NSString *created_at;

/** string 微博来源 */
@property (nonatomic ,copy) NSString *source;

/** 微博图片地址 无图返回'[]' */
@property (nonatomic ,strong) NSArray *pic_urls;

/** 是否是转发微博 */
@property (nonatomic ,strong) HWStatus  *retweeted_status;

/** 转发数 */
@property (nonatomic, assign) NSInteger reposts_count;

/** 评论数 */
@property (nonatomic, assign) NSInteger comments_count;

/** 转发数 */
@property (nonatomic, assign) NSInteger attitudes_count;

@end
