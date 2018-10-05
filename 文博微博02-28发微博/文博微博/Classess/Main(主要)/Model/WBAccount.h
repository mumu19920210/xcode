//
//  WBAccount.h
//  文博微博
//
//  Created by 胡文博 on 2018/2/27.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBAccount : NSObject <NSCoding>
/** 用户授权的唯一票据 */
@property (nonatomic, copy) NSString *access_token;
/** access_token的生命周期，单位是秒数 */
@property (nonatomic, copy) NSString *expires_in;
/** 授权用户的UID */
@property (nonatomic, copy) NSString *uid;

/** 过期时间 */
@property (nonatomic, strong) NSDate *expires_time;
@end
