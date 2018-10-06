//
//  WBAccount.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/27.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBAccount.h"

@implementation WBAccount

- (instancetype)initWithCoder:(NSCoder *)encoder
{
    if (!self) return nil;
    
    self = [super init];
    self.access_token = [encoder decodeObjectForKey:@"access_token"];
    self.expires_in = [encoder decodeObjectForKey:@"expires_in"];
    self.uid = [encoder decodeObjectForKey:@"uid"];
    self.expires_time = [encoder decodeObjectForKey:@"expires_time"];
    self.screen_name = [encoder decodeObjectForKey:@"screen_name"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.screen_name forKey:@"screen_name"];
    
    if (!self.expires_time) {
        self.expires_time = [[NSDate date] dateByAddingTimeInterval:self.expires_in.doubleValue];
        [encoder encodeObject:self.expires_time forKey:@"expires_time"];
    }
}
@end
