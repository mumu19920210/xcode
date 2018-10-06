//
//  WBStatusTableViewCell.m
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/5.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBStatusTableViewCell.h"
#import "WBDetailView.h"
#import "WBFooterView.h"

@interface WBStatusTableViewCell()
@property (nonatomic, weak) WBDetailView *detailView;
@property (nonatomic, weak) WBFooterView *footerView;
@end

@implementation WBStatusTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    // 1. 内容
    WBDetailView *detailView = [[WBDetailView alloc] init];
    [self.contentView addSubview:detailView];
    self.detailView = detailView;
    // 2. 底部
    WBFooterView *footerView = [[WBFooterView alloc] init];
    [self.contentView addSubview:footerView];
    self.footerView = footerView;
    
    return self;
}

- (void)setStatus:(WBStatus *)status
{
    _status = status;
    
//    self.detailView.deta = status;
}

@end
