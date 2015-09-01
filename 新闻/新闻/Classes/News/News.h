//
//  News.h
//  新闻
//
//  Created by AlexFeng on 15/9/1.
//  Copyright (c) 2015年 AlexFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
/**
 *  新闻标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  新闻摘要
 */
@property (nonatomic, copy) NSString *digest;
/**
 *  回复数量
 */
@property (nonatomic, assign) int replyCount;
/**
 *  图片地址
 */
@property (nonatomic, copy) NSString *imgsrc;
//@property (nonatomic, copy) NSString *haha;

+ (instancetype)newsWithDict:(NSDictionary *)dict;
/**
 *  加载指定 URL 的数组
 */
+ (void)loadNewsListWithURLString:(NSString *)urlString;

@end
