//
//  WBBaseParams.h
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/5.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBBaseParams : NSObject

/** access_token */
@property (nonatomic, copy) NSString *access_token;

+ (instancetype)params;

@end

NS_ASSUME_NONNULL_END
