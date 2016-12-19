//
//  HWOAuthViewController.m
//  XNWeiBo
//
//  Created by 许楠 on 15/9/16.
//  Copyright (c) 2015年 CLT. All rights reserved.
//

#import "HWOAuthViewController.h"
#import <AFNetworking.h>
#import "HWTabBarViewController.h"
#import "NewFeatureViewController.h"
#import "HWAccount.h"
#import "MBProgressHUD+MJ.h"
#import "HWAccountTool.h"

@interface HWOAuthViewController () <UIWebViewDelegate>

@end

@implementation HWOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建一个webView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    //2.用webView加载登录页面(新浪提供的)
    //请求地址https://api.weibo.com/oauth2/authorize
    /*
        请求参数:client_id
                redirect_uri
     */
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3226443203&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
#pragma mark webView
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUD];
}
-(void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"web加载");
    [MBProgressHUD showMessage:@"正在加载..."];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    NSLog(@"%@",request.URL.absoluteString);
//拦截UIL
    NSString *usl = request.URL.absoluteString;
    //判断是否是回调地址
    NSRange range = [usl rangeOfString:@"code="];
    if (range.length!=0) {
        //截取后面的参数值
        long fromIndex = range.location + range.length;
        NSString *code =[usl substringFromIndex:fromIndex];
        HWLog(@"%@ %@",code,usl);
        //利用code换取一个accessToken
        [self accessTokenWithCode:code];
        
        // 禁止加载回调地址
        return NO;
    }
    return YES;
}
/**
 *  利用code(授权成功后的requset token)换取一个accessToken
 *
 *  @return
 */
#pragma mark 请求网络accessToken
-(void)accessTokenWithCode:(NSString *)code
{
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"3226443203";
    params[@"client_secret"] = @"2fb53596126fe23b4b09523f1365bb8a";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://www.baidu.com";
    //创建字典
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    //2.拼接请求参数
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD hideHUD];
        //access_token = 2.00jldJMEVQp2WD69f63d3cf2Y8GAiD
        HWLog(@"请求成功%@",responseObject);
       
        HWAccount *account = [HWAccount accountWithDict:responseObject];
        //存储账号信息
        [HWAccountTool saveAccount:account];
    
        //切换根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        
        //UIWindow的分类 WindowTool
        //UIViewController的分类 HWControllerTool
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
        HWLog(@"请求失败%@",error);
    }];

}

@end
