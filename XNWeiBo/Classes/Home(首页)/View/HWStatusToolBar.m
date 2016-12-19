//
//  HWStatusToolBar.m
//  XNWeiBo
//
//  Created by 许楠 on 15/10/14.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWStatusToolBar.h"
#import "HWStatus.h"

@interface HWStatusToolBar()

/** 里面存放所有的按钮 */
@property (nonatomic, strong) NSMutableArray *btns;
/** 里面存放所有的分割线 */
@property (nonatomic, strong) NSMutableArray *dividers;

@property (nonatomic, weak) UIButton *repostBtn;
@property (nonatomic, weak) UIButton *commmentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;

@end

@implementation HWStatusToolBar

-(NSMutableArray *)btns
{
    if (!_btns) {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}
-(NSMutableArray *)dividers
{
    if (!_dividers) {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}

+ (instancetype)toolBar
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        // 添加按钮
        self.repostBtn =  [self setupBtn:@"timeline_icon_retweet" title:@"转发"];
        self.commmentBtn =  [self setupBtn:@"timeline_icon_comment" title:@"评论"];
         self.attitudeBtn = [self setupBtn:@"timeline_icon_unlike" title:@"赞"];
        
        // 添加分割线
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}
/**
 *  添加分割线
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}

/**
 *  初始一个按钮
 *
 *  @param imageTilte 图片名字
 *  @param title      标题文字
 */
- (UIButton *)setupBtn:(NSString *)imageTilte title:(NSString *)title
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitleColor:rgb(152, 151, 152) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [btn setImage:[UIImage imageNamed:imageTilte] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitle:title forState:UIControlStateNormal];
    [self addSubview:btn];
    [self.btns addObject:btn];
    
    return btn;
    
}
/**
 *  布局界面
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count = self.subviews.count;
    CGFloat btnH = self.height;
    for (int i = 0; i<count ; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = self.width/3;
        btn.x = i *self.width/3;
        btn.height = btnH;
    }
    
    // 设置分割线的frame
    NSInteger dividerCount = self.dividers.count;
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 1;
        divider.height = btnH;
        divider.x = (i + 1) * self.width/3;
        divider.y = 0;
    }
}

- (void)setStatus:(HWStatus *)status
{
    _status = status;
    // 转发
    [self setupBtnCount:status.reposts_count btn:self.repostBtn title:@"转发"];
    // 评论
    [self setupBtnCount:status.comments_count btn:self.commmentBtn title:@"评论"];
    // 赞
    [self setupBtnCount:status.attitudes_count btn:self.attitudeBtn title:@"赞"];

    
}

- (void)setupBtnCount:(NSInteger)count btn:(UIButton *)btn title:(NSString *)title
{
    if (count) { // 有数字
        if (count >= 10000) {
            double wan = count/10000.0;
            title = [NSString stringWithFormat:@"%.1f万",wan/10000];
            // 将字符串里面出现.0去掉
            [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }else {
            title = [NSString stringWithFormat:@"%ld",count];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    } else { // 没有数字
        [btn setTitle:title forState:UIControlStateNormal];
    }
}























@end
