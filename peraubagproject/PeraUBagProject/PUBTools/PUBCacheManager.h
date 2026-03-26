//
//  PUBCacheManager.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define PUBCache [PUBCacheManager sharedPUBCacheManager]
static NSString  *const PUBhost = @"PUBhost";
static NSString  *const NetworkType= @"NetworkType";
static NSString  *const LoginUser = @"LoginUser";
static NSString  *const isFistAPP = @"isFistAPP";

@interface PUBCacheManager : NSObject
SINGLETON_H(PUBCacheManager)
/**
 *  缓存数据
 *
 *  @param object 需要缓存的对象
 *  @param key    唯一标识，也作为文件名
 */
- (BOOL)cacheCMSObject:(id<NSCoding>)object withKey:(NSString *)key;

/**
 *  缓存数据
 *
 *  @param object 需要缓存的对象
 *  @param key    唯一标识，也作为文件名
  *  @param path  可以根据路径来存储
 */
- (void)cacheCMSObject:(id<NSCoding>)object withKey:(NSString *)key andDirectory:(NSString *)path;

/**
 *  取出缓存
 *
 *  @return 返回缓存对象
 */
- (id)getcacheCMSObjectWithKey:(NSString *)key;

/**
 *  新增根据目录来取缓存
 *
 *  @return 返回缓存对象
 */

- (id)getcacheCMSObjectWithKey:(NSString *)key andDirectory:(NSString *)path;

/**
 *  根据对应的key删除磁盘缓存
 *
 *  @param key  唯一标识，也作为文件名
 */

- (void)removecacheCMSWithKey:(NSString *)key;


/**
 *  根据对应的key删除磁盘缓存
 *
 *  @param key  唯一标识，也作为文件名
 *  @param path 自定义下document的路径
 */
- (void)removecacheCMSObjectWithKey:(NSString *)key andDirectory:(NSString *)path;

/**
 *  移除某个目录下所有文件
 *
 *  @param path  目录
 */
- (void)removeaAllcacheCMSWithDirectory:(NSString *)path;


/**
 *  删除所有的磁盘缓存
 *
 */
- (void)removeAllcacheCMS;

/**
 *  缓存数据
 *
 *  @param object 需要缓存的对象
 *  @param key    唯一标识，也作为文件名
 */
- (void)memorycacheCMSObject:(id)object withKey:(NSString *)key;

/**
 *  取出缓存
 *
 *  @return 返回缓存对象
 */
- (id)getMemorycacheCMSObjectWithKey:(NSString *)key;

#pragma mark - 新增YYcache缓存

/// 用YYcache 做缓存
/// @param object <#object description#>
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
