//
//  NSObject+getDeviceInfo.h
//  NewBag
//
//  Created by Jacky on 2024/3/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (getDeviceInfo)
/// idfa
+ (void )getIdfa:(void(^)(NSString *idfa))block;

+ (NSString *)lanuage;
/**
 获取设备IDFVString

 @return 1
 */
+ (NSString *)getIDFV;

/**
 获取设备UUIDString

 @return  1
 */
+ (NSString *)getUUID;

/**
 获取网络状态

 @return  1
 */
+(NSString *) getNetworkType;

/**
 获取iOS系统版本号

 @return 1
 */
+ (NSString *)getIOSVersion;

/**
 获取手机型号

 @return 1
 */
+(NSString*)getMobileStyle;

/// 设备尺寸
+ (NSString *)getScreenSize;
/**
 获取手机电量
 
 @return 返回手机电量
 */
+ (NSInteger)getBatteryQuantity;
/**
 获取用户WiFi名
 注：调用该方法时给10秒
 @return 有返回WiFi名  返回nil时可能用户不在下
 */
+ (NSString *)getWifiName;

/**
 获取BSSID

 @return bssid
 */
+ (NSString *)getBSSID;
/**
 获取用户手机运营商
 @return 有返回运营商，获取不到直接返回nil
 */
+ (NSString *)getPhoneOperator;

/**
 获取运营商国家编码 + 网络编码

 @return
 */
+ (NSString *)getTeleNum;

/**
 获取总内存大小
 
 @return
 */
+(NSString *)getTotalMemorySize;

/**
 获取可用内存大小
 
 @return
 */
+(NSString *)getAvailableMemorySize;

/**
 获取总磁盘大小
 
 @return
 */
+(NSString *)getTotalDiskSize;

/**
 获取可用磁盘大小
 
 @return
 */
+(NSString *)getAvailableDiskSize;

/**
 是否越狱

 @return bool
 */
+ (BOOL)isJailbroken;


/**
 判断是否是模拟器

 @return
 */
+ (BOOL)isSimulator;

/**
 获取陀螺仪信息

 @return x y z
 */
+ (NSDictionary *)useGyroPull;

/**
 获取手机外网IP
 */
+(NSString *)getWANIPAddress;
/**
 获取手机内网IP
 */
+(NSString *)getIPAddress;

/**
 获取WIFI信号强度
 */
+(NSInteger)getSignalStrength;

/**
 获取buildversion

 @return buildversion
 */
+ (NSString *)getBuildVersion;
/**
 获取是否满电
 @return getbatteryStatus
 */
+(BOOL)getBatteryStatus;
/**
 获取是否正在充电
 @return getAlcidine
 */
+(BOOL)getAlcidine;
///屏幕宽
+(CGFloat)getScreenWidth;
//屏幕高
+(CGFloat)getScreenHeight;
/// 获取手机出厂时间
+ (NSTimeInterval)getAbsoluteTime;
///获取当前时区
+ (NSString *)timeZone;
///获取当前是否使用代理
+ (BOOL)isUsingProxy;
///获取当前是否使用VPN
+ (BOOL)getIsVPNOn;
+ (NSString *)getWifiMac;
/// 物理尺寸
+ (NSString *)physicalDimensions;
///获取外网地址
+ (NSString *)br_getIPAddress;

@end

NS_ASSUME_NONNULL_END
