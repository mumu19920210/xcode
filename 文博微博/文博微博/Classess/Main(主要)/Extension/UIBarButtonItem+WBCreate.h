//
//  UIBarButtonItem+WBCreate.h
//  文博微博
//
//  Created by 胡文博 on 2018/2/24.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WBCreate)
+ (UIBarButtonItem *)createWithImgName:(NSString *)imgName selectedImgName:(NSString *)selectedImgName target:(id)target action:(SEL)action;
@end
