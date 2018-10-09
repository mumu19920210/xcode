//
//  WBOriginalView.m
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/5.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBOriginalView.h"
#import "WBOriginalViewFrame.h"
#import "WBStatusFrame.h"
#import "WBStatus.h"
#import "UIImageView+WebCache.h"

@interface WBOriginalView()
@property (nonatomic, weak) UIImageView *iconImgView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *sourceLabel;
@property (nonatomic, weak) UILabel *textLabel;
@end

@implementation WBOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 1. iconimgView
        UIImageView *iconImgView = [[UIImageView alloc] init];
        [self addSubview:iconImgView];
        self.iconImgView = iconImgView;
        
        // 2. nameLabel
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = WBHomeStatusNameLabelFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 3. timeLabel
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = WBHomeStatusTimeLabelFont;
        timeLabel.textColor = WBHomeStatusTimeLabelColor;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 4. sourceLabel
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = WBHomeStatusSourceLabelFont;
        sourceLabel.textColor = WBHomeStatusSourceLabelColor;
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        // 5. textLabel
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = WBHomeStatusTextLabelFont;
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
    }
    
    return self;
}

- (void)setOriginalViewFrame:(WBOriginalViewFrame *)originalViewFrame
{
    _originalViewFrame = originalViewFrame;
    
    WBStatus *status = _originalViewFrame.originalStastus;
    WBUser *user = status.user;
    
    // 1. iconimgView
    NSURL *iconImgUrl = [NSURL URLWithString:user.profile_image_url];
    [self.iconImgView sd_setImageWithURL:iconImgUrl];
    self.iconImgView.frame = _originalViewFrame.iconFrame;
    
    // 2. nameLabel
    self.nameLabel.text = user.name;
    self.nameLabel.frame = _originalViewFrame.nameFrame;
    
    // 3. timeLabel
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = _originalViewFrame.timeFrame;
    
    // 4. sourceLabel
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = _originalViewFrame.sourceFrame;
    
    // 5. textLabel
    self.textLabel.text = status.text;
    self.textLabel.frame = _originalViewFrame.textFrame;
    
    // 6. self
    self.frame = _originalViewFrame.frame;
}

@end
