//
//  WBDetailViewFrame.h
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/5.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBStatus;

NS_ASSUME_NONNULL_BEGIN

@interface WBOriginalViewFrame : NSObject

/** WBStatus */
@property (nonatomic, strong) WBStatus *status;

/** iconFrame */
@property (nonatomic, assign) CGRect iconFrame;

/** nameFrame */
@property (nonatomic, assign) CGRect nameFrame;

/** timeFrame */
@property (nonatomic, assign) CGRect timeFrame;

/** sourceFrame */
@property (nonatomic, assign) CGRect sourceFrame;

/** textFrame */
@property (nonatomic, assign) CGRect textFrame;

/** frame */
@property (nonatomic, assign) CGRect frame;

@end

NS_ASSUME_NONNULL_END
