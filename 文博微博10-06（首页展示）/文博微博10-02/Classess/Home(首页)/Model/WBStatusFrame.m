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
    
    // 3. footViewFrame
    CGFloat footViewX = kHomeStatusCellMargin;
    CGFloat footViewY = kHomeStatusCellMargin;
    CGFloat footViewW = kScreenWidth - 2 * kHomeStatusCellMargin;
    CGFloat footViewH = 0;
    if (self.status.retweeted_status) {
        // 3.1 retweeted自己的frame
        CGSize maxSize = CGSizeMake(footViewW, MAXFLOAT);
        CGRect adjustStatusTextRect = [self.status.retweeted_status.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: WBHomeStatusNameLabelFont} context:nil];
        
        CGFloat reweetedViewX = kHomeStatusCellMargin;
        CGFloat reweetedViewY = CGRectGetMaxY(_originalViewFrame.frame) + kHomeStatusCellMargin;
        CGFloat reweetedViewW = adjustStatusTextRect.size.width;
        CGFloat reweetedViewH = adjustStatusTextRect.size.height;
        self.retWeetedViewFrame.frame = CGRectMake(reweetedViewX, reweetedViewY, reweetedViewW, reweetedViewH);
        
        footViewH = adjustStatusTextRect.size.height;
    }
    
    footViewY += footViewH;
    _foolterViewFrame = CGRectMake(footViewX, footViewY, footViewW, footViewH);
}

@end
