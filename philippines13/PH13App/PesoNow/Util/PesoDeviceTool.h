//
//  PesoDeviceTool.h
//  PesoApp
//
//  Created by Jacky on 2024/9/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoDeviceTool : NSObject
+ (NSString *)version;
+ (NSString *)deviceName;
+ (NSString *)buildVersion;
///获取iOS系统版本号
+ (NSString *)systemVersion;
+ (NSString *)idfa;
+ (NSString *)idfv;
+ (NSString *)packageName;
+ (NSString *)bundleId;
+ (NSString *)ip;
+ (NSInteger)batteryLevel;
///获取是否正在充电
+ (BOOL)isCharging;
//+ (UIDeviceBatteryState)batteryState;
+ (BOOL)getBatteryStatus;
///获取总内存大小
+ (NSString *)getTotalMemorySize;
///获取可用内存
+ (NSString *)getAvailableMemorySize;
///获取总磁盘大小
+ (NSString *)getTotalDiskSize;
///获取可用磁盘大小
+ (NSString *)getAvailableDiskSize;
+ (NSString *)deviceType;
+ (NSString *)deviceSize;
+ (CGFloat)deviceWidth;
+ (CGFloat)deviceHeight;
+ (NSString *)networkStatus;
+ (NSString *)getSIMCardInfo;
+ (BOOL)isJailbroken;
+ (BOOL)isSimulator;
+ (NSTimeInterval)getDeviceProTime;
+ (NSString *)timeZone;
///是否使用vpn
+ (BOOL)isUseProxy;
///是否使用代理
+ (BOOL)isUseVPN;
+ (NSString *)deviceLanuage;
+ (NSString *)getBSSID;
+ (NSString *)getWifiName;
///生成一串随机数
+ (NSString *)createRandomUUID;
///首次安装时间
+ (NSString*)firstInstallation;
///获取实时IDFV
+(NSString*)newIDFV;

+(NSDictionary*)getDevices;
@end

NS_ASSUME_NONNULL_END
