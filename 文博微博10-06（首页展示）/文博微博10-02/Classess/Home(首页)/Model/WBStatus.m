//
//  WBStatuses.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/27.
//  Copyright © 2018年 胡文博. All rights reserved.
//  所有的微博数据

#import "WBStatus.h"

@implementation WBPictures

@end

@implementation WBUser

@end

@implementation WBStatus

// _created_at在get方法中，值是固定的，不能重新赋值 _created_at = [dft stringFromDate:createdStatusDate] 这是错误的
- (NSString *)created_at // 此方法在get时，可以调用无数次
{
    // 利用NSString -> NSDate -> NSString
    if ([_created_at containsString:@"+0800"]) {
        
        NSDateFormatter *dft = [[NSDateFormatter alloc] init];
        dft.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
        NSDate *createdStatusDate = [dft dateFromString:_created_at];
        dft.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        return [dft stringFromDate:createdStatusDate];
    }
    
    // 获得当天的日期对象
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDateComponents *compnents = [[NSDateComponents alloc] init];
//    compnents.calendar = calendar;
//    NSLog(@"====%zd", compnents.day);
    
    return _created_at;
}

- (void)setSource:(NSString *)source // 在设置值时，只调用一次
{
    // <a href="http://app.weibo.com/t/feed/6vtZb0" rel="nofollow">微博 weibo.com</a>
    // 截取> 后面的部分，以及</前面的部分
    NSRange subRange;
    
    if ([source containsString:@">"]) {
        subRange.location = [source rangeOfString:@">"].location + 1;
        subRange.length = [source rangeOfString:@"</"].location - subRange.location;
        if (subRange.length && source.length) {
            source = [source substringWithRange:subRange];
        }
    }
    
    _source = source;
}
@end
