//
//  NetworkTools.h
//  新闻
//
//  Created by AlexFeng on 15/8/31.
//  Copyright (c) 2015年 AlexFeng. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface NetworkTools : AFHTTPSessionManager

/**
 *  全局接口
 */
+ (instancetype)sharedNetworkTools;

@end
