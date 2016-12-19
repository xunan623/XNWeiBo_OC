//
//  HWStatusFrame.h
//  XNWeiBo
//
//  Created by 许楠 on 15/10/9.
//  Copyright © 2015年 CLT. All rights reserved.
//  一个HWStatusFrame 模型 存放着信息
//  1.存放一个cell内部所有子控件的frame数据
//  2.存放一个cell的高度
//  3.存放着一个数据模型HWStatus

#import <Foundation/Foundation.h>

//昵称字体
#define HWStatusCellNameFont [UIFont systemFontOfSize:15]

//时间字体
#define HWStatusCellTimeFont [UIFont systemFontOfSize:12]

//来源字体
#define HWStatusCellSourceFont [UIFont systemFontOfSize:12]

//正文字体
#define HWStatusCellContentFont [UIFont systemFontOfSize:17]

//被转发微博正文字体
#define HWRetweetStatusCellContentFont [UIFont systemFontOfSize:16]

//cell的边框宽度
#define HWStatusCellBorderW 10
//cell的间距
#define HWStatusCellMaginW 10

@class HWStatus;

@interface HWStatusFrame : NSObject

@property (nonatomic, strong) HWStatus *status;

/** 原创微博整体 */
@property (nonatomic, assign) CGRect orginalViewF;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign) CGRect photosViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/** 转发微博 */
/** 转发微博整体 */
@property (nonatomic, assign) CGRect retweetViewF; // repost
/** 转发微博正文 + 昵称 */
@property (nonatomic, assign) CGRect retweetContentLabelF;
/** 转发配图 */
@property (nonatomic, assign) CGRect retweetPhotosViewF;

/** 底部工具条 */
@property (nonatomic, assign) CGRect toolBarF;



@end
