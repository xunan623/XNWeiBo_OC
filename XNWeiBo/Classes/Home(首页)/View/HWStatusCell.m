//
//  HWStatusCell.m
//  XNWeiBo
//
//  Created by 许楠 on 15/10/9.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWStatusCell.h"
#import "HWStatus.h"
#import "HWUser.h"
#import "HWStatusFrame.h"
#import <UIImageView+WebCache.h>
#import "HWPhoto.h"
#import "HWStatusToolBar.h"
#import "HWStatusPhotosView.h"
#import "HWIconView.h"

@interface HWStatusCell()
/** 原创微博 */
/** 原创微博整体 */
@property (nonatomic, weak) UIView *orginalView;
/** 头像 */
@property (nonatomic, weak) HWIconView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) HWStatusPhotosView *photosView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *contentLabel;

/** 转发微博 */
/** 转发微博整体 */
@property (nonatomic, weak) UIView *retweetView; // repost
/** 转发微博正文 + 昵称 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 转发配图 */
@property (nonatomic, weak) HWStatusPhotosView *retweetPhotosView;

/** 工具条 */
@property (nonatomic, weak) HWStatusToolBar *toolBar;

@end

@implementation HWStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    HWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[HWStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}
/**
 *  2.重写set方法 得到最新的高度
 */
//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.y += HWCellMargin;
//    [super setFrame:frame];
//}

-(void)setStatusFrame:(HWStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    HWStatus *status = statusFrame.status;
    HWUser *user = status.user;
    
//    ls3576
    
    self.orginalView.frame = statusFrame.orginalViewF;
    /** 头像 */
    self.iconView.frame = statusFrame.iconViewF;
    self.iconView.user = user;
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    /** 会员图标 */
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
        self.nameLabel.textColor = rgb(256, 109, 0);
    } else {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    /** 配图 */
    if (status.pic_urls.count) {
        
        HWPhoto *photo = [status.pic_urls firstObject];
        self.photosView.photos = status.pic_urls;
        self.photosView.frame = statusFrame.photosViewF;
#warning 设置图片
//        [self.photosView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }

    /** 昵称 */
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    
    /** 时间 */
    NSString *newTime = status.created_at;
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF) + HWStatusCellBorderW -5;
    CGSize timeSize = [newTime sizeWithFont:HWStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    self.timeLabel.text = newTime;
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + HWStatusCellBorderW - 5;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:HWStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    self.sourceLabel.text = status.source;
    
    /** 时间 */
//    self.timeLabel.frame = statusFrame.timeLabelF;
//    self.timeLabel.text = status.created_at;
    if (user.isVip) {
        self.timeLabel.textColor = rgb(256, 109, 0);
    } else {
        self.timeLabel.textColor = HWTextColor;
    }
    /** 来源 */
//    self.sourceLabel.frame = statusFrame.sourceLabelF;
//    self.sourceLabel.text = status.source;
    self.sourceLabel.textColor = HWTextColor;
    /** 正文 */
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = status.text;
    self.contentLabel.textColor = rgb(50, 50, 50);
    self.contentLabel.numberOfLines = 0;
    
    /** 被转发的微博 */
    /** 被转发的微博整体 */
    if (status.retweeted_status) {
        HWStatus *retweeted_status = status.retweeted_status;
        HWUser *retweeted_status_user = retweeted_status.user;
        self.retweetView.backgroundColor = rgb(247, 247, 247);
        self.retweetView.frame = statusFrame.retweetViewF;
        self.retweetView.hidden = NO;
        
        /** 被转发的微博正文 */
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        self.retweetContentLabel.textColor = rgb(75, 75, 75);
        self.retweetContentLabel.text = retweetContent;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
        /** 被转发的微博配图 */
        if (retweeted_status.pic_urls.count) {
            self.retweetPhotosView.frame = statusFrame.retweetPhotosViewF;
            self.retweetPhotosView.photos = retweeted_status.pic_urls;
#warning 设置图片
//            [self.retweetPhotosView sd_setImageWithURL:[NSURL URLWithString:retweetPhoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            self.retweetPhotosView.hidden = NO;
        } else {
            self.retweetPhotosView.hidden = YES;
        }
        
    } else {
        self.retweetView.hidden = YES;
    }
    /** 工具条 */
    self.toolBar.frame = statusFrame.toolBarF;
    self.toolBar.status = status;
}

/**
 *  cell的初始化方法,一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件,以及子控件的一次性设置
 */
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        // 初始化原创微博
        [self setupOriginalView];
        
        // 初始化转发微博
        [self setupRetweet];
        
        // 初始化工具条
        [self setupToolBar];
    }
    return self;
}
/**
 *  初始化工具条
 */
- (void)setupToolBar
{
    HWStatusToolBar *toolBar = [HWStatusToolBar toolBar];
    [self.contentView addSubview:toolBar];
    self.toolBar = toolBar;
}

/**
 *  初始化转发微博
 */
- (void)setupRetweet
{
    //** 转发微博整体 */
    UIView *retweetView = [[UIView alloc] init];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 转发微博正文 + 昵称 */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    [retweetView addSubview:retweetContentLabel];
    retweetContentLabel.font = HWRetweetStatusCellContentFont;
    retweetContentLabel.numberOfLines = 0;
    self.retweetContentLabel = retweetContentLabel;
    
    /** 转发微博配图 */
    HWStatusPhotosView *retweetPhotoView = [[HWStatusPhotosView alloc] init];
    [retweetView addSubview:retweetPhotoView];
    self.retweetPhotosView = retweetPhotoView;
}

/**
 *  初始化原创微博
 */
- (void)setupOriginalView
{
    // 1.原创微博整体
    UIView *orginalView = [[UIView alloc] init];
    [self.contentView addSubview:orginalView];
    orginalView.backgroundColor = [UIColor whiteColor];
    self.orginalView = orginalView;
    /** 头像 */
    HWIconView *iconView = [[HWIconView alloc] init];
    [orginalView addSubview:iconView];
    self.iconView = iconView;
    /** 会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    [orginalView addSubview:vipView];
    vipView.contentMode = UIViewContentModeCenter;
    self.vipView = vipView;
    /** 配图 */
    HWStatusPhotosView *photoView = [[HWStatusPhotosView alloc] init];
    [orginalView addSubview:photoView];
    self.photosView = photoView;
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = HWStatusCellNameFont;
    [orginalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = HWStatusCellTimeFont;
    [orginalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    [orginalView addSubview:sourceLabel];
    sourceLabel.font = HWStatusCellSourceFont;
    self.sourceLabel = sourceLabel;
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    [orginalView addSubview:contentLabel];
    contentLabel.font = HWStatusCellContentFont;
    self.contentLabel = contentLabel;
    

}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
