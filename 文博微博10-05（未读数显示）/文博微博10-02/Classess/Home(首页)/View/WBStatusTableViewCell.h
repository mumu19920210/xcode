//
//  WBStatusTableViewCell.h
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/5.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStatus;

NS_ASSUME_NONNULL_BEGIN

@interface WBStatusTableViewCell : UITableViewCell
/** WBStatus */
@property (nonatomic, strong) WBStatus *status;
@end

NS_ASSUME_NONNULL_END
