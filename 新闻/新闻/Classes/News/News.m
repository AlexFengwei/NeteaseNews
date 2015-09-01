//
//  News.m
//  新闻
//
//  Created by AlexFeng on 15/9/1.
//  Copyright (c) 2015年 AlexFeng. All rights reserved.
//

#import "News.h"
#import "NetworkTools.h"
#import <objc/runtime.h>

@implementation News

+ (instancetype)newsWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    
    NSArray *propertis = [self loadPropertis];
    
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

// 动态加载类的属性
const char *kPropertis = "kPropertis";
+ (NSArray *)loadPropertis
{
    // 利用关联对象, 动态给类添加属性
    NSArray *pList = objc_getAssociatedObject(self, kPropertis);
    if (pList != nil)
    {
//        NSLog(@"%@", pList);
        return pList;
    }
    
    // 属性计数指针
    unsigned int count = 0;
    objc_property_t *list = class_copyPropertyList([self class], &count);
    
    NSMutableArray *arryM = [NSMutableArray arrayWithCapacity:count];
    
//    NSLog(@"属性数量 %u", count);
    for (unsigned int i = 0; i < count; ++i)
    {
        objc_property_t pty = list[i];
        
        const char *cname = property_getName(pty);
        
        [arryM addObject:[NSString stringWithUTF8String:cname]];
    }
    
    NSLog(@"%@", arryM);
    
    free(list);
    
    objc_setAssociatedObject(self, kPropertis, arryM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return arryM.copy;
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
