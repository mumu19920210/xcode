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
    
    // 将前tabBar分成5等份
    [self setupTabBarFivePart];
    
    // 给加号按钮设置frame
    [self setupPlusBtnFrame];
}

// 给加号按钮设置frame
- (void)setupPlusBtnFrame
{
    self.plusBtn.height = self.plusBtn.currentBackgroundImage.size.height;
    self.plusBtn.width = self.plusBtn.currentBackgroundImage.size.width;
    self.plusBtn.center = CGPointMake(self.width * 0.5, self.height * 0.5);
}

// 将前tabBar分成5等份
- (void)setupTabBarFivePart
{
    NSUInteger allTabBarBtnCount = self.items.count + 1;
    
    NSUInteger index = 0;
    for (UIView *tabBarBtn in self.subviews) {
        if (![tabBarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        tabBarBtn.width = self.width / allTabBarBtnCount;
        tabBarBtn.height = self.height;
        if (index >= 2) {
            tabBarBtn.x = tabBarBtn.width * (index + 1);
        } else {
            tabBarBtn.x = tabBarBtn.width * index;
        }
        tabBarBtn.y = 0;
        
        index++;
    }
}

@end
