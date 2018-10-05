//
//  WBStatusTool.m
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/4.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBStatusTool.h"
#import "WBNetworkingTool.h"

@implementation WBStatusTool

+ (void)readStatusWithPatams:(WBReadStatusParams *)params success:(void (^)(WBReadStatusResult * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure
{
    [WBNetworkingTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params resultClass:[WBReadStatusResult class] success:success failure:failure];
}

+ (void)noReadStatusWithPatams:(WBNoReadStatusParams *)params success:(void (^)(WBNoReadStatusResult * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure
{
    [WBNetworkingTool get:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:params resultClass:[WBNoReadStatusResult class] success:success failure:failure];
}

@end
