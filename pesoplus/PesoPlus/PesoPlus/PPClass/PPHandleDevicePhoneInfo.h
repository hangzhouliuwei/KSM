//
//  PPHandleDevicePhoneInfo.h
// FIexiLend
//
//  Created by jacky on 2024/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPHandleDevicePhoneInfo : UIView
+ (NSString *)mirjhaDeviceversion;
+ (NSString *)mirjhaDevicedeviceName;

+ (NSString *)mirjhaDeviceidfa;
+ (NSString *)mirjhaDevicebuildVersion;
+ (NSString *)mirjhaDevicesystemVersion;
+(NSString*)mirjhaDevicenewIDFV;

+(NSDictionary*)mirjhaDevicegetParameFromURL:(NSURL *)url;
+ (NSString *)mirjhaDeviceidfv;
+ (NSString *)mirjhaDeviceip;
+ (NSInteger)mirjhaDevicebatteryLevel;
+ (BOOL)mirjhaDeviceisCharging;
+ (NSString *)mirjhaDevicepackageName;
+ (NSString *)mirjhaDevicebundleId;

+ (NSString *)mirjhaDevicedeviceSize;
+ (CGFloat)mirjhaDevicedeviceWidth;

+ (NSString *)mirjhaDevicegetTotalMemorySize;
+ (NSString *)mirjhaDevicegetAvailableMemorySize;
+ (UIDeviceBatteryState)mirjhaDevicebatteryState;
+ (BOOL)mirjhaDevicegetBatteryStatus;
+ (NSTimeInterval)mirjhaDevicegetDeviceProTime;
+ (NSString *)mirjhaDevicetimeZone;
+ (NSString *)mirjhaDevicedeviceType;

+ (CGFloat)mirjhaDevicedeviceHeight;
+ (NSString *)mirjhaDevicegetTotalDiskSize;

+ (NSString *)mirjhaDevicegetWifiName;
//mirjhaDevicecreateRandomUUIDWithLenght
+ (NSString *)mirjhaDevicecreateRandomUUIDWithLenght:(NSInteger)lenght;
//mirjhaDevicegetAvailableDiskSize
+ (NSString *)mirjhaDevicegetAvailableDiskSize;
+ (NSString *)mirjhaDevicedeviceLanuage;
+ (NSString *)mirjhaDevicegetBSSID;
+ (NSString *)mirjhaDevicenetworkStatus;

+ (NSString *)mirjhaDevicedeviceModelName;
+ (BOOL)mirjhaDeviceisJailbroken;
+ (NSString *)mirjhaDevicegetSIMCardInfo;
+ (BOOL)mirjhaDeviceisSimulator;

+ (BOOL)mirjhaDeviceisUseProxy;
+ (BOOL)mirjhaDeviceisUseVPN;

+ (NSString*)mirjhaDevicefirstInstallation;

@end

NS_ASSUME_NONNULL_END
