//
//  WBChooseImageView.m
//  文博微博
//
//  Created by 胡文博 on 2018/3/7.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBChooseImageView.h"

@interface WBChooseImageView ()
/** imageArray */
@property (nonatomic, strong) NSMutableArray *imageArray;
@end

@implementation WBChooseImageView

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
}

@end
