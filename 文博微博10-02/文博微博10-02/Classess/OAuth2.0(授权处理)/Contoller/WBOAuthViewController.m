//
//  WBOAuthViewController.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/27.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBOAuthViewController.h"
#import "WBChooseRootViewControllerTool.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
#import "AFNetworking.h"

@interface WBOAuthViewController () <UIWebViewDelegate>

@end

@implementation WBOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取未授权的Requestion token
    [self setupLoginWebView];
}

// 获取未授权的Requestion token
- (void)setupLoginWebView
{
    UIWebView *loginView = [[UIWebView alloc] init];
    loginView.delegate = self;
    [self.view addSubview:loginView];
    loginView.frame = self.view.bounds;
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", kWBClient_ID, kWBRedirect_URI];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [loginView loadRequest:request];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 拿到这个code
    NSString *requestString = request.URL.absoluteString;
    NSRange subStringFromRange = [requestString rangeOfString:[NSString stringWithFormat:@"%@/?code=", kWBRedirect_URI]];
    if (subStringFromRange.length != 0 || subStringFromRange.location != NSNotFound) {
        NSString *code = [requestString substringFromIndex:subStringFromRange.location + subStringFromRange.length];
        
        // 获取AccessToken
        [self setupReceiveAccessTokenWithCode:code];
    }
    
    return YES;
}

// 获取AccessToken
- (void)setupReceiveAccessTokenWithCode:(NSString *)code
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = kWBClient_ID;
    params[@"client_secret"] = kWBClient_Secret;
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = kWBRedirect_URI;
    params[@"code"] = code;
    
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        WBAccount *account = [WBAccount mj_objectWithKeyValues:responseObject];
        
        [WBAccountTool save:account];
        
        // 回到首页或者新特性界面
        // 判断版本新特性
        [WBChooseRootViewControllerTool chooseViewController];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        WBLog(@"请求失败, %zd, %@", error.code, error.userInfo);
    }];
}

@end
