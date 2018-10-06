//
//  WBUserTool.h
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/5.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBUserInfoParams.h"
#import "WBUserInfoResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface WBUserTool : NSObject
// 读取用户信息
+ (void)userInfoWithPatams:(WBUserInfoParams *)params success:(void (^)(WBUserInfoResult *result))success failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
