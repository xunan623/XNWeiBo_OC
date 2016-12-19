//
//  HWUser.m
//  XNWeiBo
//
//  Created by 许楠 on 15/10/5.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWUser.h"

@implementation HWUser

-(void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    self.vip = mbtype > 2;
}


@end
