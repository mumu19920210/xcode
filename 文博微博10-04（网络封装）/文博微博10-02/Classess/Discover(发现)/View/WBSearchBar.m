//
//  WBSearchBar.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/25.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBSearchBar.h"

@interface WBSearchBar()

@end

@implementation WBSearchBar
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 设置背景图片
        self.background = [UIImage imageRemakeImageWithName:@"searchbar_textfield_background"];
        // 设置文本左对齐、垂直居中
        self.textAlignment = NSTextAlignmentLeft;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        UIImageView *leftView = [[UIImageView alloc] init];
        leftView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        CGFloat Margin = 10;
        leftView.width = leftView.image.size.width + Margin;
        leftView.height = leftView.image.size.height;
        leftView.contentMode = UIViewContentModeCenter;
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        // 设置右边清楚按钮永远显示
        self.clearButtonMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (instancetype)searchBar
{
    return [[self alloc] init];
}
@end
