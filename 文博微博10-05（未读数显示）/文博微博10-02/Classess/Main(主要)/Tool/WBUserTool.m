//
//  WBUserTool.m
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/5.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBUserTool.h"
#import "WBNetworkingTool.h"

@implementation WBUserTool
+ (void)userInfoWithPatams:(WBUserInfoParams *)params success:(void (^)(WBUserInfoResult * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure
{
    //    [WBHttpTool get:@"https://api.weibo.com/2/users/show.json" params:params.mj_keyValues success:^(id responseObj){
    //        if (success) {
    //            success([WBUserInfoResult mj_objectWithKeyValues:responseObj]);
    //        }
    //    } failure:^(NSError *error){
    //        if (failure) {
    //            failure(error);
    //        }
    //    }];
    
    [WBNetworkingTool get:@"https://api.weibo.com/2/users/show.json" params:params resultClass:[WBUserInfoResult class] success:success failure:failure];
}
@end
