//
//  WBStatusFrame.m
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/5.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBStatusFrame.h"
#import "WBStatus.h"
#import "WBDetailViewFrame.h"
#import "WBOriginalViewFrame.h"
#import "WBRetWeetedFrame.h"
#import "WBFooterViewFrame.h"

@implementation WBStatusFrame

- (void)setStatus:(WBStatus *)status
{
    _status = status;
    
    [self setupCellFrame];
}

- (void)setupCellFrame
{
    // 1. 设置微博数据
    self.detailViewFrame = [[WBDetailViewFrame alloc] init];
    self.detailViewFrame.detailViewStatus = _status;
    
    // 2. footViewFrame
    _foolterViewFrame = [[WBFooterViewFrame alloc] init];
    CGFloat footViewY = CGRectGetMaxY(_detailViewFrame.frame);
    _foolterViewFrame.footerViewY = footViewY;
    
    _foolterViewFrame.footerViewStatus = _status;
}

@end
