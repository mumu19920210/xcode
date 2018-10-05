//
//  WBHttpTool.m
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/4.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBHttpTool.h"
#import "AFNetworking.h"

@implementation WBHttpTool
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
