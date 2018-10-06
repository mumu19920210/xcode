//
//  WBRetWeetedFrame.m
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/5.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBRetWeetedFrame.h"
#import "WBStatus.h"

@implementation WBRetWeetedFrame

- (void)setRetWeetedStatus:(WBStatus *)retWeetedStatus
{
    _retWeetedStatus = retWeetedStatus;
    
    // 1. nameBtnFrame
    CGFloat nameBtnX = kHomeStatusCellMargin;
    CGFloat nameBtnY = kHomeStatusCellMargin;
    CGFloat nameBtnW = [retWeetedStatus.user.name sizeWithAttributes:@{NSFontAttributeName: WBHomeStatusNameLabelFont}].width;
    CGFloat nameBtnH = [retWeetedStatus.user.name sizeWithAttributes:@{NSFontAttributeName: WBHomeStatusNameLabelFont}].height;
    _nameBtnFrame = CGRectMake(nameBtnX, nameBtnY, nameBtnW, nameBtnH);
    
    // 2. retWeetedTextLabelFrame
    CGFloat retWeetedTextLabelX = nameBtnX;
    CGFloat retWeetedTextLabelY = CGRectGetMaxY(_nameBtnFrame) + kHomeStatusCellMargin;
    CGSize maxSize = CGSizeMake(kScreenWidth - 2 * kHomeStatusCellMargin, MAXFLOAT);
    CGRect adjustStatusTextRect = [retWeetedStatus.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: WBHomeStatusNameLabelFont} context:nil];
    CGFloat retWeetedTextLabelW = adjustStatusTextRect.size.width;
    CGFloat retWeetedTextLabelH = adjustStatusTextRect.size.height;
    _retWeetedTextLabelFrame = CGRectMake(retWeetedTextLabelX, retWeetedTextLabelY, retWeetedTextLabelW, retWeetedTextLabelH);}

@end
