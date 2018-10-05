//
//  WBTitleBtn.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/25.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBTitleBtn.h"

@implementation WBTitleBtn

- (instancetype)init
{
    if (self = [super init]) {
        
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.titleLabel.font = WBNavigationThemeFont;
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.imageView.contentMode = UIViewContentModeCenter;
        
        // 高亮的时候不需要调整内部图片为灰色
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageW = imageH;
    CGFloat imageX = contentRect.size.width - imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleH = contentRect.size.height;
    CGFloat titleW = contentRect.size.width - titleH;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    
    self.width = titleSize.width + self.imageView.width + 10;
}

@end
