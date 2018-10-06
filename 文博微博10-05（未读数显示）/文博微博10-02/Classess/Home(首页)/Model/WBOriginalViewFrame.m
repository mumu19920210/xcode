//
//  WBDetailViewFrame.m
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/5.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBOriginalViewFrame.h"
#import "WBStatus.h"

@implementation WBOriginalViewFrame
- (void)setStatus:(WBStatus *)status
{
    _status = status;
    
    // 1. iconFrame
    UIImage *img = [UIImage imageNamed:_status.user.profile_image_url];
    CGFloat iconX = kHomeStatusCellMargin;
    CGFloat iconY = iconX;
    CGFloat iconW = img.size.width;
    CGFloat iconH = iconW;
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 2. nameFrame
    CGFloat nameX = CGRectGetMaxX(_iconFrame) + kHomeStatusCellMargin;
    CGFloat nameY = iconY;
    CGFloat nameW = [_status.user.name sizeWithAttributes: @{NSFontAttributeName: WBHomeStatusNameLabelFont}].width;
    CGFloat nameH = [_status.user.name sizeWithAttributes: @{NSFontAttributeName: WBHomeStatusNameLabelFont}].height;
    _nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    // 3. timeFrame
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(_nameFrame) + kHomeStatusCellMargin;
    CGFloat timeW = [_status.created_at sizeWithAttributes: @{NSFontAttributeName: WBHomeStatusTimeLabelFont}].width;
    CGFloat timeH = [_status.created_at sizeWithAttributes: @{NSFontAttributeName: WBHomeStatusTimeLabelFont}].height;
    _timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    
    // 4. sourceFrame
    CGFloat sourceX = CGRectGetMaxX(_timeFrame) + kHomeStatusCellMargin;
    CGFloat sourceY = timeY;
    CGFloat sourceW = [_status.source sizeWithAttributes: @{NSFontAttributeName: WBHomeStatusSourceLabelFont}].width;
    CGFloat sourceH = [_status.source sizeWithAttributes: @{NSFontAttributeName: WBHomeStatusSourceLabelFont}].height;
    _sourceFrame = CGRectMake(sourceX, sourceY, sourceW, sourceH);
    
    // 5. textFrame
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(_nameFrame) + kHomeStatusCellMargin;
    CGFloat textW = [_status.text sizeWithAttributes: @{NSFontAttributeName: WBHomeStatusTimeLabelFont}].width;
    CGFloat textH = [_status.text sizeWithAttributes: @{NSFontAttributeName: WBHomeStatusTimeLabelFont}].height;
    _timeFrame = CGRectMake(textX, textY, textW, textH);
    
    // 6. self.frame
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(self.textFrame) + kHomeStatusCellMargin;
    CGFloat w = kScreenWidth;
    CGFloat h = 40;
    _frame = CGRectMake(x, y, w, h);
}
@end
