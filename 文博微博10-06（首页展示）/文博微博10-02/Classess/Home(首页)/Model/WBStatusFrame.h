//
//  WBStatusFrame.h
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/5.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStatus, WBOriginalViewFrame, WBRetWeetedFrame, WBFooterViewFrame;

NS_ASSUME_NONNULL_BEGIN

@interface WBStatusFrame : NSObject
/** WBStatus */
@property (nonatomic, strong) WBStatus *status;
/** FoolterViewFrame */
@property (nonatomic, strong) WBFooterViewFrame *foolterViewFrame;
/** OriginalViewFrame */
@property (nonatomic, strong) WBOriginalViewFrame *originalViewFrame;
/** RetWeetedViewFrame */
@property (nonatomic, strong) WBRetWeetedFrame *retWeetedViewFrame;
@end

NS_ASSUME_NONNULL_END
