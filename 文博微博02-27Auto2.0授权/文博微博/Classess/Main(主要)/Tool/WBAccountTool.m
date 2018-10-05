//
//  WBAccountTool.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/27.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBAccountTool.h"
#import "WBAccount.h"

#define kWBFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation WBAccountTool
+ (void)save:(WBAccount *)account
{
    // 将account存储在沙盒中
    [NSKeyedArchiver archiveRootObject:account toFile:kWBFilepath];
}

+ (WBAccount *)account
{
    WBAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:kWBFilepath];
    NSDate *now = [NSDate date];
    
    if ([now compare:account.expires_time] == NSOrderedDescending) {
        account = nil;
    }
    
    return account;
}
@end
