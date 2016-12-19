//
//  HWTest2ViewController.m
//  XNWeiBo
//
//  Created by 许楠 on 15/9/6.
//  Copyright (c) 2015年 CLT. All rights reserved.
//

#import "HWTest2ViewController.h"
#import "HWTest3ViewController.h"

@interface HWTest2ViewController ()

@end

@implementation HWTest2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"cesho" style:UIBarButtonItemStyleDone target:nil action:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    HWTest3ViewController *test3 = [[HWTest3ViewController alloc] init];
    test3.title = @"测试3控制器";
    [self.navigationController pushViewController:test3 animated:YES];
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
