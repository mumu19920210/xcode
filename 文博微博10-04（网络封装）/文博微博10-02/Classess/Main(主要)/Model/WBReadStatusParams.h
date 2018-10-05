//
//  WBReadStatusParams.h
//  文博微博10-02
//
//  Created by 胡文博 on 2018/10/4.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBBaseParams.h"

NS_ASSUME_NONNULL_BEGIN

@interface WBReadStatusParams : WBBaseParams

/** since_id */
@property (nonatomic, copy) NSString *since_id;

/** max_id */
@property (nonatomic, copy) NSString *max_id;

///** count */
//@property (nonatomic, copy) NSString *count;

@end

NS_ASSUME_NONNULL_END
