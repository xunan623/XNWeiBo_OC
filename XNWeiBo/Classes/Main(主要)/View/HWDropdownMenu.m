//
//  HWDropdownMenu.m
//  XNWeiBo
//
//  Created by 许楠 on 15/9/7.
//  Copyright (c) 2015年 CLT. All rights reserved.
//

#import "HWDropdownMenu.h"
@interface HWDropdownMenu()
/**
 *  将来用来显示具体内容的容器
 */
@property(nonatomic,strong)UIImageView *containerView;

@end

@implementation HWDropdownMenu

-(UIImageView *)containerView {
    if (!_containerView) {
        //添加灰色图片控件
        UIImageView *containerView = [[UIImageView alloc] init];
        _containerView.image = [UIImage imageNamed:@"popover_background"];
        _containerView.x = self.window.width/2+50;
        _containerView.y = 50;
        _containerView.width = 217;
        _containerView.height = 300;
        _containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //清除颜色
        self.backgroundColor = [UIColor clearColor];
        _containerView = [[UIImageView alloc] init];
        _containerView.image = [UIImage imageNamed:@"popover_background"];
        _containerView.userInteractionEnabled = YES;
        [self addSubview:_containerView];

    }

    return self;
}

+(instancetype)menu {
    return [[self alloc] init];
}

-(void)setContentController:(UIViewController *)contentController {
    _contentController = contentController;
    self.content = contentController.view;
}

-(void)setContent:(UIView *)content
{
    _content = content;
    content.x = 10;
    content.y = 15;
    
    //调整内容的宽度
//    content.width = self.containerView.width - 2 * content.x;
    
    //设置灰色的高度
    self.containerView.height = CGRectGetMaxY(content.frame) + 11;
    
    self.containerView.width = CGRectGetMaxX(content.frame) +10;
    
    //添加内容到灰色图片中
    [self.containerView addSubview:content];
}

/**
 *  显示
 */
- (void)showFrom:(UIView *)from
{
    //1.获取最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    //2.添加自己到窗口上
    [window addSubview:self];
    //3.设置尺寸
    self.frame = window.bounds;
    //默认情况下,frame是以父控件左上角为坐标原点
    //可以通过转换坐标系原点,改变frame的参照点
    /**
     *  [from.superview convertRect:from.frame toView:window]
     ====
     [from convertRect:from.bounds toView:window]
     */
    CGRect newFrame =  [from.superview convertRect:from.frame toView:window];
    //4.调整灰色图片的位置
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
    
    //通知外界  自己显示了
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }
}
/**
 *  销毁
 */
-(void)dismiss{
    [self removeFromSuperview];
    //通知外界销毁 3
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}
















@end
