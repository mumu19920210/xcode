//
//  WBStatusTableViewCell.h
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/5.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStatusFrame;

NS_ASSUME_NONNULL_BEGIN

@interface WBStatusTableViewCell : UITableViewCell
/** WBStatusFrame */
@property (nonatomic, strong) WBStatusFrame *statusFrame;

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
