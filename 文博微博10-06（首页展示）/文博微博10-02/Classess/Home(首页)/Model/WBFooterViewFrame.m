//
//  WBFooterViewFrame.m
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/7.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBFooterViewFrame.h"
#import "WBStatus.h"

@implementation WBFooterViewFrame
- (void)setFooterViewStatus:(WBStatus *)footerViewStatus
{
    _footerViewStatus = footerViewStatus;
    
    CGFloat footViewX = 0;
    CGFloat footViewH = 35;
    CGFloat footViewW = kScreenWidth;
    self.frame = CGRectMake(footViewX, _footerViewY, footViewW, footViewH);
}
@end
