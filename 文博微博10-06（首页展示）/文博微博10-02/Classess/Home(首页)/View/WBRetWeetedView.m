//
//  WBRetWeetedView.m
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/5.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBRetWeetedView.h"
#import "WBRetWeetedFrame.h"
#import "WBStatus.h"

@interface WBRetWeetedView()
@property (nonatomic, weak) UIButton *nameBtn;
@property (nonatomic, weak) UILabel *retWeetedTextLabel;
@end

@implementation WBRetWeetedView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupContentView];
    }
    
    return self;
}

- (void)setupContentView
{
    // 1. 转发人
    UIButton *nameBtn = [[UIButton alloc] init];
    self.nameBtn = nameBtn;
    [self addSubview:nameBtn];
    
    // 2. 转发内容
    UILabel *retWeetedTextLabel = [[UILabel alloc] init];
    self.retWeetedTextLabel = retWeetedTextLabel;
    [self addSubview:retWeetedTextLabel];
}

- (void)setRetWeetedFrame:(WBRetWeetedFrame *)retWeetedFrame
{
    _retWeetedFrame = retWeetedFrame;
    
    WBStatus *status = _retWeetedFrame.retWeetedStatus;
    WBUser *user = status.user;
    
    // 1. 转发人
    [self.nameBtn setTitle:user.name forState:UIControlStateNormal];
    [self.nameBtn setTitle:user.name forState:UIControlStateHighlighted];
    self.nameBtn.frame = _retWeetedFrame.nameBtnFrame;
    
    // 2. 转发内容
    self.retWeetedTextLabel.text = status.text;
    self.retWeetedTextLabel.frame = _retWeetedFrame.retWeetedTextLabelFrame;
    
    // 3. self.frame
    self.frame = _retWeetedFrame.frame;
}

@end
