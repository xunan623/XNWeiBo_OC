//
//  HWStatusCell.h
//  XNWeiBo
//
//  Created by 许楠 on 15/10/9.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWStatusFrame;

#define HWCellMargin 10

@interface HWStatusCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) HWStatusFrame * statusFrame;

@end
