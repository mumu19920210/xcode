//
//  WBDetailViewFrame.h
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/8.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBOriginalViewFrame, WBRetWeetedFrame, WBStatus;

NS_ASSUME_NONNULL_BEGIN

@interface WBDetailViewFrame : NSObject
/** WBStatus */
@property (nonatomic, strong) WBStatus *detailViewStatus;
/** WBOriginalViewFrame */
@property (nonatomic, strong) WBOriginalViewFrame *originalViewFrame;
/** WBRetWeetedFrame */
@property (nonatomic, strong) WBRetWeetedFrame *retWeetedViewFrame;
/** self.frame */
@property (nonatomic, assign) CGRect frame;
@end

NS_ASSUME_NONNULL_END
