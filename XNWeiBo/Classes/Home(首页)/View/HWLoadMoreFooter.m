//
//  HWLoadMoreFooter.m
//  XNWeiBo
//
//  Created by 许楠 on 15/10/8.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWLoadMoreFooter.h"

@implementation HWLoadMoreFooter

+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HWLoadMoreFooter" owner:nil options:nil] lastObject];
}

@end
