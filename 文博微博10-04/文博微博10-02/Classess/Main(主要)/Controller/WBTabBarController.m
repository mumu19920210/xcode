//
//  WBTabBarController.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/24.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBTabBarController.h"
#import "WBHomeViewController.h"
#import "WBMessageViewController.h"
#import "WBDiscoverViewController.h"
#import "WBProfileViewController.h"
#import "WBNavigationController.h"
#import "WBTabBar.h"
#import "WBComposeViewController.h"

@interface WBTabBarController () <UITabBarControllerDelegate, WBTabBarDelegate>
@end

@implementation WBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    
    // 创建孩子控制器
    [self addChildVc];
    
    // 更改tabBar控件
    WBTabBar *tabBar = [[WBTabBar alloc] init];
    tabBar.tabBarDelegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
}

// 创建孩子控制器
- (void)addChildVc
{
    // 1. 添加首页
    WBHomeViewController *home = [[WBHomeViewController alloc] init];
    [self addVc:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    // 2. 添加消息
    WBMessageViewController *message = [[WBMessageViewController alloc] init];
    [self addVc:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    // 3. 添加发现
    WBDiscoverViewController *discover = [[WBDiscoverViewController alloc] init];
    [self addVc:discover title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    // 4. 添加我
    WBProfileViewController *profile = [[WBProfileViewController alloc] init];
    [self addVc:profile title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
}

- (void)addVc:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 添加导航控制器
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 设置选中、正常状态的颜色（与badgeValue类似）
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [vc.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    NSMutableDictionary *hightedAttrs = [NSMutableDictionary dictionary];
    hightedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    hightedAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [vc.tabBarItem setTitleTextAttributes:hightedAttrs forState:UIControlStateSelected];
    
    // 防止图片在iOS7以上的系统再次渲染
    UIImage *image = [UIImage imageNamed:selectedImageName];
    if (iOS7 >= 7.0) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    vc.tabBarItem.selectedImage = image;
    
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

#pragma mark - UITabBarControllerDelegate

#pragma mark - WBTabBarDelegate
- (void)WBTabBarDidPlusBtnClick
{
    WBComposeViewController *composeVc = [[WBComposeViewController alloc] init];
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:composeVc];
    [self presentViewController:nav animated:YES completion:NULL];
}
@end
