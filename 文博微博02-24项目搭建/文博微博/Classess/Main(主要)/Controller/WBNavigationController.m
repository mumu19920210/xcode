//
//  WBNavigationController.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/24.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBNavigationController.h"

@interface WBNavigationController ()

@end

@implementation WBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (void)initialize
{
    // 设置主题
//    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
//    NSMutableDictionary *appearaceAttrs = [NSMutableDictionary dictionary];
//    appearaceAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
//    appearaceAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
//    [appearance setTitleTextAttributes:appearaceAttrs forState:UIControlStateNormal];
//    
//    NSMutableDictionary *appearaceHighAttrs = [NSMutableDictionary dictionary];
//    appearaceHighAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
//    appearaceHighAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
//    [appearance setTitleTextAttributes:appearaceHighAttrs forState:UIControlStateHighlighted];
//    
//    NSMutableDictionary *appearaceDisableAttrs = [NSMutableDictionary dictionary];
//    appearaceDisableAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
//    appearaceDisableAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    [appearance setTitleTextAttributes:appearaceDisableAttrs forState:UIControlStateDisabled];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        // 隐藏tabBar底部栏
        viewController.hidesBottomBarWhenPushed = YES;
        // 替换左右两个按钮，功能左返回上一层，右直接回到顶部
        
        // 1. 创建左按钮
        UIBarButtonItem *leftBtnItem = [UIBarButtonItem createWithImgName:@"navigationbar_back" selectedImgName:@"navigationbar_back_highlighted" target:self action:@selector(jumpToPop)];
        viewController.navigationItem.leftBarButtonItem = leftBtnItem;
        
        // 2. 创建右按钮
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem createWithImgName:@"navigationbar_more" selectedImgName:@"navigationbar_more_highlighted" target:self action:@selector(jumpToRoot)];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)jumpToPop
{
    [self popViewControllerAnimated:YES];
}

- (void)jumpToRoot
{
    [self popToRootViewControllerAnimated:YES];
}

@end
