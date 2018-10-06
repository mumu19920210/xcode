//
//  WBChooseRootViewControllerTool.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/27.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBChooseRootViewControllerTool.h"
#import "WBTabBarController.h"
#import "WBNewFeatureViewController.h"
#import "WBOAuthViewController.h"
#import "WBAccount.h"
#import "WBAccountTool.h"

@implementation WBChooseRootViewControllerTool
+ (void)chooseRootViewController
{
    WBAccount *account = [WBAccountTool account];
    
    if (account) {
        // 判断版本新特性
        [self chooseViewController];
    } else {
        // 进行Oauth2.0授权
        WBOAuthViewController *oAuthVc = [[WBOAuthViewController alloc] init];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = oAuthVc;
    }
}

+ (void)chooseViewController
{
    // 判断版本新特性
    NSString *lastVersionKey = (__bridge NSString *)kCFBundleVersionKey;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:lastVersionKey];
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[lastVersionKey];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if (![currentVersion isEqualToString:lastVersion]) {
        WBNewFeatureViewController *newFeatureVc = [[WBNewFeatureViewController alloc] init];
        window.rootViewController = newFeatureVc;
        
        [defaults setObject:currentVersion forKey:lastVersionKey];
        [defaults synchronize];
    } else {
        WBTabBarController *tabBarVc = [[WBTabBarController alloc] init];
        window.rootViewController = tabBarVc;
    }
}
@end
