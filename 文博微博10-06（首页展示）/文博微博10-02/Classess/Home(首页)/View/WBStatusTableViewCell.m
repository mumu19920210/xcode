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

+ (instancetype)cellWithTabelView:(UITableView *)tableView
{
    static NSString *statusTableViewcellID = @"statusTableViewcellID";
    
    WBStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:statusTableViewcellID];
    if (!cell) {
        cell = [[WBStatusTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:statusTableViewcellID];
    }
    return cell;
}

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

- (void)setStatusFrame:(WBStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    self.detailView.detailViewFrame = _statusFrame;
}

@end
