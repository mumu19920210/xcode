//
//  WBNetworkingTool.m
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/5.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBNetworkingTool.h"
#import "WBHttpTool.h"
#import "MJExtension.h"

@implementation WBNetworkingTool
+ (void)get:(NSString *)url params:(id)params resultClass:(Class)cls success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure
{
    [WBHttpTool get:url params:[params mj_keyValues] success:^(id  _Nonnull responseObj) {
        if (success) {
            success([cls mj_objectWithKeyValues:responseObj]);
        }
    } failure:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
