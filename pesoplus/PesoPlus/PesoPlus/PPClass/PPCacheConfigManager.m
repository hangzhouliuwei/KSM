//
//  PPCacheConfigManager.m
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import "PPCacheConfigManager.h"

@implementation PPCacheConfigManager

+ (void)setStr:(NSString *)object forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getStr:(NSString *)key {
    NSString *value = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    return notNull(value);
}

+ (void)setObject:(id)object forKey:(NSString *)key {
    NSString *filePath = [PPCacheConfigManager getFilePath:key];
    NSError *error = nil;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object requiringSecureCoding:YES error:&error];
    if (!error) {
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        [data writeToURL:fileURL options:NSDataWritingAtomic error:&error];
    }
}

+ (void)setConfigObject:(NSString *)config forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:config forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setUserObject:(NSString *)user forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:user forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setSettingObject:(NSString *)set forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:set forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setNameObject:(NSString *)name forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setPhoneObject:(NSString *)phone forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setSexObject:(NSString *)sex forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:sex forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)deleteObject:(NSString *)key {
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/PPCache/%@.plist", key]];
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:path];
    if (exists) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
}

+ (id)getObjectForKey:(NSString *)key {
    NSString *filePath = [PPCacheConfigManager getFilePath:key];
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSObject *object = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSObject class] fromData:data error:&error];
    if (error) {
        return nil;;
    } else {
        return object;;
    }
}

+ (NSString *)getFilePath:(NSString *)key {
    NSString *docPath = NSHomeDirectory();
    NSString *path = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/PPCache/%@.plist", key]];
    NSString *directory = [path stringByDeletingLastPathComponent];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:directory isDirectory:nil];
    if (!fileExists) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error];
    }
    return path;
}

@end
