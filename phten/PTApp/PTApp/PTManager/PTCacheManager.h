//
//  PTCacheManager.h
//  PTApp
//
//  Created by 刘巍 on 2024/7/15.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN
#define PTCache [PTCacheManager sharedPTCacheManager]
static NSString *const KEY_FistTime = @"FistTime";
static NSString *const KEY_LoginUser = @"LoginUser";
@interface PTCacheManager : NSObject
SINGLETON_H(PTCacheManager)

/// 用YYcache 做缓存
/// @param object object description
/// @param key <#key description#>
- (void)cacheYYObject:(id<NSCoding>)object withKey:(NSString *)key;

/// 取出YYCache缓存
/// @param key 缓存key
- (id)getcacheYYObjectWithKey:(NSString *)key;

/// 对应的key删除YYCache缓存
/// @param key  唯一标识，也作为文件名
- (void)removecacheYYWithKey:(NSString *)key;


/// 删除YYCache所有缓存
- (void)removeAllYYcache;

@end

NS_ASSUME_NONNULL_END
