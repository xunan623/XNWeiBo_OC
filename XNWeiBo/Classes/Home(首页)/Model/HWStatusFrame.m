//
//  HWStatusFrame.m
//  XNWeiBo
//
//  Created by 许楠 on 15/10/9.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWStatusFrame.h"
#import "HWStatus.h"
#import "HWUser.h"
#import "HWStatusPhotosView.h"


@implementation HWStatusFrame



-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}

-(void)setStatus:(HWStatus *)status
{
    _status = status;
    
    HWUser *user = status.user;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /** 头像 */
    CGFloat iconWH = 40;
    CGFloat iconX = HWStatusCellBorderW;
    CGFloat iconY = HWStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /** 昵称 */
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) +HWStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:HWStatusCellNameFont];
    //设置frame
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    /** 会员图标 */
    if (status.user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + HWStatusCellBorderW - 5;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /** 时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + HWStatusCellBorderW - 5;
    CGSize timeSize = [self sizeWithText:status.created_at font:HWStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + HWStatusCellBorderW - 5;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source font:HWStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX,sourceY},sourceSize};
    
    /** 正文 */
    CGFloat contentX = iconX;
    CGFloat maxW = cellW - 2 * contentX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + HWStatusCellBorderW;
    CGSize contentSize = [self sizeWithText:status.text font:HWStatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX,contentY},contentSize};
    
    /** cell的高度 */
    CGFloat orginalX = 0;
    CGFloat orginalY = HWStatusCellMaginW;
    CGFloat orginalW = cellW;
    CGFloat orginalH;
    /** 配图 */
    if (status.pic_urls.count) { // 有配图
        CGFloat photoWH = 100;
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + HWStatusCellBorderW;
        CGSize photosSize = [HWStatusPhotosView sizeWithCount:status.pic_urls.count];
        self.photosViewF = (CGRect){{photoX,photoY},photosSize};
       
        orginalH = CGRectGetMaxY(self.photosViewF) + HWStatusCellBorderW;

    } else { //没有配图
        orginalH = CGRectGetMaxY(self.contentLabelF) + HWStatusCellBorderW;
    }
    self.orginalViewF = CGRectMake(orginalX, orginalY, orginalW, orginalH);

    CGFloat toolBarY = 0;
    /** 被转发微博整体 */
    if (status.retweeted_status) {
        /** 被转发微博正文 */
        CGFloat retweetContentX = HWStatusCellBorderW;
        CGFloat retweetContentY = HWStatusCellBorderW;
        HWStatus *retweeted_status = status.retweeted_status;
        HWUser *retweeted_status_user = retweeted_status.user;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        CGSize retweetContentSize = [self sizeWithText:retweetContent font:HWRetweetStatusCellContentFont maxW:maxW];
        self.retweetContentLabelF = (CGRect){{retweetContentX, retweetContentY}, retweetContentSize};
        /** 被转发微博配图 */
        CGFloat retweetH = 0;
        if (retweeted_status.pic_urls.count) { // 转发微博有配图
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF) + HWStatusCellBorderW;
            CGSize retweetPhotosSize = [HWStatusPhotosView sizeWithCount:retweeted_status.pic_urls.count];
            self.retweetPhotosViewF = (CGRect){{retweetPhotoX,retweetPhotoY},retweetPhotosSize};
            retweetH = CGRectGetMaxY(self.retweetPhotosViewF) + HWStatusCellBorderW;
        } else { // 转发微博没有配图
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + HWStatusCellBorderW;

        }
        /** 被转发微博整体 */
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.orginalViewF);
        CGFloat retweetW = cellW;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        toolBarY = CGRectGetMaxY(self.retweetViewF);
    } else {
        toolBarY = CGRectGetMaxY(self.orginalViewF);
    }
    /** 工具条 */
    CGFloat toolBarX = 0;
    CGFloat toolBarW = cellW;
    CGFloat toolBarH = 35;
    self.toolBarF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    /** cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.toolBarF) ;
}

























@end
