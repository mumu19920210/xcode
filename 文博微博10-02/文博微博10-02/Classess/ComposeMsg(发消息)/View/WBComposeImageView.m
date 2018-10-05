//
//  WBChooseImageView.m
//  文博微博
//
//  Created by 胡文博 on 2018/3/7.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBComposeImageView.h"

@interface WBComposeImageView ()
/** imageArray */
@property (nonatomic, strong) NSMutableArray *imageArray;
@end

@implementation WBComposeImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageArray = [NSMutableArray array];
    }
    
    return self;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    [self.imageArray addObject:image];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = image;
    [self addSubview:imgView];
    imgView.frame = CGRectMake(10, 10, 100, 100);
}

@end
