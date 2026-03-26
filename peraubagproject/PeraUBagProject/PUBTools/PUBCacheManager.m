//
//  PUBCacheManager.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/15.
//

#import "PUBCacheManager.h"

@interface PUBCacheManager()
///内存缓存，kill掉程序或超出设置的最大缓存则清除
@property (nonatomic, strong) NSCache *memoryCache;

@end

@implementation PUBCacheManager
SINGLETON_M(PUBCacheManager)

- (NSCache *)memoryCache{
    if (!_memoryCache) {
        _memoryCache = [[NSCache alloc] init];
        _memoryCache.countLimit = 1000;       //设置内存最大缓存1000条，超出则自动清除
    }
    return _memoryCache;
}

- (NSString *)getPath{
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/userCMSLC"];
//    DLog(@"local cache path:%@------------",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

//新增
- (NSString *)getPathWithDirectory:(NSString *)directory
{
    NSString *tempPath = [@"/Documents/" stringByAppendingString:[NSString stringWithFormat:@"%@",directory]];
    NSString *path = [NSHomeDirectory() stringByAppendingString:tempPath];
    NSLog(@"local cache path:%@------------",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}


- (NSString *)getPathWithKey:(NSString *)key{
    return [NSString stringWithFormat:@"%@/%@.xdlc",[self getPath],key];
}
//新增
- (NSString *)getPathWithKey:(NSString *)key andDicretory:(NSString *)directory{
    return [NSString stringWithFormat:@"%@/%@.xdlc",[self getPathWithDirectory:directory],key];
}

/**
 *  缓存数据
 *
 *  @param object 需要缓存的对象
 *  @param key    唯一标识，也作为文件名
 */
- (BOOL)cacheCMSObject:(id<NSCoding>)object withKey:(NSString *)key{
    
    if (!key || [key isEqualToString:@""]) {
        NSLog(@"缓存key不能为空！！");
        return NO;
    }
    if (object) {
        NSMutableData *data = [NSMutableData data];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:object forKey:[NSString stringWithFormat:@"%@shyy",key]];
        [archiver finishEncoding];
       return  [data writeToFile:[self getPathWithKey:key] atomically:YES];
    }
    return NO;
}

/**
 *  缓存数据
 *
 *  @param object 需要缓存的对象
 *  @param key    唯一标识，也作为文件名
  *  @param path  可以根据路径来存储
 */
- (void)cacheCMSObject:(id<NSCoding>)object withKey:(NSString *)key andDirectory:(NSString *)path{
    if (!key || [key isEqualToString:@""]) {
        NSLog(@"缓存key不能为空！！");
        return;
    }
    if (object) {
        NSMutableData *data = [NSMutableData data];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:object forKey:[NSString stringWithFormat:@"%@shyy",key]];
        [archiver finishEncoding];
        [data writeToFile:[self getPathWithKey:key andDicretory:path] atomically:YES];
    }
    
}

/**
 *  取出缓存
 *
 *  @return 返回缓存对象
 */
- (id)getcacheCMSObjectWithKey:(NSString *)key;{
    
    if (!key || [key isEqualToString:@""]) {
        NSLog(@"缓存key不能为空！！");
        return nil;
    }
    NSMutableData *data = [NSMutableData dataWithContentsOfFile:[self getPathWithKey:key]];
    if (data && ![data isKindOfClass:[NSNull class]]) {
        NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        return [unArchiver decodeObjectForKey:[NSString stringWithFormat:@"%@shyy",key]];
    }
    return nil;
}

/**
 *  新增根据目录来取缓存
 *
 *  @return 返回缓存对象
 */

- (id)getcacheCMSObjectWithKey:(NSString *)key andDirectory:(NSString *)path{
    if (!key || [key isEqualToString:@""]) {
        NSLog(@"缓存key不能为空！！");
        return nil;
    }
    NSMutableData *data = [NSMutableData dataWithContentsOfFile:[self getPathWithKey:key andDicretory:path]];
    if (data && ![data isKindOfClass:[NSNull class]]) {
        NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        return [unArchiver decodeObjectForKey:[NSString stringWithFormat:@"%@shyy",key]];
    }
    return nil;
}

- (void)removecacheCMSWithKey:(NSString *)key{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    if ([fileManager fileExistsAtPath:[self getPathWithKey:key]]) {
        [fileManager removeItemAtPath:[self getPathWithKey:key] error:&error];
        if (error) {
            NSLog(@"remove cache error = %@",error);
        }
    }else{
        NSLog(@"无对应文件！");
    }
}


/**
 *  根据对应的key删除磁盘缓存
 *
 *  @param key  唯一标识，也作为文件名
 *  @param path 自定义下document的路径
 */
- (void)removecacheCMSObjectWithKey:(NSString *)key andDirectory:(NSString *)path{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    if ([fileManager fileExistsAtPath:[self getPathWithKey:key andDicretory:path]]) {
        [fileManager removeItemAtPath:[self getPathWithKey:key andDicretory:path]error:&error];
        if (error) {
    
            NSLog(@"remove cache error = %@",error);
        }
    }else{
        NSLog(@"无对应文件！");
    }
}

/**
 *  移除某个目录下所有文件
 *
 *  @param path  目录
 */
- (void)removeaAllcacheCMSWithDirectory:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    [fileManager removeItemAtPath:[self getPathWithDirectory:path] error:&error];
    if (error) {
        NSLog(@"remove cache error = %@",error);
    }
}

/**
 *  删除所有的磁盘缓存
 *
 */
- (void)removeAllcacheCMS{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    [fileManager removeItemAtPath:[self getPath] error:&error];
    if (error) {
        NSLog(@"remove cache error = %@",error);
    }
}


- (void)memorycacheCMSObject:(id)object withKey:(NSString *)key{
    NSLog(@"设置---->%@,%@",object,key);
    [self.memoryCache setObject:object forKey:key];
}

- (id)getMemorycacheCMSObjectWithKey:(NSString *)key{
    NSLog(@"缓存中---->%@,%@",[self.memoryCache objectForKey:key],key);
    return [self.memoryCache objectForKey:key];
}

#pragma mark - NSCacheDelegate
- (void)cache:(NSCache *)cache willEvictObject:(id)obj{
    NSLog(@"清除了---->%@",obj);
}


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
