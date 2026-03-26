//
//  PTCacheManager.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/15.
//

#import "PTCacheManager.h"
#import <YYCache/YYCache.h>

@implementation PTCacheManager
SINGLETON_M(PTCacheManager)

/// 用YYcache 做缓存
/// @param object <#object description#>
/// @param key <#key description#>
- (void)cacheYYObject:(id<NSCoding>)object withKey:(NSString *)key{
    if (!key || [key isEqualToString:@""]) {
        NSLog(@"缓存key不能为空！！");
        return;
    }
    if (object) {
        YYCache * cache = [YYCache cacheWithName:key];
        [cache setObject:object forKey:key];
    }
}

/// 取出缓存
/// @param key 缓存key
- (id)getcacheYYObjectWithKey:(NSString *)key{
    if (!key || [key isEqualToString:@""]) {
        NSLog(@"缓存key不能为空！！");
        return nil;
    }
    YYCache * cache = [YYCache cacheWithName:key];
    if (![cache containsObjectForKey:key]) {
        return nil;
    }
    return [cache objectForKey:key];
}

/// 对应的key删除缓存
/// @param key  唯一标识，也作为文件名
- (void)removecacheYYWithKey:(NSString *)key{
    
    YYCache * cache = [YYCache cacheWithName:key];
    if ([cache containsObjectForKey:key]) {
        [cache removeObjectForKey:key];
    }else{
        NSLog(@"无对应文件！");
    }
}

/// 删除YYCache所有缓存
- (void)removeAllYYcache{
    
    YYCache * cache = [YYCache cacheWithName:@""];
    [cache removeAllObjects];
}

@end
