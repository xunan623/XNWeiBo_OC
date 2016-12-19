//
//  HWTest1ViewController.m
//  XNWeiBo
//
//  Created by 许楠 on 15/9/6.
//  Copyright (c) 2015年 CLT. All rights reserved.
//

#import "HWTest1ViewController.h"
#import "HWTest2ViewController.h"

@interface HWTest1ViewController ()

@end

@implementation HWTest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    HWTest2ViewController *test2 = [[HWTest2ViewController alloc] init];
    test2.title = @"测试2控制器";
    [self.navigationController pushViewController:test2 animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
