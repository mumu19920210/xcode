//
//  AppDelegate.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/24.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "AppDelegate.h"
#import "WBChooseRootViewControllerTool.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    WBLog(@"%@", NSHomeDirectory());
    
    // 1. 创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    // 2. 设置主窗口并显示
    [self.window makeKeyAndVisible];
    
    // 3. 设置窗口的根控制器
    [WBChooseRootViewControllerTool chooseRootViewController];
    
    // 4. 监控全局的网络
    [self setupCheckNetwork];
    
    // 5. 提醒用户需要在app右上角显示数字
    [self setupAppBadge];
    
    return YES;
}

// 5. 提醒用户需要在app右上角显示数字
- (void)setupAppBadge
{
    /**
     *  iOS8以后需要注册,才能将未读的数在图标右上角显示
     */
    
    UIApplication *application = [UIApplication sharedApplication];
    CGFloat kDeviceVersion = [[UIDevice currentDevice].systemVersion floatValue];
    
    if (kDeviceVersion >= 8.0) {
        // 使用本地通知 (本例中只是badge，但是还有alert和sound都属于通知类型,其实如果只进行未读数在appIcon显示,只需要badge就可, 这里全写上为了方便以后的使用)
        
//        UNAuthorizationOptions options = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
//
//        UNNotificationSettings *settings = [[UNNotificationSettings alloc] init];
//        settings.alertSetting
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        // 进行注册
        [application registerUserNotificationSettings:settings];
    }
}

// 4. 监控全局的网络
- (void)setupCheckNetwork
{
//    AFNetworkReachabilityManager *manage = [AFNetworkReachabilityManager sharedManager];
//    [manage startMonitoring];
//    
//    [manage setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusNotReachable:
//                WBLog(@"无网络");
//                [MBProgressHUD showError:@"无网络"];
//                break;
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                WBLog(@"数据");
//                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                WBLog(@"WIFI");
//                break;
//            case AFNetworkReachabilityStatusUnknown:
//                WBLog(@"未知网络");
//                [MBProgressHUD showError:@"未知网络"];
//                break;
//        }
//    }];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    __block UIBackgroundTaskIdentifier bgID = [application beginBackgroundTaskWithExpirationHandler:^{
        // 过期后调
        [application endBackgroundTask:bgID];
    }];
}

@end
