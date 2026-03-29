//
//  PPPhoneInfo.m
// FIexiLend
//
//  Created by jacky on 2024/11/12.
//

#import "PPHandleDevicePhoneInfo.h"
#import <AdSupport/AdSupport.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#import <sys/sysctl.h>
#import <mach/mach.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import "PPIDFVManagerTools.h"
#import <sys/utsname.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "AFNetworkReachabilityManager.h"
#import<SystemConfiguration/CaptiveNetwork.h>


@implementation PPHandleDevicePhoneInfo

+ (NSString *)mirjhaDeviceversion {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    return notNull(appVersion);
}
+ (NSString *)mirjhaDevicedeviceName {
    
    NSDictionary *dict = @{
        @"iPhone4,1" : @"iPhone 4S",
        @"iPhone3,1" : @"iPhone 4",
        @"iPhone5,2" : @"iPhone 5",
        @"iPhone6,1" : @"iPhone 5s",
        @"iPhone13,3" : @"iPhone 12 Pro",
        @"iPhone10,5" : @"iPhone 8 Plus",
        @"iPhone9,4" : @"iPhone 7 Plus",
        @"iPhone10,1" : @"iPhone 8",
        @"iPhone10,3" : @"iPhone X",
        @"iPhone11,4" : @"iPhone XS Max",
        @"iPhone3,3" : @"iPhone 4",
        @"iPhone10,6" : @"iPhone X",
        @"iPhone12,3" : @"iPhone 11 Pro",
        @"iPhone14,5" : @"iPhone 13",
        @"iPhone13,4" : @"iPhone 12 Pro Max",
        @"iPhone12,5" : @"iPhone 11 Pro Max",
        @"iPhone11,6" : @"iPhone XS Max",
        @"iPhone6,2" : @"iPhone 5s",
        @"iPhone8,1" : @"iPhone 6s",
        @"iPhone3,2" : @"iPhone 4",
        @"iPhone5,1" : @"iPhone 5",
        @"iPhone5,3" : @"iPhone 5c",
        @"iPhone8,2" : @"iPhone 6s Plus",
        @"iPhone8,4" : @"iPhone SE (1st generation)",
        @"iPhone7,2" : @"iPhone 6",
        @"iPhone7,1" : @"iPhone 6 Plus",
        @"iPhone9,1" : @"iPhone 7",
        @"iPhone5,4" : @"iPhone 5c",
        @"iPhone9,3" : @"iPhone 7",
        @"iPhone15,5" : @"iPhone 15 Plus",
        @"iPhone16,1" : @"iPhone 15 Pro",
        @"iPhone9,2" : @"iPhone 7 Plus",
        @"iPhone10,4" : @"iPhone 8",
        @"iPhone10,2" : @"iPhone 8 Plus",
        @"iPhone11,8" : @"iPhone XR",
        @"iPhone14,8" : @"iPhone 14 Plus",
        @"iPhone11,2" : @"iPhone XS",
        @"iPhone14,3" : @"iPhone 13 Pro Max",
        @"iPhone12,1" : @"iPhone 11",
        @"iPhone12,8" : @"iPhone SE (2nd generation)",
        @"iPhone13,1" : @"iPhone 12 mini",
        @"i386" : @"iPhone Simulator",
        @"x86_64" : @"iPhone Simulator",
        @"iPhone14,7" : @"iPhone 14",
        @"iPhone13,2" : @"iPhone 12",
        @"iPhone14,4" : @"iPhone 13 mini",
        @"iPhone14,2" : @"iPhone 13 Pro",
        @"iPhone14,6" : @"iPhone SE (3rd generation)",
        @"iPhone15,3" : @"iPhone 14 Pro Max",
        @"iPhone15,2" : @"iPhone 14 Pro",
        @"iPhone15,4" : @"iPhone 15",
        @"iPhone16,2" : @"iPhone 15 Pro Max",
    };
    
    struct utsname systemInfo;
    NSString *modelName = @"";
    if (uname(&systemInfo) < 0) {
        return @"";
    } else {
    
        NSString *deviceIdentifer = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
        modelName = [dict objectForKey:deviceIdentifer];
        return modelName?:@"";
    }
    return notNull(modelName);
}

+(NSString *)mirjhaDevicedeviceModelName
{
    return notNull([self mirjhaDevicedeviceName]);
}

+ (NSString *)mirjhaDevicebuildVersion {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appBuildVersion = [infoDic objectForKey:@"CFBundleVersion"];
    return notNull(appBuildVersion);
}

+ (NSString *)mirjhaDevicesystemVersion {
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    return notNull(systemVersion);
}
+ (NSString *)mirjhaDeviceidfa {
    return @"";
}
+ (NSString *)mirjhaDeviceidfv {
    NSString *idfv = [PPIDFVManagerTools ppConfiggetIDFV];
    return notNull(idfv);
}

+ (NSString *)mirjhaDevicepackageName {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDic objectForKey:@"CFBundleDisplayName"];
    return notNull(appName);
}

+ (NSString *)mirjhaDevicebundleId {
    NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
    return notNull(bundleId);
}

+ (NSString *)mirjhaDeviceip {
    NSString *address = @"127.0.0.1";
    struct ifaddrs *interfaces;
    struct ifaddrs *temp_addr;
    int success = 0;
    // 获取当前网络接口信息
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // 遍历网络接口
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // 如果是IPv4地址
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // 获取IP地址
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}

+ (NSInteger)mirjhaDevicebatteryLevel {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    CGFloat quantiy = [[UIDevice currentDevice] batteryLevel];
    NSString *value = [NSString stringWithFormat:@"%.2f",quantiy * 100];
    return value.integerValue;
}

+ (BOOL)mirjhaDeviceisCharging {
    UIDevice * device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    UIDeviceBatteryState state = device.batteryState;
    if(state == UIDeviceBatteryStateUnplugged){
        return NO;
    }else if (state == UIDeviceBatteryStateCharging){
        return YES;
    }
    return NO;
}

+ (BOOL)mirjhaDevicegetBatteryStatus {
    UIDevice * device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    UIDeviceBatteryState state = device.batteryState;
    if(state == UIDeviceBatteryStateFull){
        return YES;
    }
    return NO;
}

+ (UIDeviceBatteryState)mirjhaDevicebatteryState {
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
    return [UIDevice currentDevice].batteryState;
}

+ (NSString *)mirjhaDevicegetTotalMemorySize {
    double totalsize = [NSProcessInfo processInfo].physicalMemory;
    return [NSString stringWithFormat:@"%.f",totalsize];
}

+ (NSUInteger)mirjhaDevicegetUsedMemory {
    struct mach_task_basic_info info;
    mach_msg_type_number_t count = MACH_TASK_BASIC_INFO_COUNT;
    if (task_info(mach_task_self(), MACH_TASK_BASIC_INFO, (task_info_t)&info, &count) == KERN_SUCCESS) {
        return info.resident_size;
    } else {
        return 0;
    }
}

+ (NSString *)mirjhaDevicegetAvailableMemorySize {
    NSString *used_megabytes = @"0";
    NSByteCountFormatter *byteFormatter = [[NSByteCountFormatter alloc] init];
    [byteFormatter setAllowedUnits:NSByteCountFormatterUseBytes];
    [byteFormatter setCountStyle:NSByteCountFormatterCountStyleBinary];
    mach_task_basic_info_data_t info;
    mach_msg_type_number_t count = MACH_TASK_BASIC_INFO_COUNT;
    kern_return_t kerr = task_info(mach_task_self(),
                                   MACH_TASK_BASIC_INFO,
                                   (task_info_t)&info,
                                   &count);
    if (kerr == KERN_SUCCESS) {
        int64_t used_bytes = info.resident_size;
        used_megabytes = [NSString stringWithFormat:@"%lld", used_bytes];
    }
    return used_megabytes;
}

+ (NSString *)mirjhaDevicegetTotalDiskSize {
    double totalsize = 0.0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if (dictionary)
    {
        NSNumber *_total = [dictionary objectForKey:NSFileSystemSize];
        totalsize = [_total unsignedLongLongValue]*1.0;
    } else
    {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    
    return [NSString stringWithFormat:@"%.f",totalsize];
}

+ (NSString *)mirjhaDevicegetAvailableDiskSize {
    double freesize = 0.0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if (dictionary)
    {
        NSNumber *_free = [dictionary objectForKey:NSFileSystemFreeSize];
        freesize = [_free unsignedLongLongValue]*1.0;
    } else
    {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    
    return  [NSString stringWithFormat:@"%.f",freesize];
}

+ (NSString *)mirjhaDevicedeviceType {
    NSString *deviceType = [UIDevice currentDevice].model;
    return notNull(deviceType);
}

+ (NSString *)mirjhaDevicedeviceSize {
    CGFloat width =  [[UIScreen mainScreen] nativeBounds].size.width;
    CGFloat height =  [[UIScreen mainScreen] nativeBounds].size.height;
    CGFloat physical = sqrt(width * width + height * height);
    
    return [NSString stringWithFormat:@"%0.1f",physical];
}

+ (CGFloat)mirjhaDevicedeviceWidth {
    CGSize rect_screen = [[UIScreen mainScreen] nativeBounds].size;
    return rect_screen.width;
}

+ (CGFloat)mirjhaDevicedeviceHeight {
    CGSize rect_screen = [[UIScreen mainScreen] nativeBounds].size;

    return rect_screen.height;
}

+ (NSString *)mirjhaDevicenetworkStatus {
    NSString *type = @"";
    AFNetworkReachabilityStatus status = [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
    if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
        type = @"4g";
    }
    else if (status == AFNetworkReachabilityStatusReachableViaWiFi)
    {
        type = @"WIFI";
    }
    return type;
}

+ (NSString *)mirjhaDevicegetSIMCardInfo {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];

    if (carrier.isoCountryCode) {
        return [carrier carrierName];
    }
    return @"";
}


+ (BOOL)mirjhaDeviceisJailbroken {
    return false;
}

+ (BOOL)mirjhaDeviceisSimulator {
#if TARGET_IPHONE_SIMULATOR
    BOOL simulator = YES;
#elif TARGET_OS_IPHONE
    BOOL simulator = false;

#endif
    return simulator;
}


+ (NSTimeInterval)mirjhaDevicegetDeviceProTime {
    NSDictionary *systemAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSDate *creationDate = systemAttributes[NSFileCreationDate];

    if (creationDate) {
        return [creationDate timeIntervalSince1970];
    } else {
        return 0;
    }
}


+ (NSString *)mirjhaDevicetimeZone {
    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
    return [currentTimeZone abbreviation] ?: @"";
}


+ (BOOL)mirjhaDeviceisUseProxy {
    CFArrayRef proxies = NULL;
    CFDictionaryRef proxySettings = NULL;
    NSDictionary *proxySettingsDict = NULL;

    proxySettings = CFNetworkCopySystemProxySettings();
    if (!proxySettings) {
        return NO;
    }

    proxySettingsDict = (__bridge NSDictionary *)proxySettings;
    if (proxySettingsDict == nil || !proxySettingsDict) {
        return NO;
    }

    proxies = CFNetworkCopyProxiesForURL((__bridge CFURLRef)[NSURL URLWithString:@"http://www.google.com"], NULL);
    if (!proxies) {
        return NO;
    }

    proxySettingsDict = (__bridge NSDictionary *)proxies;
    if (proxySettingsDict == nil || !proxySettingsDict) {
        return NO;
    }

    return YES;
}

+ (BOOL)mirjhaDeviceisUseVPN {
    BOOL flag = NO;
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 9.0) {
        NSDictionary *dict = CFBridgingRelease(CFNetworkCopySystemProxySettings());
        NSArray *keys = [dict[@"__SCOPED__"] allKeys];
        for (NSString *key in keys) {
            if ([key rangeOfString:@"tap"].location != NSNotFound ||
                [key rangeOfString:@"tun"].location != NSNotFound ||
                [key rangeOfString:@"ipsec"].location != NSNotFound ||
                [key rangeOfString:@"ppp"].location != NSNotFound){
                flag = YES;
                break;
            }
        }
    }else {
        struct ifaddrs *interfaces = NULL;
        struct ifaddrs *temp_addr = NULL;
        int success = 0;
        success = getifaddrs(&interfaces);
        if (success == 0)
        {
            temp_addr = interfaces;
            while (temp_addr != NULL)
            {
                NSString *string = [NSString stringWithFormat:@"%s" , temp_addr->ifa_name];
                if ([string rangeOfString:@"tap"].location != NSNotFound ||
                    [string rangeOfString:@"tun"].location != NSNotFound ||
                    [string rangeOfString:@"ipsec"].location != NSNotFound ||
                    [string rangeOfString:@"ppp"].location != NSNotFound)
                {
                    flag = YES;
                    break;
                }
                temp_addr = temp_addr->ifa_next;
            }
        }
        freeifaddrs(interfaces);
    }
    return flag;
}


+ (NSString *)mirjhaDevicedeviceLanuage {
    
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSArray  *array = [language componentsSeparatedByString:@"-"];
    NSString *currentLanguage = array[0];
    return language;
}

+ (NSString *)mirjhaDevicegetBSSID {
    if ([[AFNetworkReachabilityManager sharedManager]isReachableViaWiFi]) {
        CFArrayRef myArray = CNCopySupportedInterfaces();
        if (myArray != nil) {
            CFDictionaryRef myDict =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
            if (myDict != nil) {
                NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
                NSString *bssid = [dict valueForKey:@"BSSID"];
                bssid = bssid ? [self mirjhaDevicestandardFormateMAC:bssid] : bssid;
                return bssid;
            }
        }
    }
    return @"";
}

+ (NSString *)mirjhaDevicestandardFormateMAC:(NSString *)MAC {
    NSArray * subStr = [MAC componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":-"]];
    NSMutableArray * subStr_M = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSString * str in subStr) {
        if (1 == str.length) {
            NSString * tmpStr = [NSString stringWithFormat:@"0%@", str];
            [subStr_M addObject:tmpStr];
        } else {
            [subStr_M addObject:str];
        }
    }
    NSString * formateMAC = [subStr_M componentsJoinedByString:@":"];
    return notNull([formateMAC uppercaseString]);
}


+ (NSString *)mirjhaDevicegetWifiName {
    if ([[AFNetworkReachabilityManager sharedManager]isReachableViaWiFi]) {
        CFArrayRef myArray = CNCopySupportedInterfaces();
        if (myArray != nil) {
            CFDictionaryRef myDict =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
            if (myDict != nil) {
                NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
                NSString *name = [dict valueForKey:@"SSID"];
                return name;
            }
        }
    }
    return @"";
}


+ (NSString *)mirjhaDevicecreateRandomUUIDWithLenght:(NSInteger)lenght
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    NSString *uuidString = [uuid lowercaseString];
    if (lenght > 0 && uuidString.length > lenght) {
        uuidString = [uuidString substringWithRange:NSMakeRange(0, lenght)];
    }
    return uuidString;
}


+ (NSString*)mirjhaDevicefirstInstallation
{
    NSString * const KEY_FistTime = @"FistTime";
   
    
    
    NSString *fistTimeStr = [PPCacheConfigManager getStr:KEY_FistTime];
    
    if (isBlankStr(fistTimeStr))
    {
        NSString *fistTimeStr = [self mirjhaDevicenowTimeString];
        [PPCacheConfigManager setStr:fistTimeStr forKey:KEY_FistTime];
        return fistTimeStr;
    }
    else{
        return fistTimeStr;
    }
}

+ (NSString *)mirjhaDevicenowTimeString {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970]*1000;
    NSString *timeStr = StrValue(time);
    return notNull(timeStr);
}

+(NSString*)mirjhaDevicenewIDFV
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}


+(NSDictionary*)mirjhaDevicegetParameFromURL:(NSURL *)url
{
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    NSArray<NSURLQueryItem *> *queryItems = urlComponents.queryItems;

    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    for (NSURLQueryItem *queryItem in queryItems) {
        [params setObject:queryItem.value forKey:queryItem.name];
    }
    
    return params;
}

@end
