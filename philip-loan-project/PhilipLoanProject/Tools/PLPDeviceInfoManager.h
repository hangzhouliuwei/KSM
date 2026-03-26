//
//  DeviceInfoManager.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PLPDeviceInfoManager : NSObject


+(NSString *)getUseDiskMemory;
+(NSString *)getTotalDiskMemory;
+(NSString *)getTotalMemory;
+(NSString *)getUseMemory;


+(NSInteger)queryBatteryValue;
+(BOOL)queryBatteryStatus;
+(BOOL)queryBatteryisIn;

+(NSString *)hardSystemVersion;
+(NSString *)hardDeviceStyle;
+(CGFloat)hardResolvingWidth;
+(CGFloat)hardResolvingHeight;
+(NSString *)hardPhysicSize;
+(NSTimeInterval)hardDeviceTimeStamp;

+(NSString *)otherSignalStrength;
+(BOOL)otherIsSimulator;
+(BOOL)otherIsRoot;

+(NSString *)generateTimeZone;
+(BOOL)generateUseDelegate;
+(BOOL)generateUseVPN;
+(NSString *)generateOperatorName;
+(NSString *)generateIDFV;
+(NSString *)generateLanguage;
+(NSString *)generateNetType;
+(NSString *)generatePhoneType;
+(NSString *)generateIPAddress;
+(NSString *)generateIDFA;

+(NSString *)networkBaseIdentifier;
+(NSString *)networkServeIdentifier;
+(NSString *)networkMac;
+(NSString *)networkName;

@end

NS_ASSUME_NONNULL_END
