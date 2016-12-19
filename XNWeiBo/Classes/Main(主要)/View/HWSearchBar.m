//
//  HWSearchBar.m
//  XNWeiBo
//
//  Created by 许楠 on 15/9/6.
//  Copyright (c) 2015年 CLT. All rights reserved.
//

#import "HWSearchBar.h"

@implementation HWSearchBar
- (instancetype)init
{
    self = [super init];
    if (self) {
        //创建搜索框
        self.font = [UIFont systemFontOfSize:16.0f];
        self.placeholder = @"请输入查找的内容";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        //左边的放大镜
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width = 30;
        searchIcon.height = 30;
        //设置图片居中
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}
+(instancetype)searchBar {
    return [[self alloc] init];
}

@end
