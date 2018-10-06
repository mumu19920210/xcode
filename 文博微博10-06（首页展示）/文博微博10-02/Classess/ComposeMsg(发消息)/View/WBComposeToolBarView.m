//
//  WBComposeToolBarView.m
//  文博微博
//
//  Created by 胡文博 on 2018/3/7.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBComposeToolBarView.h"

@implementation WBComposeToolBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background_os7"]];
    
    // 1. 添加5个按钮
    [self addBtnImageName:@"compose_camerabutton_background" selectedImageName:@"compose_camerabutton_background_highlighted" tag:WBComposeToolBarButtonCamere];
    [self addBtnImageName:@"compose_toolbar_picture" selectedImageName:@"compose_toolbar_picture_highlighted" tag:WBComposeToolBarButtonPicture];
    [self addBtnImageName:@"compose_emoticonbutton_background" selectedImageName:@"compose_emoticonbutton_background_highlighted" tag:WBComposeToolBarButtonEmoticon];
    [self addBtnImageName:@"compose_mentionbutton_background" selectedImageName:@"compose_mentionbutton_background_highlighted" tag:WBComposeToolBarButtonMention];
    [self addBtnImageName:@"compose_trendbutton_background" selectedImageName:@"compose_trendbutton_background_highlighted" tag:WBComposeToolBarButtonTrend];
    
    return self;
}

// 添加按钮
- (void)addBtnImageName:(NSString *)name selectedImageName:(NSString *)selectedName tag:(WBComposeToolBarButtonType)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    
    btn.tag = tag;
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedName] forState:UIControlStateHighlighted];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

// 按钮的单击事件
- (void)btnClick:(UIButton *)button
{
    
    WBLog(@"-----%d", [self.delegate respondsToSelector:@selector(WBComposeToolBarViewDidButtonClick:)]);
    
    if ([self.delegate respondsToSelector:@selector(WBComposeToolBarViewDidButtonClick:)]) {
        [self.delegate WBComposeToolBarViewDidButtonClick:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.width / self.subviews.count;
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *button = self.subviews[i];
        button.width = width;
        button.height = self.height;
        button.x = width * i;
        button.y = 0;
    }
}

@end
