//
//  NetworkTools.m
//  新闻
//
//  Created by AlexFeng on 15/8/31.
//  Copyright (c) 2015年 AlexFeng. All rights reserved.
//

#import "NetworkTools.h"

@implementation NetworkTools

+ (instancetype)sharedNetworkTools
{
    static NetworkTools *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/nc/article/headline/"];
        instance = [[self alloc] initWithBaseURL:url];
    });
    return instance;
}

@end
