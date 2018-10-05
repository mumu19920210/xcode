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
//    [WBHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params.mj_keyValues success:^(id responseObj){
//        if (success) {
//            success([WBReadStatusResult mj_objectWithKeyValues:responseObj]);
//        }
//    } failure:^(NSError *error){
//        if (failure) {
//            failure(error);
//        }
//    }];
    
    [WBNetworkingTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params resultClass:[WBReadStatusResult class] success:success failure:failure];
}

@end
