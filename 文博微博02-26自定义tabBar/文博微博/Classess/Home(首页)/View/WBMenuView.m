//
//  WBMenuView.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/25.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBMenuView.h"

@interface WBMenuView()
@property(nonatomic, weak) UIButton *cover;
@property(nonatomic, weak) UIImageView *container;

@property (nonatomic, weak) UIView *contentView;
@end

@implementation WBMenuView

// 初始化方法
- (instancetype)initWithContentView:(UIView *)contentView
{
    if (self = [super init]) {
        
        // 创建cover（背后隐藏的盖板）
        UIButton *cover = [[UIButton alloc] init];
        self.cover = cover;
        [self addSubview:cover];
        [cover addTarget:self action:@selector(hideMe) forControlEvents:UIControlEventTouchUpInside];
        // 创建菜单
        UIImageView *container = [[UIImageView alloc] init];
        self.container = container;
        container.image = [UIImage imageRemakeImageWithName:@"popover_background"];
        [self addSubview:container];
        
        // 将contentView添加在菜单里
        [self addSubview:contentView];
        self.contentView = contentView;
    }
    return self;
}
+ (instancetype)menuWithContentView:(UIView *)contentView
{
    return [[self alloc] initWithContentView:contentView];
}

// 内部方法
- (void)hideMe
{
    [self dismiss];
    
    if ([self.delegate respondsToSelector:@selector(WBMenuViewDidCoverClick)]) {
        [self.delegate WBMenuViewDidCoverClick];
    }
}

- (void)layoutSubviews
{
    self.cover.frame = self.bounds;
    
    self.contentView.frame = self.container.bounds;
}

// 显示菜单
- (void)showInRect:(CGRect)rect
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    self.frame = window.bounds;
    
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    self.container.frame = CGRectMake(x, y, w, h);

}
// 隐藏菜单
- (void)dismiss
{
    [self removeFromSuperview];
}

@end
