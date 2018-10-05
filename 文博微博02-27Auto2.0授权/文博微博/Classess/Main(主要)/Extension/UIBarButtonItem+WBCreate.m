//
//  UIBarButtonItem+WBCreate.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/24.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "UIBarButtonItem+WBCreate.h"

@implementation UIBarButtonItem (WBCreate)
+ (UIBarButtonItem *)createWithImgName:(NSString *)imgName selectedImgName:(NSString *)selectedImgName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectedImgName] forState:UIControlStateHighlighted];
    button.size = [button currentImage].size;
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return btnItem;
}
@end
