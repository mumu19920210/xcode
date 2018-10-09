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
- (void)setOriginalStastus:(WBStatus *)originalStastus
{
    _originalStastus = originalStastus;
    
    // 1. iconFrame
    CGFloat iconX = kHomeStatusCellMargin;
    CGFloat iconY = iconX;
    CGFloat iconW = 35;
    CGFloat iconH = iconW;
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 2. nameFrame
    CGFloat nameX = CGRectGetMaxX(_iconFrame) + kHomeStatusCellMargin;
    CGFloat nameY = iconY * 0.8;
    CGFloat nameW = [_originalStastus.user.name sizeWithAttributes: @{NSFontAttributeName: WBHomeStatusNameLabelFont}].width;
    CGFloat nameH = [_originalStastus.user.name sizeWithAttributes: @{NSFontAttributeName: WBHomeStatusNameLabelFont}].height;
    _nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    
    // 3. timeFrame
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(_nameFrame) + kHomeStatusCellMargin * 0.5;
    CGFloat timeW = [_originalStastus.created_at sizeWithAttributes: @{NSFontAttributeName: WBHomeStatusTimeLabelFont}].width;
    CGFloat timeH = [_originalStastus.created_at sizeWithAttributes: @{NSFontAttributeName: WBHomeStatusTimeLabelFont}].height;
    _timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    
    // 4. sourceFrame
    CGFloat sourceX = CGRectGetMaxX(_timeFrame) + kHomeStatusCellMargin;
    CGFloat sourceY = timeY;
    CGFloat sourceW = [_originalStastus.source sizeWithAttributes: @{NSFontAttributeName: WBHomeStatusSourceLabelFont}].width;
    CGFloat sourceH = [_originalStastus.source sizeWithAttributes: @{NSFontAttributeName: WBHomeStatusSourceLabelFont}].height;
    _sourceFrame = CGRectMake(sourceX, sourceY, sourceW, sourceH);
    
    // 5. textFrame
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(_timeFrame) + kHomeStatusCellMargin;
    CGSize maxSize = CGSizeMake(kScreenWidth - 2 * kHomeStatusCellMargin, MAXFLOAT);
    CGSize textSize = [_originalStastus.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: WBHomeStatusTimeLabelFont} context:nil].size;
    CGFloat textW = textSize.width;
    CGFloat textH = textSize.height + kHomeStatusCellMargin;
    _textFrame = CGRectMake(textX, textY, textW, textH);
    
    // 6. self.frame
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = kScreenWidth;
    CGFloat h = CGRectGetMaxY(self.textFrame);
    _frame = CGRectMake(x, y, w, h);
}
@end
