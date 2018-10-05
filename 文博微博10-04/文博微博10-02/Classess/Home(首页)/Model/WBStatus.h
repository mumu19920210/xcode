//
//  WBStatuses.h
//  文博微博
//
//  Created by 胡文博 on 2018/2/27.
//  Copyright © 2018年 胡文博. All rights reserved.
//  所有的微博数据

#import <Foundation/Foundation.h>

// 配图
@interface WBPictures : NSObject
/** 微博配图ID。 */
@property (nonatomic, copy) NSObject *thumbnail_pic;
@end

// 微博用户
@interface WBUser : NSObject
/** 字符串型的用户UID */
@property (nonatomic, copy) NSString *idstr;
/** 用户昵称 */
@property (nonatomic, copy) NSString *screen_name;
/** 友好显示名称 */
@property (nonatomic, copy) NSString *name;
/** 用户头像地址（中图）,50×50像素 */
@property (nonatomic, copy) NSString *profile_image_url;
@end

// 微博
@interface WBStatus : NSObject
/** 微博创建时间 */
@property (nonatomic, copy) NSString *created_at;
/** 字符串型的微博ID */
@property (nonatomic, copy) NSString *idstr;
/** 微博信息内容 */
@property (nonatomic, copy) NSString *text;
/** 微博来源 */
@property (nonatomic, copy) NSString *source;
/** 缩略图片地址，没有时不返回此字段 */
@property (nonatomic, copy) NSString *thumbnail_pic;
/** 中等尺寸图片地址，没有时不返回此字段 */
@property (nonatomic, copy) NSString *bmiddle_pic;
/** 原始图片地址，没有时不返回此字段 */
@property (nonatomic, copy) NSString *original_pic;
/** 地理信息字段 */
//@property (nonatomic, strong) object *geo;
/** 微博作者的用户信息字段 */
@property (nonatomic, strong) WBUser *user;
/** 被转发的原微博信息字段，当该微博为转发微博时返回 */
@property (nonatomic, strong) WBStatus *retweeted_status;
/** 转发数 */
@property (nonatomic, assign) NSInteger reposts_count;
/** 评论数 */
@property (nonatomic, assign) NSInteger comments_count;
/** 表态数 */
@property (nonatomic, assign) NSInteger attitudes_count;
/** 微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。 */
@property (nonatomic, strong) NSArray *pic_ids;
@end
