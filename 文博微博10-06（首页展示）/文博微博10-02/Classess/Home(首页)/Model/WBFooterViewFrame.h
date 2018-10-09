//
//  WBFooterViewFrame.h
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/7.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBStatus;

NS_ASSUME_NONNULL_BEGIN

@interface WBFooterViewFrame : NSObject
/** WBStatus */
@property (nonatomic, strong) WBStatus *footerViewStatus;
/** footerViewY */
@property (nonatomic, assign) CGFloat footerViewY;
/** self.frame */
@property (nonatomic, assign) CGRect frame;
@end

NS_ASSUME_NONNULL_END
