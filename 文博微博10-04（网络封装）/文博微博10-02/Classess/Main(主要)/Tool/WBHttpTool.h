//
//  WBHttpTool.h
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/4.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBHttpTool : NSObject
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
