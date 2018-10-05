//
//  WBTableFooterView.h
//  文博微博
//
//  Created by 胡文博 on 2018/3/1.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBTableFooterView : UIView
/** 刷新的状态 */
@property (nonatomic, assign, getter=isRefreshStatus) BOOL refreshStatus;

+ (instancetype)footerView;

- (void)start;
- (void)stop;
@end
