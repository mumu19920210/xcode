//
//  WBRetWeetedFrame.h
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/5.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBStatus;

NS_ASSUME_NONNULL_BEGIN

@interface WBRetWeetedFrame : NSObject

@property (nonatomic, assign) CGRect nameBtnFrame;
@property (nonatomic, assign) CGRect retWeetedTextLabelFrame;
/** self.frame */
@property (nonatomic, assign) CGRect frame;

/** RetWeetedStatus */
@property (nonatomic, strong) WBStatus *retWeetedStatus;
@end

NS_ASSUME_NONNULL_END
