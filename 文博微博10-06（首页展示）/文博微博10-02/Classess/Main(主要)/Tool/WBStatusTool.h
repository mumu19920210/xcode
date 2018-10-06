//
//  WBStatusTool.h
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/4.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBReadStatusParams.h"
#import "WBReadStatusResult.h"
#import "WBNoReadStatusParams.h"
#import "WBNoReadStatusResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface WBStatusTool : NSObject

// 读取微博数据
+ (void)readStatusWithPatams:(WBReadStatusParams *)params success:(void (^)(WBReadStatusResult *result))success failure:(void (^)(NSError *error))failure;

// 未读取微博数据
+ (void)noReadStatusWithPatams:(WBNoReadStatusParams *)params success:(void (^)(WBNoReadStatusResult *result))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
