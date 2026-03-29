//
//  PPCacheConfigManager.h
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPCacheConfigManager : NSObject

+ (void)setStr:(NSString *)object forKey:(NSString *)key;
+ (NSString *)getStr:(NSString *)key;

+ (void)setObject:(id)object forKey:(NSString *)key;
+ (void)setConfigObject:(NSString *)config forKey:(NSString *)key;
+ (void)deleteObject:(NSString *)key;
+ (id)getObjectForKey:(NSString *)key;
+ (void)setSexObject:(NSString *)sex forKey:(NSString *)key;
+ (void)setPhoneObject:(NSString *)phone forKey:(NSString *)key;
+ (void)setNameObject:(NSString *)name forKey:(NSString *)key;
+ (void)setSettingObject:(NSString *)set forKey:(NSString *)key;
+ (void)setUserObject:(NSString *)user forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
