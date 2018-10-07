//
//  WBStatusFrame.m
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/5.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBStatusFrame.h"
#import "WBStatus.h"
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
    // 1. originalViewFrame
    self.originalViewFrame = [[WBOriginalViewFrame alloc] init];
    self.originalViewFrame.originalStastus = _status;
    
    // 2. retWeetedViewFrame
    self.retWeetedViewFrame = [[WBRetWeetedFrame alloc] init];
    self.retWeetedViewFrame.retWeetedStatus = _status.retweeted_status;
    
    // 3 retweeted自己的frame
    CGRect retweetedFrame = _retWeetedViewFrame.frame;
    CGFloat retweetedY = retweetedFrame.origin.y;
    if (self.status.retweeted_status) {
        retweetedY += CGRectGetMaxY(_originalViewFrame.frame);
        retweetedFrame.origin.y = retweetedY;
        _retWeetedViewFrame.frame = retweetedFrame;
    }
    
    // 4. footViewFrame
    CGFloat footViewX = kHomeStatusCellMargin;
    CGFloat footViewH = 40;
    CGFloat footViewW = kScreenWidth - 2 * kHomeStatusCellMargin;
    CGFloat footViewY = CGRectGetMaxY(_originalViewFrame.textFrame) + kHomeStatusCellMargin;
    if (self.status.retweeted_status) {
        footViewY = CGRectGetMaxY(_retWeetedViewFrame.frame) + kHomeStatusCellMargin;
    }
    
    _foolterViewFrame = [[WBFooterViewFrame alloc] init];
    _foolterViewFrame.footerViewStatus = _status;
    _foolterViewFrame.frame = CGRectMake(footViewX, footViewY, footViewW, footViewH);
}

@end
