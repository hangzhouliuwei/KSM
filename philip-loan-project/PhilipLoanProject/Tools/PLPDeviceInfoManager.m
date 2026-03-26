//
//  DeviceInfoManager.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/2.
//

#import "PLPDeviceInfoManager.h"
#include <mach/mach.h>
#include <sys/sysctl.h>
#import <sys/mount.h>
#import <sys/utsname.h>
#import<SystemConfiguration/CaptiveNetwork.h>
#import<SystemConfiguration/SystemConfiguration.h>
#import<CoreFoundation/CoreFoundation.h>
#import "AFNetworkReachabilityManager.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "SSKeychain.h"
#include <resolv.h>
#include <netdb.h>
#import <CoreMotion/CMMotionManager.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <UIKit/UIKit.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/ASIdentifierManager.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
@implementation PLPDeviceInfoManager


#pragma mark -network data
+(NSString *)networkName
{
    if ([[AFNetworkReachabilityManager sharedManager]isReachableViaWiFi]) {
        CFArrayRef myArray = CNCopySupportedInterfaces();
        if (myArray != nil) {
            CFDictionaryRef myDict =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
            if (myDict != nil) {
                NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
                return [dict valueForKey:@"SSID"];
            }
        }
    }
    return @"";
}
+(NSString *)networkMac
{
    if ([[AFNetworkReachabilityManager sharedManager]isReachableViaWiFi]) {
        CFArrayRef array = CNCopySupportedInterfaces();
        if (array != nil) {
            CFDictionaryRef ref =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(array, 0));
            if (ref != nil) {
                NSDictionary *dic = (NSDictionary*)CFBridgingRelease(ref);
                NSString *bssid = [dic valueForKey:@"BSSID"];
                bssid = bssid ? [self standardFormateMAC:bssid] : bssid;
                return bssid;
            }
        }
    }
    return @"";
}
+(NSString *)networkServeIdentifier
{
    if ([[AFNetworkReachabilityManager sharedManager]isReachableViaWiFi]) {
        CFArrayRef array = CNCopySupportedInterfaces();
        if (array != nil) {
            CFDictionaryRef dicRef =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(array, 0));
            if (dicRef != nil) {
                NSDictionary *dic = (NSDictionary*)CFBridgingRelease(dicRef);
                return [dic valueForKey:@"SSID"];
            }
        }
    }
    return @"";
}
+(NSString *)networkBaseIdentifier
{
    if ([[AFNetworkReachabilityManager sharedManager]isReachableViaWiFi]) {
        CFArrayRef array = CNCopySupportedInterfaces();
        if (array != nil) {
            CFDictionaryRef myDict =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(array, 0));
            if (myDict != nil) {
                NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
                NSString *bssid = [dict valueForKey:@"BSSID"];
                bssid = bssid ? [self standardFormateMAC:bssid] : bssid;
                return bssid;
            }
        }
    }
    return @"";
}
+ (NSString *)standardFormateMAC:(NSString *)MAC {
    NSArray * subStrARray = [MAC componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":-"]];
    NSMutableArray * subStr_mutable = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSString * str in subStrARray) {
        if (1 == str.length) {
            NSString * tmpStr = [NSString stringWithFormat:@"0%@", str];
            [subStr_mutable addObject:tmpStr];
        } else {
            [subStr_mutable addObject:str];
        }
    }
    NSString * formateMAC = [subStr_mutable componentsJoinedByString:@":"];
    return [formateMAC uppercaseString];
}
#pragma mark -generate data
+(NSString *)generateIPAddress
{
    NSError *error;
    NSURL *ipURL = [NSURL URLWithString:@"http://pv.sohu.com/cityjson?ie=utf-8"];
    NSMutableString *ip = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
    if ([ip hasPrefix:@"var returnCitySN = "]) {
        NSRange range = NSMakeRange(0, 19);
        [ip deleteCharactersInRange:range];
        NSString *result = [ip substringToIndex:ip.length-1];
        NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        return dic[@"cip"] ? dic[@"cip"] : @"";
    }
    return @"";
}
+(NSString *)generatePhoneType
{
    return @"1";
}
+ (NSString *)generateNetType
{
    NSString *result = @"";
    AFNetworkReachabilityStatus status = [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
    if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
        result = @"4g";
    }
    else if (status == AFNetworkReachabilityStatusReachableViaWiFi)
    {
        result = @"wifi";
    }
    return result;
}
+(NSString *)generateLanguage
{
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSArray *array = [language componentsSeparatedByString:@"-"];
    return array[0];
}
+(NSString *)generateIDFV
{
    return [PLPCommondTools getDeviceIDFV];
}
+(NSString *)generateOperatorName
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (carrier.isoCountryCode) {
        return [carrier carrierName];
    }
    return @"";
}
+(NSString *)generateTimeZone
{
    return [[NSTimeZone localTimeZone] abbreviation]?:@"";
}
+(BOOL)generateUseDelegate
{
    CFArrayRef proxies = NULL;
    CFDictionaryRef setting = NULL;
    NSDictionary *settingDic = NULL;
    setting = CFNetworkCopySystemProxySettings();
    if (!setting) {
        return NO;
    }
    settingDic = (__bridge NSDictionary *)setting;
    if (settingDic == nil || !settingDic) {
        return NO;
    }
    proxies = CFNetworkCopyProxiesForURL((__bridge CFURLRef)[NSURL URLWithString:@"http://www.google.com"], NULL);
    if (!proxies) {
        return NO;
    }
    settingDic = (__bridge NSDictionary *)proxies;
    if (settingDic == nil || !settingDic) {
        return NO;
    }
    return YES;
}
+(BOOL)generateUseVPN
{
    BOOL flag = NO;
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 9.0)
    {
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
    }
    else
    {
        struct ifaddrs *inter = NULL;
        struct ifaddrs *addr = NULL;
        int result = 0;
        result = getifaddrs(&inter);
        if (result == 0)
        {
            addr = inter;
            while (addr != NULL)
            {
                NSString *name = [NSString stringWithFormat:@"%s" , addr->ifa_name];
                if ([name rangeOfString:@"tap"].location != NSNotFound ||
                    [name rangeOfString:@"tun"].location != NSNotFound ||
                    [name rangeOfString:@"ipsec"].location != NSNotFound ||
                    [name rangeOfString:@"ppp"].location != NSNotFound)
                {
                    flag = YES;
                    break;
                }
                addr = addr->ifa_next;
            }
        }
        freeifaddrs(inter);
    }
    return flag;
}

#pragma mark -other data
+(NSString *)otherSignalStrength
{
    return @"0";
}

+(BOOL)otherIsRoot
{
    return false;
}

+(BOOL)otherIsSimulator
{
#if TARGET_IPHONE_SIMULATOR
    BOOL simulator = YES;
#elif TARGET_OS_IPHONE
    BOOL simulator = false;
#endif
    return simulator;
}




#pragma mark  -hard info
+(NSString *)hardSystemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}
+(NSString *)hardDeviceStyle
{
    struct utsname info;
    NSString *name = @"";
    if (uname(&info) < 0) {
        return @"";
    } else {
        NSString *identifer = [NSString stringWithCString:info.machine encoding:NSUTF8StringEncoding];
        NSDictionary *dic = @{
            // iPhone
            @"iPhone1,1" : @"iPhone",
            @"iPhone1,2" : @"iPhone 3G",
            @"iPhone2,1" : @"iPhone 3GS",
            @"iPhone3,1" : @"iPhone 4",
            @"iPhone3,2" : @"iPhone 4",
            @"iPhone3,3" : @"iPhone 4",
            @"iPhone4,1" : @"iPhone 4S",
            @"iPhone5,1" : @"iPhone 5",
            @"iPhone5,2" : @"iPhone 5",
            @"iPhone5,3" : @"iPhone 5c",
            @"iPhone5,4" : @"iPhone 5c",
            @"iPhone6,1" : @"iPhone 5s",
            @"iPhone6,2" : @"iPhone 5s",
            @"iPhone7,2" : @"iPhone 6",
            @"iPhone7,1" : @"iPhone 6 Plus",
            @"iPhone8,1" : @"iPhone 6s",
            @"iPhone8,2" : @"iPhone 6s Plus",
            @"iPhone8,4" : @"iPhone SE (1st generation)",
            @"iPhone9,1" : @"iPhone 7",
            @"iPhone9,3" : @"iPhone 7",
            @"iPhone9,2" : @"iPhone 7 Plus",
            @"iPhone9,4" : @"iPhone 7 Plus",
            @"iPhone10,1" : @"iPhone 8",
            @"iPhone10,4" : @"iPhone 8",
            @"iPhone10,2" : @"iPhone 8 Plus",
            @"iPhone10,5" : @"iPhone 8 Plus",
            @"iPhone10,3" : @"iPhone X",
            @"iPhone10,6" : @"iPhone X",
            @"iPhone11,8" : @"iPhone XR",
            @"iPhone11,2" : @"iPhone XS",
            @"iPhone11,6" : @"iPhone XS Max",
            @"iPhone11,4" : @"iPhone XS Max",
            @"iPhone12,1" : @"iPhone 11",
            @"iPhone12,3" : @"iPhone 11 Pro",
            @"iPhone12,5" : @"iPhone 11 Pro Max",
            @"iPhone12,8" : @"iPhone SE (2nd generation)",
            @"iPhone13,1" : @"iPhone 12 mini",
            @"iPhone13,2" : @"iPhone 12",
            @"iPhone13,3" : @"iPhone 12 Pro",
            @"iPhone13,4" : @"iPhone 12 Pro Max",
            @"iPhone14,4" : @"iPhone 13 mini",
            @"iPhone14,5" : @"iPhone 13",
            @"iPhone14,2" : @"iPhone 13 Pro",
            @"iPhone14,3" : @"iPhone 13 Pro Max",
            @"iPhone14,6" : @"iPhone SE (3rd generation)",
            @"iPhone14,7" : @"iPhone 14",
            @"iPhone14,8" : @"iPhone 14 Plus",
            @"iPhone15,2" : @"iPhone 14 Pro",
            @"iPhone15,3" : @"iPhone 14 Pro Max",
            @"iPhone15,4" : @"iPhone 15",
            @"iPhone15,5" : @"iPhone 15 Plus",
            @"iPhone16,1" : @"iPhone 15 Pro",
            @"iPhone16,2" : @"iPhone 15 Pro Max",
            // iPad
            @"iPad1,1" : @"iPad",
            @"iPad2,1" : @"iPad 2",
            @"iPad2,2" : @"iPad 2",
            @"iPad2,3" : @"iPad 2",
            @"iPad2,4" : @"iPad 2",
            @"iPad3,1" : @"iPad (3rd generation)",
            @"iPad3,2" : @"iPad (3rd generation)",
            @"iPad3,3" : @"iPad (3rd generation)",
            @"iPad3,4" : @"iPad (4th generation)",
            @"iPad3,5" : @"iPad (4th generation)",
            @"iPad3,6" : @"iPad (4th generation)",
            @"iPad6,11" : @"iPad (5th generation)",
            @"iPad6,12" : @"iPad (5th generation)",
            @"iPad7,5" : @"iPad (6th generation)",
            @"iPad7,6" : @"iPad (6th generation)",
            @"iPad7,11" : @"iPad (7th generation)",
            @"iPad7,12" : @"iPad (7th generation)",
            @"iPad11,6" : @"iPad (8th generation)",
            @"iPad11,7" : @"iPad (8th generation)",
            @"iPad12,1" : @"iPad (9th generation)",
            @"iPad12,2" : @"iPad (9th generation)",
            @"iPad13,18" : @"iPad (10th generation)",
            @"iPad13,19" : @"iPad (10th generation)",
            @"iPad4,1" : @"iPad Air",
            @"iPad4,2" : @"iPad Air",
            @"iPad4,3" : @"iPad Air",
            @"iPad5,3" : @"iPad Air 2",
            @"iPad5,4" : @"iPad Air 2",
            @"iPad11,3" : @"iPad Air (3rd generation)",
            @"iPad11,4" : @"iPad Air (3rd generation)",
            @"iPad13,1" : @"iPad Air (4th generation)",
            @"iPad13,2" : @"iPad Air (4th generation)",
            @"iPad13,16" : @"iPad Air (5th generation)",
            @"iPad13,17" : @"iPad Air (5th generation)",
            @"iPad6,7" : @"iPad Pro (12.9-inch)",
            @"iPad6,8" : @"iPad Pro (12.9-inch)",
            @"iPad6,3" : @"iPad Pro (9.7-inch)",
            @"iPad6,4" : @"iPad Pro (9.7-inch)",
            @"iPad7,1" : @"iPad Pro (12.9-inch) (2nd generation)",
            @"iPad7,2" : @"iPad Pro (12.9-inch) (2nd generation)",
            @"iPad7,3" : @"iPad Pro (10.5-inch)",
            @"iPad7,4" : @"iPad Pro (10.5-inch)",
            @"iPad8,1" : @"iPad Pro (11-inch)",
            @"iPad8,2" : @"iPad Pro (11-inch)",
            @"iPad8,3" : @"iPad Pro (11-inch)",
            @"iPad8,4" : @"iPad Pro (11-inch)",
            @"iPad8,5" : @"iPad Pro (12.9-inch) (3rd generation)",
            @"iPad8,6" : @"iPad Pro (12.9-inch) (3rd generation)",
            @"iPad8,7" : @"iPad Pro (12.9-inch) (3rd generation)",
            @"iPad8,8" : @"iPad Pro (12.9-inch) (3rd generation)",
            @"iPad8,9" : @"iPad Pro (11-inch) (2nd generation)",
            @"iPad8,10" : @"iPad Pro (11-inch) (2nd generation)",
            @"iPad8,11" : @"iPad Pro (12.9-inch) (4th generation)",
            @"iPad8,12" : @"iPad Pro (12.9-inch) (4th generation)",
            @"iPad13,4" : @"iPad Pro (11-inch) (3rd generation)",
            @"iPad13,5" : @"iPad Pro (11-inch) (3rd generation)",
            @"iPad13,6" : @"iPad Pro (11-inch) (3rd generation)",
            @"iPad13,7" : @"iPad Pro (11-inch) (3rd generation)",
            @"iPad13,8" : @"iPad Pro (12.9-inch) (5th generation)",
            @"iPad13,9" : @"iPad Pro (12.9-inch) (5th generation)",
            @"iPad13,10" : @"iPad Pro (12.9-inch) (5th generation)",
            @"iPad13,11" : @"iPad Pro (12.9-inch) (5th generation)",
            @"iPad2,5" : @"iPad mini",
            @"iPad2,6" : @"iPad mini",
            @"iPad2,7" : @"iPad mini",
            @"iPad4,4" : @"iPad mini 2",
            @"iPad4,5" : @"iPad mini 2",
            @"iPad4,6" : @"iPad mini 2",
            @"iPad4,7" : @"iPad mini 3",
            @"iPad4,8" : @"iPad mini 3",
            @"iPad4,9" : @"iPad mini 3",
            @"iPad5,1" : @"iPad mini 4",
            @"iPad5,2" : @"iPad mini 4",
            @"iPad11,1" : @"iPad mini (5th generation)",
            @"iPad11,2" : @"iPad mini (5th generation)",
            @"iPad14,1" : @"iPad mini (6th generation)",
            @"iPad14,2" : @"iPad mini (6th generation)",
            @"i386" : @"iPhone Simulator",
            @"x86_64" : @"iPhone Simulator",
        };
        name = [dic objectForKey:identifer];
        return name?:@"";
    }
    return name;
}
+(CGFloat)hardResolvingHeight
{
    return [[UIScreen mainScreen] nativeBounds].size.height;
}
+(CGFloat)hardResolvingWidth
{
    return [[UIScreen mainScreen] nativeBounds].size.width;
}
+(NSString *)hardPhysicSize
{
    CGFloat h = [[UIScreen mainScreen] nativeBounds].size.height;
    CGFloat w = [[UIScreen mainScreen] nativeBounds].size.width;
    return [NSString stringWithFormat:@"%.1f",sqrt(pow(w, 2) + pow(h, 2))];
}
+(NSTimeInterval)hardDeviceTimeStamp
{
    UIDevice *device = [UIDevice currentDevice];
    NSDictionary *att = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSDate *date = att[NSFileCreationDate];
    if (date) {
        return [date timeIntervalSince1970];
    } else {
        return 0;
    }
}


#pragma mark -battery
+(BOOL)queryBatteryisIn
{
    UIDevice * device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    UIDeviceBatteryState state = device.batteryState;
    return state == UIDeviceBatteryStateCharging;
}
+(NSInteger)queryBatteryValue
{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    CGFloat level = [[UIDevice currentDevice] batteryLevel];
    NSString *value = [NSString stringWithFormat:@"%.2f",level * 100];
    return value.intValue;
}

+(BOOL)queryBatteryStatus
{
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    UIDeviceBatteryState state = device.batteryState;
    return state == UIDeviceBatteryStateFull;
}

#pragma mark -memory
+(NSString *)getTotalMemory
{
    return [NSString stringWithFormat:@"%llu",[NSProcessInfo processInfo].physicalMemory];
}
+(NSString *)getUseMemory
{
    NSString *size = @"0";
    NSByteCountFormatter *formatter = [[NSByteCountFormatter alloc] init];
    [formatter setAllowedUnits:NSByteCountFormatterUseBytes];
    [formatter setCountStyle:NSByteCountFormatterCountStyleBinary];
    mach_task_basic_info_data_t info;
    mach_msg_type_number_t count = MACH_TASK_BASIC_INFO_COUNT;
    kern_return_t kerr = task_info(mach_task_self(),
                                   MACH_TASK_BASIC_INFO,
                                   (task_info_t)&info,
                                   &count);
    if (kerr == KERN_SUCCESS) {
        int64_t result = info.resident_size;
        size = [NSString stringWithFormat:@"%lld", result];
    }
    return size;
}

+(NSString *)getTotalDiskMemory
{
    double size = 0.0;
    NSError *error = nil;
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[path lastObject] error: &error];
    if (dic)
    {
        NSNumber *total = [dic objectForKey:NSFileSystemSize];
        size = [total unsignedLongLongValue]*1.0;
    } else
    {
    }
    return [NSString stringWithFormat:@"%.f",size];
}
+(NSString *)getUseDiskMemory
{
    double size = 0.0;
    NSError *error = nil;
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[path lastObject] error: &error];
    if (dic)
    {
        NSNumber *free = [dic objectForKey:NSFileSystemFreeSize];
        size = [free unsignedLongLongValue]*1.0;
    } else
    {
      
    }
    return  [NSString stringWithFormat:@"%.f",size];
}



@end
