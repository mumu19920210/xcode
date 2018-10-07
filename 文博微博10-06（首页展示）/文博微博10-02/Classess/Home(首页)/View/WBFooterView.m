//
//  WBFooterView.m
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/5.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBFooterView.h"
#import "WBFooterViewFrame.h"

@implementation WBFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)setFooterViewFrame:(WBFooterViewFrame *)footerViewFrame
{
    _footerViewFrame = footerViewFrame;
    self.frame = _footerViewFrame.frame;
}

@end
