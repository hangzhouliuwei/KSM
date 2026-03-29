//
//  PPIDFVManagerTools.m
//  LuckyLoan
//
//  Created by jacky on 2024/2/30.
//

#import "PPIDFVManagerTools.h"

@implementation PPIDFVManagerTools

+ (NSString *)ppConfiggetIDFV
 
{

    NSString * const KEY_USERNAME = @"FlexiLend.phone";
    NSString * const KEY_PASSWORD = @"FlexiLend.pass";
    
    NSMutableDictionary *readUserDataDic = (NSMutableDictionary *)[PPIDFVManagerTools load:KEY_USERNAME];
    
    
    if (!readUserDataDic)
    {
        
        NSString *deviceIdStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        
        NSMutableDictionary *needSaveDataDic = [NSMutableDictionary dictionaryWithObject:deviceIdStr forKey:KEY_PASSWORD];
        [PPIDFVManagerTools save:KEY_USERNAME data:needSaveDataDic];
        
        return deviceIdStr;
    }
    else{return [readUserDataDic objectForKey:KEY_PASSWORD];}
}
 
+ (void)save:(NSString *)service data:(id)data
{
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    
    //Delete old item before add new item
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id)kSecValueData];
    
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
}
 
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys: (__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass, service, (__bridge id)kSecAttrService, service, (__bridge id)kSecAttrAccount, (__bridge id)kSecAttrAccessibleAfterFirstUnlock,(__bridge id)kSecAttrAccessible, nil];
}

//loadservice

+ (id)load:(NSString *)service
{
    id ret = nil;
    
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    
    //Configure the search setting
    
    //Since in our simple
    [keychainQuery setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    
    CFDataRef keyData = NULL;
    
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr)
    {
        @try
        {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        }
        @catch (NSException *e)
        {NSLog(@"Unarchive of %@ failed: %@", service, e);}
        @finally
        {}
    }
    
    if (keyData)
        CFRelease(keyData);
    
    return ret;
}
 
//delete
+ (void)delete:(NSString *)service
{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}

@end
