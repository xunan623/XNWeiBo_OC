//
//  HWIconView.m
//  XNWeiBo
//
//  Created by 许楠 on 15/11/4.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWIconView.h"
#import "HWUser.h"
#import <UIImageView+WebCache.h>

@interface HWIconView()

@property (nonatomic, weak) UIImageView *verifiedView;
@end

@implementation HWIconView


-(UIImageView *)verifiedView
{
    if (!_verifiedView) {
        UIImageView *verifiedView = [[UIImageView alloc] init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    return _verifiedView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setUser:(HWUser *)user
{
    _user = user;
    
    // 1.下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    // 2.设置加V图片
    switch (user.verified_type) {
        case HWUserTypeNone: // 没有认证
            self.verifiedView.hidden = YES;
            break;
        case HWUserTypePersonal: // 个人认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case HWUserTypeOrgEnterprice:
        case HWUserTypeMedia:
        case HWUserTypeOrgWebsite: // 官方认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case HWUserTypeDaren: // 微博达人
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
 
        default:
            self.verifiedView.hidden = YES;
            break;
    }
}

/**
 *  设置子控件的尺寸
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.verifiedView.size = self.verifiedView.image.size;
    self.verifiedView.x = self.width - self.verifiedView.width * 0.7;
    self.verifiedView.y = self.height - self.verifiedView.height * 0.7;
}


















































@end
