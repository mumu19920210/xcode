//
//  WBTextView.m
//  文博微博
//
//  Created by 胡文博 on 2018/3/7.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBTextView.h"

@interface WBTextView () <UITextViewDelegate>
@property (nonatomic, weak) UILabel *placeholderLabel;
@end

@implementation WBTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    // 1. 创建placeholder控件，显示文本
    UILabel *placeholderLabel = [[UILabel alloc] init];
    [self addSubview:placeholderLabel];
    self.placeholderLabel = placeholderLabel;
    
    placeholderLabel.text = @"请输入文本...";
    placeholderLabel.textColor = [UIColor grayColor];
    
    self.font = [UIFont systemFontOfSize:15];
    placeholderLabel.font = self.font;
    
    placeholderLabel.x = 5;
    placeholderLabel.width = 200;
    placeholderLabel.height = 35;
    
    self.contentSize = CGSizeMake(self.width, 400);
    
    // 2. 监听TextView中文本的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textviewDidValueChange) name:UITextViewTextDidChangeNotification object:self];
    
    return self;
}

- (void)textviewDidValueChange
{
    self.placeholderLabel.hidden = self.text.length != 0;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    
    self.placeholderLabel.text = placeHolder;
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor = placeHolderColor;
    
    self.placeholderLabel.textColor = placeHolderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = self.font;
}

@end
