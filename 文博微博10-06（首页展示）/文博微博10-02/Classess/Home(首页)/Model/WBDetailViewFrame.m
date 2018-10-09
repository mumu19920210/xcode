//
//  WBDetailViewFrame.m
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/8.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBDetailViewFrame.h"
#import "WBOriginalViewFrame.h"
#import "WBRetWeetedFrame.h"
#import "WBStatus.h"

@implementation WBDetailViewFrame
- (void)setDetailViewStatus:(WBStatus *)detailViewStatus
{
    _detailViewStatus = detailViewStatus;
    
    // 1. originalViewFrame
    self.originalViewFrame = [[WBOriginalViewFrame alloc] init];
    self.originalViewFrame.originalStastus = _detailViewStatus;

    // 2. retWeetedViewFrame
    self.retWeetedViewFrame = [[WBRetWeetedFrame alloc] init];
    self.retWeetedViewFrame.retWeetedStatus = _detailViewStatus.retweeted_status;
    
    // 3. retweeted自己的frame
    CGRect retweetedFrame = _retWeetedViewFrame.frame;
    CGFloat retweetedY = retweetedFrame.origin.y;
    if (_detailViewStatus.retweeted_status) {
        retweetedY += CGRectGetMaxY(_originalViewFrame.frame);
        retweetedFrame.origin.y = retweetedY;
        _retWeetedViewFrame.frame = retweetedFrame;
    }
    
    // 4. detailViewFrame
    CGFloat detailViewX = 0;
    CGFloat detailViewY = kHomeStatusCellVerb;
    CGFloat detailViewW = kScreenWidth;
    CGFloat detailViewH = CGRectGetMaxY(_originalViewFrame.frame);
    if (_detailViewStatus.retweeted_status) {
        detailViewH = CGRectGetMaxY(_retWeetedViewFrame.frame);
    }
    self.frame = CGRectMake(detailViewX, detailViewY, detailViewW, detailViewH);
}
@end
