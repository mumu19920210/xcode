//
//  WBAccountTool.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/27.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBAccountTool.h"
#import "WBAccount.h"
#import <objc/runtime.h>

#define kWBFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]
#define kAccountData &"kAccountData"

@implementation WBAccountTool
+ (void)save:(WBAccount *)account
{
    // 将account存储在沙盒中
    [NSKeyedArchiver archiveRootObject:account toFile:kWBFilepath];
    
    if (!account) return;
    
//    NSData *accountData = [NSKeyedArchiver archivedDataWithRootObject:account requiringSecureCoding:YES error:nil];
//    objc_setAssociatedObject(@"accountData", kAccountData, accountData, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

+ (WBAccount *)account
{
    WBAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:kWBFilepath];
    
//    NSSet *accountClassSet = [NSSet setWithObject:[WBAccount class]];
//    NSData *accountData = objc_getAssociatedObject(@"accountData", kAccountData);
//    WBAccount *account = [NSKeyedUnarchiver unarchivedObjectOfClasses:accountClassSet fromData:accountData error:nil];
    
    NSDate *now = [NSDate date];
    if ([now compare:account.expires_time] == NSOrderedDescending) {
        account = nil;
    }
    
    return account;
}
@end
