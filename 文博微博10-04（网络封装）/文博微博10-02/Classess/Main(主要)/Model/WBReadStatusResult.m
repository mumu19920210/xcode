//
//  WBReadStatusResult.m
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/4.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBReadStatusResult.h"

@implementation WBReadStatusResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"statuses" : @"WBStatus"};
}

@end
