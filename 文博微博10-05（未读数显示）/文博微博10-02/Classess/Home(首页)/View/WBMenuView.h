//
//  WBMenuView.h
//  文博微博
//
//  Created by 胡文博 on 2018/2/25.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WBMenuViewDelegate <NSObject>

@optional
- (void)WBMenuViewDidCoverClick;

@end

@interface WBMenuView : UIView
// 初始化方法
- (instancetype)initWithContentView:(UIView *)contentView;
+ (instancetype)menuWithContentView:(UIView *)contentView;
// 显示菜单
- (void)showInRect:(CGRect)rect;
// 隐藏菜单
- (void)dismiss;

// 模板的单击事件回调方法
@property(nonatomic, weak) id<WBMenuViewDelegate> delegate;
@end
