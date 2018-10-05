//
//  AppDelegate.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/24.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "AppDelegate.h"
#import "WBChooseRootViewControllerTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    WBLog(@"%@", NSHomeDirectory());
    
    // 1. 创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    // 2. 设置主窗口并显示
    [self.window makeKeyAndVisible];
    
    // 3. 设置窗口的根控制器
    [WBChooseRootViewControllerTool chooseRootViewController];
    
    // 4. 监控全局的网络
    [self setupCheckNetwork];
    
    return YES;
}
// 4. 监控全局的网络
- (void)setupCheckNetwork
{
    AFNetworkReachabilityManager *manage = [AFNetworkReachabilityManager sharedManager];
    [manage startMonitoring];
    
    [manage setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                WBLog(@"无网络");
                [MBProgressHUD showError:@"无网络"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                WBLog(@"数据");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                WBLog(@"WIFI");
                break;
            case AFNetworkReachabilityStatusUnknown:
                WBLog(@"未知网络");
                [MBProgressHUD showError:@"未知网络"];
                break;
        }
    }];
}

@end
