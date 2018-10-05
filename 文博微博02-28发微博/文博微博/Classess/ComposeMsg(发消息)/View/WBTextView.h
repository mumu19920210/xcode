//
//  WBTextView.h
//  文博微博
//
//  Created by 胡文博 on 2018/3/7.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBTextView : UITextView
/** placeHolder */
@property (nonatomic, copy) NSString *placeHolder;
/** placeHolderColor */
@property (nonatomic, strong) UIColor *placeHolderColor;
@end
