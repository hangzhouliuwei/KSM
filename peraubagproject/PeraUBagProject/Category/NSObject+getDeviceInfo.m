//
//  NSObject+getDeviceInfo.m
//  KDFDApp
//
//  Created by Bruce on 2017/8/29.
//  Copyright © 2017年 cailiang. All rights reserved.
//

#import "NSObject+getDeviceInfo.h"
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
//#import <UMAnalytics/MobClick.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <UIKit/UIKit.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/ASIdentifierManager.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
@implementation NSObject (getDeviceInfo)

#pragma mark - idfv
+ (NSString *)getIPaddress
{
    NSString *address = @"error";
    struct ifaddrs * ifaddress = NULL;
    struct ifaddrs * temp_address = NULL;
    int success = 0;
    success = getifaddrs(&ifaddress);
    if(success == 0) {
        temp_address = ifaddress;
        while(temp_address != NULL) {
            if(temp_address->ifa_addr->sa_family == AF_INET) {
                if([[NSString stringWithUTF8String:temp_address->ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_address->ifa_addr)->sin_addr)];
                }
            }
            temp_address = temp_address->ifa_next;
        }
    }
    return address;
}

+ (void )getIdfa:(void(^)(NSString *idfa))block{
    
    __block NSString *idfa = @"";
    if (@available(iOS 14, *)) {
        // iOS14及以上版本需要先请求权限
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            // 获取到权限后，依然使用老方法获取idfa
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
//                NSLog(@"%@",idfa);
                block(idfa);
            } else if(status == ATTrackingManagerAuthorizationStatusNotDetermined){
                
            } else{
                block(idfa);
                NSLog(@"请在设置-隐私-跟踪中允许App请求跟踪");
            }
        }];
    } else {
        // iOS14以下版本依然使用老方法
        // 判断在设置-隐私里用户是否打开了广告跟踪
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
//            NSLog(@"%@",idfa);
            block(idfa);
        } else {
            block(idfa);
            NSLog(@"请在设置-隐私-广告中打开广告跟踪功能");
        }
    }
//    return idfa;
}
+ (NSString *)lanuage{
    //判断当前系统语言
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSArray  *array = [language componentsSeparatedByString:@"-"];
    NSString *currentLanguage = array[0];
    return language;
}
+(NSString *)getIDFV
{
    NSString * currentDeviceUUIDStr = [SSKeychain passwordForService:@"com.koudaiborrow"account:@"uuid"];
    if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""])
    {
        NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
        [SSKeychain setPassword: currentDeviceUUIDStr forService:@"com.koudaiborrow"account:@"uuid"];
    }
    return currentDeviceUUIDStr;
}
+ (NSString *)getUUID{
    NSString * currentDeviceUUIDStr = [SSKeychain passwordForService:@"com.koudaiborrow"account:@"QCUUID"];
    if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""])
    {
        currentDeviceUUIDStr = [NSUUID UUID].UUIDString;
        [SSKeychain setPassword: currentDeviceUUIDStr forService:@"com.koudaiborrow"account:@"QCUUID"];
    }
    return currentDeviceUUIDStr;
}
//获取网络状态
+(NSString *) getNetworkType{
    
    NSString *type = @"";
    AFNetworkReachabilityStatus status = [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
    if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
        //2g,3g
        type = @"4g";
    }
    else if (status == AFNetworkReachabilityStatusReachableViaWiFi)
    {
        //wifi
        type = @"wifi";
    }
    return type;
}
#pragma mark - 获取iOS系统版本号
+ (NSString *)getIOSVersion
{
    return [[UIDevice currentDevice] systemVersion] ;
}

+(NSString*)getMobileStyle{
    struct utsname systemInfo;
    NSString *modelName = @"";
    if (uname(&systemInfo) < 0) {
        return @"";
    } else {
        // 获取设备标识Identifier
        NSString *deviceIdentifer = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        // 根据identifier去匹配到对应的型号名称
        modelName = [[self modelList] objectForKey:deviceIdentifer];
        return modelName?:@"";
    }
    return modelName;
}
/// 只列出了iphone、ipad和simulator的型号，其他设备型号请到 https://www.theiphonewiki.com/wiki/Models 查看
+ (NSDictionary *)modelList {
    return @{
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
        // 其他
        @"i386" : @"iPhone Simulator",
        @"x86_64" : @"iPhone Simulator",
    };
}
+ (NSString *)getScreenSize
{
    CGRect rect_screen = [[UIScreen mainScreen] bounds];
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    CGFloat physical_size = rect_screen.size.width *  rect_screen.size.width + rect_screen.size.height * rect_screen.size.height;
    //NSString *physical_size = [NSString stringWithFormat:@"%.f*%.f",rect_screen.size.width,rect_screen.size.height];
    return  [NSString stringWithFormat:@"%0.1f",physical_size];
}


/// 物理尺寸
+ (NSString *)physicalDimensions {
//    NSString *deviceName = [self getMobileStyle];
////    [UIDevice currentDevice].deviceName;
//    if ([deviceName isEqualToString:@"iPhone"])    return @"3.5";
//    if ([deviceName isEqualToString:@"iPhone 3G"])    return @"3.5";
//    if ([deviceName isEqualToString:@"iPhone 3GS"])    return @"3.5";
//    if ([deviceName isEqualToString:@"iPhone 4"])    return @"3.5";
//    if ([deviceName isEqualToString:@"iPhone 4S"])    return @"3.5";
//    if ([deviceName isEqualToString:@"iPhone 5"])    return @"4.0";
//    if ([deviceName isEqualToString:@"iPhone 5c"])    return @"4.0";
//    if ([deviceName isEqualToString:@"iPhone 5s"])    return @"4.0";
//    if ([deviceName isEqualToString:@"iPhone 6"])    return @"4.7";
//    if ([deviceName isEqualToString:@"iPhone 6s"])    return @"4.7";
//    if ([deviceName isEqualToString:@"iPhone 6 Plus"])    return @"5.5";
//    if ([deviceName isEqualToString:@"iPhone 6s Plus"])    return @"5.5";
//    if ([deviceName isEqualToString:@"iPhone SE (1st generation)"])    return @"4.0";
//    if ([deviceName isEqualToString:@"iPhone 7"])    return @"4.7";
//    if ([deviceName isEqualToString:@"iPhone 7 Plus"])    return @"5.5";
//    if ([deviceName isEqualToString:@"iPhone 8"])    return @"4.7";
//    if ([deviceName isEqualToString:@"iPhone 8 Plus"])    return @"5.5";
//    if ([deviceName isEqualToString:@"iPhone X"])    return @"5.8";
//    if ([deviceName isEqualToString:@"iPhone XR"])    return @"6.1";
//    if ([deviceName isEqualToString:@"iPhone XS"])    return @"5.8";
//    if ([deviceName isEqualToString:@"iPhone XS Max"])    return @"6.5";
//    if ([deviceName isEqualToString:@"iPhone 11"])    return @"6.1";
//    if ([deviceName isEqualToString:@"iPhone 11 Pro"])    return @"5.8";
//    if ([deviceName isEqualToString:@"iPhone 11 Pro Max"])    return @"6.5";
//    if ([deviceName isEqualToString:@"iPhone SE (2nd generation)"])    return @"4.7";
//    if ([deviceName isEqualToString:@"iPhone 12 mini"])    return @"5.4";
//    if ([deviceName isEqualToString:@"iPhone 12"])    return @"6.1";
//    if ([deviceName isEqualToString:@"iPhone 12 Pro"])    return @"6.1";
//    if ([deviceName isEqualToString:@"iPhone 12 Pro Max"])    return @"6.7";
//    if ([deviceName isEqualToString:@"iPhone 13 mini"])    return @"5.4";
//    if ([deviceName isEqualToString:@"iPhone 13"])    return @"6.1";
//    if ([deviceName isEqualToString:@"iPhone 13 Pro"])    return @"6.1";
//    if ([deviceName isEqualToString:@"iPhone 13 Pro Max"])    return @"6.7";
//    if ([deviceName isEqualToString:@"iPhone SE (3nd generation)"])    return @"4.7";
//    if ([deviceName isEqualToString:@"iPhone 14"])    return @"6.1";
//    if ([deviceName isEqualToString:@"iPhone 14 Plus"])    return @"6.7";
//    if ([deviceName isEqualToString:@"iPhone 14 Pro"])    return @"6.1";
//    if ([deviceName isEqualToString:@"iPhone 14 Pro Max"])    return @"6.7";
//    if ([deviceName isEqualToString:@"iPhone 15"])    return @"6.1";
//    if ([deviceName isEqualToString:@"iPhone 15 Plus"])    return @"6.7";
//    if ([deviceName isEqualToString:@"iPhone 15 Pro"])    return @"6.1";
//    if ([deviceName isEqualToString:@"iPhone 15 Pro Max"])    return @"6.7";
    CGFloat width =  [[UIScreen mainScreen] nativeBounds].size.width;
    CGFloat height =  [[UIScreen mainScreen] nativeBounds].size.height;
    CGFloat physical = sqrt(width * width + height * height);
    
    return [NSString stringWithFormat:@"%0.1f",physical];
}

+(CGFloat)getScreenWidth
{
    CGSize rect_screen = [[UIScreen mainScreen] nativeBounds].size;
  
    return rect_screen.width;
}

+(CGFloat)getScreenHeight
{
    CGSize rect_screen = [[UIScreen mainScreen] nativeBounds].size;
  
    return rect_screen.height;
}


#pragma mark - 获取电量
+ (NSInteger)getBatteryQuantity
{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    CGFloat quantiy = [[UIDevice currentDevice] batteryLevel];
    
    NSString *value = [NSString stringWithFormat:@"%.2f",quantiy * 100];
    return value.intValue;
}
#pragma mark - 获取Wi-Fi名字
+ (NSString *)getWifiName{
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
    return nil;
}
+ (NSString *)getBSSID{
    if ([[AFNetworkReachabilityManager sharedManager]isReachableViaWiFi]) {
        CFArrayRef myArray = CNCopySupportedInterfaces();
        if (myArray != nil) {
            CFDictionaryRef myDict =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
            if (myDict != nil) {
                NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
                NSString *bssid = [dict valueForKey:@"BSSID"];
                bssid = bssid ? [NSObject standardFormateMAC:bssid] : bssid;
                return bssid;
            }
        }
    }
    return nil;
}
+ (NSString *)standardFormateMAC:(NSString *)MAC {
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
    return [formateMAC uppercaseString];
}

+ (NSDictionary *)getInterfaces1 {
    NSArray *interFaceNames = (__bridge_transfer id)CNCopySupportedInterfaces();
    
    for (NSString *name in interFaceNames) {
        NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)name);
        return info;
    }
    return Nil;
}

#pragma mark - 获取运营商
+ (NSString *)getPhoneOperator{
    //获取本机运营商名称
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    //当前手机所属运营商名称
    //先判断有没有SIM卡，如果没有则不获取本机运营商
    if (carrier.isoCountryCode) {
        return [carrier carrierName];
    }
    return @"";
}
#pragma mark - 获取运营商国家编码+运营商网络编码
+ (NSString *)getTeleNum{
    //获取本机运营商名称
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    //当前手机所属运营商名称
    //先判断有没有SIM卡，如果没有则不获取本机运营商
    if (carrier.isoCountryCode) {
        NSString *tel_num = [NSString stringWithFormat:@"%@%@",carrier.mobileCountryCode,carrier.mobileNetworkCode];
        return tel_num;
    }
    return @"";
}
#pragma mark - 获取总内存大小
+(NSString *)getTotalMemorySize
{
//    return [self fileSizeToString:[NSProcessInfo processInfo].physicalMemory];
    double totalsize = [NSProcessInfo processInfo].physicalMemory;
    return [NSString stringWithFormat:@"%.f",totalsize];
}
#pragma mark - 获取可用内存
+(NSString *)getAvailableMemorySize
{
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
//    return [self fileSizeToString:((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count))];
}
#pragma mark - 获取总磁盘大小
+(NSString *)getTotalDiskSize
{
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
    
//    return [self fileSizeToString:totalsize];
    return [NSString stringWithFormat:@"%.f",totalsize];
}
#pragma mark - 获取可用磁盘大小
+(NSString *)getAvailableDiskSize
{
    
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
    
//    return [self fileSizeToString:freesize];
    return  [NSString stringWithFormat:@"%.f",freesize];
}

-(NSString *)fileSizeToString:(unsigned long long)fileSize
{
    NSInteger KB = 1024;
    NSInteger MB = KB*KB;
    NSInteger GB = MB*KB;
    
    if (fileSize < 10)
    {
        return @"0 B";
        
    }else if (fileSize < KB)
    {
        return @"< 1 KB";
        
    }else if (fileSize < MB)
    {
        return [NSString stringWithFormat:@"%.1f KB",((CGFloat)fileSize)/KB];
        
    }else if (fileSize < GB)
    {
        return [NSString stringWithFormat:@"%.1f MB",((CGFloat)fileSize)/MB];
        
    }else
    {
        return [NSString stringWithFormat:@"%.1f GB",((CGFloat)fileSize)/GB];
    }
}

#pragma mark- 是否越狱
+ (BOOL)isJailbroken{
    return false;
}
#pragma mark - 是否是模拟器
+(BOOL)isSimulator
{
#if TARGET_IPHONE_SIMULATOR//模拟器
    BOOL simulator = YES;
#elif TARGET_OS_IPHONE//真机
    BOOL simulator = false;

#endif
    return simulator;
}
+ (NSDictionary *)useGyroPull{
    //初始化全局管理对象
    CMMotionManager *manager = [[CMMotionManager alloc] init];
//    self.motionManager = manager;
    //判断加速度计可不可用，判断加速度计是否开启
    if ([manager isGyroAvailable]){
        //告诉manager，更新频率是100Hz
        manager.gyroUpdateInterval = 0.01;
        //开始更新，后台线程开始运行。这是Pull方式。
        [manager startGyroUpdates];
    }
    //获取并处理加速度计数据
    CMGyroData *data = manager.gyroData;
    NSString *x = [NSString stringWithFormat:@"%.04f",data.rotationRate.x];
    NSString *y = [NSString stringWithFormat:@"%.04f",data.rotationRate.y];
    NSString *z = [NSString stringWithFormat:@"%.04f",data.rotationRate.z];

    NSDictionary *dic = @{@"x":x,@"y":y,@"z":z};
    return dic;
//    CMAccelerometerData *newestAccel = manager.accelerometerData;
//    NSLog(@"X = %.04f",newestAccel.acceleration.x);
//    NSLog(@"Y = %.04f",newestAccel.acceleration.y);
//    NSLog(@"Z = %.04f",newestAccel.acceleration.z);
}

#pragma mark - 获取手机外网IP
+(NSString *)getWANIPAddress {
    NSError *error;
    NSURL *ipURL = [NSURL URLWithString:@"http://pv.sohu.com/cityjson?ie=utf-8"];
    NSMutableString *ip = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
    //判断返回字符串是否为所需数据
    if ([ip hasPrefix:@"var returnCitySN = "]) {
        //对字符串进行处理，然后进行json解析
        //删除字符串多余字符串
        NSRange range = NSMakeRange(0, 19);
        [ip deleteCharactersInRange:range];
        NSString *nowIp = [ip substringToIndex:ip.length-1];
        //将字符串转换成二进制进行Json解析
        NSData *data = [nowIp dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        return dict[@"cip"] ? dict[@"cip"] : @"";
    }
    return @"";
}
    

#pragma mark - 获取WIFI信号强度
//+(NSInteger)getSignalStrength{
//    UIApplication *app = [UIApplication sharedApplication];
//    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
//    NSString *dataNetworkItemView = nil;
//
//    for (id subview in subviews) {
//        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
//            dataNetworkItemView = subview;
//            break;
//        }
//    }
//
//    NSInteger signalStrength = [[dataNetworkItemView valueForKey:@"_wifiStrengthBars"] integerValue];
//
//    return signalStrength;
//}

+ (NSString *)getBuildVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
#pragma mark - 获取WIFI信号强度
// 3: 强 ，2：中， 1：弱 ，无
+ (NSInteger)getSignalStrength{
    
    UIApplication *app =[UIApplication sharedApplication];
    
    // iphoneX状态栏和其他iPhone设备不同，变化比较大
    
    //判断是否是iPhoneX
    
    if([[app valueForKeyPath:@"_statusBar"] isKindOfClass:
        NSClassFromString(@"UIStatusBar_Modern")]){
        
        NSString *wifiEntry =[[[
                                [app valueForKey:@"statusBar"] valueForKey:@"_statusBar"] valueForKey:@"_currentAggregatedData"] valueForKey:@"_wifiEntry"];
        
        int signalStrength =[[wifiEntry valueForKey:@"_displayValue"] intValue];
        return signalStrength;
    }
    
    else{
        
        NSInteger signalStrength = 0;
        NSArray *subviews =[[[app valueForKey:@"statusBar"]
                             valueForKey:@"foregroundView"]subviews];
        
        NSString *dataNetworkItemView = nil;
        
        for(id subview in subviews){
            if([subview isKindOfClass:
                [NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]){
                dataNetworkItemView = subview;
                break;
            }
        }
        signalStrength = [[dataNetworkItemView valueForKey:@"_wifiStrengthBars"] intValue];
        return signalStrength;
    }
}
                             

/**
 获取是否满电
 @return getbatteryStatus
 */
+(BOOL)getBatteryStatus
{
    UIDevice * device = [UIDevice currentDevice];
    //是否允许监测电池
    //要想获取电池状态和监控电池状态 必须允许
    device.batteryMonitoringEnabled = YES;
    UIDeviceBatteryState state = device.batteryState;
    if(state == UIDeviceBatteryStateFull){
        return YES;
    }
    return NO;
}

/**
 获取是否正在充电
 @return getAlcidine
 */
+(BOOL)getAlcidine
{
    UIDevice * device = [UIDevice currentDevice];
    //是否允许监测电池
    //要想获取电池状态和监控电池状态 必须允许
    device.batteryMonitoringEnabled = YES;
    UIDeviceBatteryState state = device.batteryState;
    if(state == UIDeviceBatteryStateUnplugged){
        return NO;
    }else if (state == UIDeviceBatteryStateCharging){
        return YES;
    }
    return NO;
}

/// 获取手机出厂时间
+ (NSTimeInterval)getAbsoluteTime {
    UIDevice *device = [UIDevice currentDevice];
    NSDictionary *systemAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSDate *creationDate = systemAttributes[NSFileCreationDate];

    if (creationDate) {
        return [creationDate timeIntervalSince1970];
    } else {
        return 0;
    }
}
///获取当前时区
+ (NSString *)timeZone {
    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
    return [currentTimeZone abbreviation] ?: @"";
}

///获取当前是否使用代理
+ (BOOL)isUsingProxy {
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

///获取当前是否使用VPN
+ (BOOL)getIsVPNOn
{
   BOOL flag = NO;
   NSString *version = [UIDevice currentDevice].systemVersion;
   // need two ways to judge this.
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
       struct ifaddrs *interfaces = NULL;
       struct ifaddrs *temp_addr = NULL;
       int success = 0;
       
       // retrieve the current interfaces - returns 0 on success
       success = getifaddrs(&interfaces);
       if (success == 0)
       {
           // Loop through linked list of interfaces
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
       
       // Free memory
       freeifaddrs(interfaces);
   }


   return flag;
}

+ (NSString *)getWifiMac{
    if ([[AFNetworkReachabilityManager sharedManager]isReachableViaWiFi]) {
        CFArrayRef myArray = CNCopySupportedInterfaces();
        if (myArray != nil) {
            CFDictionaryRef myDict =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
            if (myDict != nil) {
                NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
                id ssiddata = [dict valueForKey:@"SSIDDATA"];
                NSString *mac = [[NSString alloc] initWithData:ssiddata encoding:NSUTF8StringEncoding];
                return mac;
            }
        }
    }
    return nil;
}
@end
