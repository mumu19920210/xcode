//
//  WBTabBar.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/26.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBTabBar.h"

@interface WBTabBar ()
@property(nonatomic, weak) UIButton *plusBtn;
@end

@implementation WBTabBar

- (instancetype)init
{
    if (self = [super init]) {
        
        // 给中间添加一个plus按钮
        UIButton *plusBtn = [[UIButton alloc] init];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
        
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateNormal];
        
        [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)plusBtnClick
{
    // 弹出发消息控制器
    if ([self.tabBarDelegate respondsToSelector:@selector(WBTabBarDidPlusBtnClick)]) {
        [self.tabBarDelegate WBTabBarDidPlusBtnClick];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 切换tabBar文字颜色
//    [self setupTabBarLabelColor];
    
    // 将前tabBar分成5等份
    [self setupTabBarFivePart];
    
    // 给加号按钮设置frame
    [self setupPlusBtnFrame];
    
    // 设置tabBar在选中和普通状态下的文字颜色
    [self setupTextColor];
}

// 设置tabBar在选中和普通状态下的文字颜色
- (void)setupTextColor
{
    // 1.可以设置tabBar的主题颜色；2、可以直接设置在不同状态下的颜色
    // 2.
    
}

// 给加号按钮设置frame
- (void)setupPlusBtnFrame
{
    self.plusBtn.height = self.plusBtn.currentBackgroundImage.size.height;
    self.plusBtn.width = self.plusBtn.currentBackgroundImage.size.width;
    self.plusBtn.center = CGPointMake(self.center.x, self.plusBtn.height * 0.5);
}

// 将前tabBar分成5等份
- (void)setupTabBarFivePart
{
    
    NSUInteger part = 5;
    NSUInteger index = 0;
    
    for (UIView *tabBarBtn in self.subviews) {
        if (![tabBarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        tabBarBtn.y = 0;
        tabBarBtn.width = self.width / part;
        tabBarBtn.height = self.height;
        if (index >= 2) {
            tabBarBtn.x = tabBarBtn.width * (index + 1);
        } else {
            tabBarBtn.x = tabBarBtn.width * index;
        }
        
        index++;
    }
}

//// 切换tabBar文字颜色
//- (void)setupTabBarLabelColor
//{
//    NSUInteger index = 0;
//
//    // 更改tabBar中的样式
//    for (UIView *child in self.subviews) {
//        if (![child isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
//
//        for (UIView *childChild in child.subviews) {
//            Class buttonLabel = NSClassFromString(@"UITabBarButtonLabel");
//
//            if ([childChild isKindOfClass:buttonLabel]) {
//                UILabel *label = (UILabel *)childChild;
//                label.font = [UIFont systemFontOfSize:10];
//
//                label.textColor = [UIColor orangeColor];
//
//                NSUInteger selectedIndex = [self.items indexOfObject:self.selectedItem];
//                if (selectedIndex == index) {
//                    label.textColor = [UIColor orangeColor];
//                } else{
//                    label.textColor = [UIColor blackColor];
//                }
//            }
//        }
//
//        index++;
//    }
//}

@end
