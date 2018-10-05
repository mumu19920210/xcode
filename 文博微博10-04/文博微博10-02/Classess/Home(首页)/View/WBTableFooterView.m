//
//  WBTableFooterView.m
//  文博微博
//
//  Created by 胡文博 on 2018/3/1.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBTableFooterView.h"

@interface WBTableFooterView ()
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *pullGrayView;
@end

@implementation WBTableFooterView

+ (instancetype)footerView
{
    NSString *footViewString = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:footViewString bundle:nil];
    return [[nib instantiateWithOwner:nil options:nil] lastObject];
    
//    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil] lastObject];
}

- (void)start
{
    [self.pullGrayView startAnimating];
    _refreshStatus = YES;
}
- (void)stop
{
    [self.pullGrayView stopAnimating];
    _refreshStatus = NO;
}

@end
