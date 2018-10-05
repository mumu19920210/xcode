//
//  WBTableFooterView.m
//  文博微博
//
//  Created by 胡文博 on 2018/3/1.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBTableFooterView.h"

@implementation WBTableFooterView

+ (instancetype)footerView
{
    NSString *footViewString = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:footViewString bundle:nil];
    return [[nib instantiateWithOwner:nil options:nil] lastObject];
//
//    NSBundle *mainBundle = [NSBundle mainBundle];
//    return [[mainBundle loadNibNamed:@"WBTableFooterView" owner:nil options:nil] lastObject];
}

@end
