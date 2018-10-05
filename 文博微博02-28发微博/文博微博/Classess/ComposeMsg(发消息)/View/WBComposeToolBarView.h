//
//  WBComposeToolBarView.h
//  文博微博
//
//  Created by 胡文博 on 2018/3/7.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WBComposeToolBarButtonCamere = 0,
    WBComposeToolBarButtonEmoticon,
    WBComposeToolBarButtonMention,
    WBComposeToolBarButtonPicture,
    WBComposeToolBarButtonTrend,
} WBComposeToolBarButtonType;

@protocol WBComposeToolBarViewDelegate <NSObject>

@optional
- (void)WBComposeToolBarViewDidButtonClick:(WBComposeToolBarButtonType)type;

@end

@interface WBComposeToolBarView : UIView
/** delegate */
@property (nonatomic, assign) id<WBComposeToolBarViewDelegate> delegate;
@end
