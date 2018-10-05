//
//  UIImage+WBExtension.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/25.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "UIImage+WBExtension.h"

@implementation UIImage (WBExtension)
- (UIImage *)remakeImage
{
    UIImage *image = nil;
    image = [self stretchableImageWithLeftCapWidth:self.size.width * 0.5 topCapHeight:self.size.height * 0.5];
    return image;
}
+ (UIImage *)imageRemakeImageWithName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    image = [image remakeImage];
    return image;
}
@end
