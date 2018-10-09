//
//  WBFooterView.m
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/5.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBFooterView.h"
#import "WBFooterViewFrame.h"
#import "WBStatus.h"

@interface WBFooterView()
@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, weak) UIButton *commentsBtn;
@property (nonatomic, weak) UIButton *repostsBtn;
@property (nonatomic, weak) UIButton *attitudesBtn;
@end

@implementation WBFooterView

- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupContentView];
    }
    return self;
}

// 设置其内部视图
- (void)setupContentView
{
    self.userInteractionEnabled = YES;
    
    self.image = [UIImage imageNamed:@"timeline_card_bottom_background"].remakeImage;
    
    // 1. 3个button按钮 转发、评论、赞
    self.repostsBtn = [self addBtnWithTitle:@"转发" imgStr:@"timeline_icon_retweet"];
    [self.repostsBtn addTarget:self action:@selector(repostsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.commentsBtn = [self addBtnWithTitle:@"评论" imgStr:@"timeline_icon_comment"];
    [self.commentsBtn addTarget:self action:@selector(commentsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.attitudesBtn = [self addBtnWithTitle:@"赞" imgStr:@"timeline_icon_unlike"];
    [self.attitudesBtn addTarget:self action:@selector(attitudesBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 2. 2个下划线
    
}

#pragma mark - 按钮的单击事件
- (void)repostsBtnClick
{
    WBLog(@"repostsBtnClick");
}

- (void)commentsBtnClick
{
    WBLog(@"commentsBtnClick");
}

- (void)attitudesBtnClick
{
    WBLog(@"attitudesBtnClick");
}

- (UIButton *)addBtnWithTitle:(NSString *)title imgStr:(NSString *)imgStr
{
    UIButton *btn = [[UIButton alloc] init];
    
    btn.titleLabel.font = WBHomeStatusRetWeetCommentUlikeBtnLabelFont;
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [btn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateHighlighted];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted"].remakeImage forState:UIControlStateHighlighted];
    
    btn.adjustsImageWhenHighlighted = NO;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [self.btns addObject:btn];
    
    [self addSubview:btn];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.btns.count;
    CGFloat btnW = kScreenWidth / count;
    for (int i = 0; i < count; i++) {
        UIButton *btn = (UIButton *)self.btns[i];
        CGFloat btnX = i * btnW;
        CGFloat btnY = 0;
        CGFloat btnH = self.height;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

- (void)setFooterViewFrame:(WBFooterViewFrame *)footerViewFrame
{
    _footerViewFrame = footerViewFrame;
    self.frame = _footerViewFrame.frame;
    
    WBStatus *status = _footerViewFrame.footerViewStatus;
    // 1. 小于等于10000显示全，大于则显示xx.x万，整数则不要小数点
    NSInteger comments_count = status.comments_count; // 评论数
    if (comments_count) {
        [self.commentsBtn setTitle:[self stringWithCount:comments_count] forState:UIControlStateNormal];
    }
    NSInteger reposts_count = status.reposts_count; // 转发数
    if (reposts_count) {
        [self.repostsBtn setTitle:[self stringWithCount: reposts_count] forState:UIControlStateNormal];
    }
    NSInteger attitudes_count = status.attitudes_count; // 点赞数
    if (attitudes_count) {
        [self.attitudesBtn setTitle:[self stringWithCount: attitudes_count] forState:UIControlStateNormal];
    }
}

// 小于等于10000显示全，大于则显示xx.x万，整数则不要小数点
- (NSString *)stringWithCount:(NSInteger )count
{
    if (count < 10000) {
        return [NSString stringWithFormat:@"%zd", count];
    } else {
        return [[NSString stringWithFormat:@"%.1f万", count / 10000.0] stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
}

@end
