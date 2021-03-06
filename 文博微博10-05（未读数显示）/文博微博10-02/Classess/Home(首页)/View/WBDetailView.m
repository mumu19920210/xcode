//
//  WBDetailView.m
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/5.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBDetailView.h"
#import "WBOriginalView.h"
#import "WBRetWeetedView.h"
#import "WBStatusFrame.h"

@interface WBDetailView()

@property (nonatomic, weak) WBOriginalView *originalView;
@property (nonatomic, weak) WBRetWeetedView *retWeetedView;

@end

@implementation WBDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    // 1. 原创微博
    WBOriginalView *originalView = [[WBOriginalView alloc] init];
    [self addSubview:originalView];
    self.originalView = originalView;
    // 2. 转发微博
    WBRetWeetedView *retWeetedView = [[WBRetWeetedView alloc] init];
    [self addSubview:retWeetedView];
    self.retWeetedView = retWeetedView;
    
    return self;
}

- (void)setStatusFrame:(WBStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    self.originalView.originalViewFrame = _statusFrame.originalViewFrame;
    self.retWeetedView.retWeetedFrame = _statusFrame.retWeetedViewFrame;
}

@end
