//
//  News.m
//  新闻
//
//  Created by AlexFeng on 15/9/1.
//  Copyright (c) 2015年 AlexFeng. All rights reserved.
//

#import "News.h"
#import "NetworkTools.h"

@implementation News

+ (instancetype)newsWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    
    NSArray *propertis = @[@"title", @"digest", @"replyCount", @"imgsrc"];
    
    
    for (NSString *key in propertis)
    {
        // 判断 dict 是否存在 key
        if (dict[key] != nil)
        {
            [obj setValue:dict[key] forKeyPath:key];
        }
    }
//    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (NSString *)description
{
    NSArray *propertis = @[@"title", @"digest", @"replyCount", @"imgsrc"];
    NSDictionary *dict = [self dictionaryWithValuesForKeys:propertis];
    
    return [NSString stringWithFormat:@"<%@: %p> %@", self.class, self, dict];
}


+ (void)loadNewsListWithURLString:(NSString *)urlString
{
    [[NetworkTools sharedNetworkTools] GET:urlString parameters:nil success:^(NSURLSessionDataTask * task, NSDictionary *responseObject) {
        
        NSLog(@"%@", responseObject.keyEnumerator.nextObject);
        // 根据key 来拉倒第一个数组
        NSArray *array = responseObject[responseObject.keyEnumerator.nextObject];
        
        // 字典转模型
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
        
        for (NSDictionary *obj in array)
        {
            [arrayM addObject:[self newsWithDict:obj]];
        }
        
        NSLog(@"%@", arrayM);
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        
        NSLog(@"%@", error);
    }];
}

@end
