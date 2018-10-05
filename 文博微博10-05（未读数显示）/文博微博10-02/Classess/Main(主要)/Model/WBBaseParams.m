//
//  WBBaseParams.m
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/5.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBBaseParams.h"
#import "WBAccountTool.h"
#import "WBAccount.h"

@implementation WBBaseParams

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    self.access_token = [WBAccountTool account].access_token;
    
    return self;
}

+ (instancetype)params
{
    return [[self alloc] init];
}

@end
