//
//  HWTitleMenuViewController.m
//  XNWeiBo
//
//  Created by 许楠 on 15/9/7.
//  Copyright (c) 2015年 CLT. All rights reserved.
//

#import "HWTitleMenuViewController.h"

@interface HWTitleMenuViewController ()

@end

@implementation HWTitleMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"好友";
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"米有";
    }
    else if (indexPath.row == 2) {
        cell.textLabel.text = @"顺友";
    }
    return cell;
}

@end
