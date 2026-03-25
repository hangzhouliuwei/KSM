//
//  XTDevice.h
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import <Foundation/Foundation.h>
#if __has_include(<AppTrackingTransparency/AppTrackingTransparency.h>)
    #import <AppTrackingTransparency/AppTrackingTransparency.h>
#endif
#import <AdSupport/AdSupport.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTDevice : NSObject


//语言en/zh
@property(nonatomic,copy) NSString *xt_language;
//idfv
@property(nonatomic,copy) NSString *xt_idfv;
//uuid
@property(nonatomic,copy) NSString *xt_uuid;
//网络
@property(nonatomic,copy) NSString *xt_networkType;
//系统版本
@property(nonatomic,copy) NSString *xt_sysVersion;
//手机型号
@property(nonatomic,copy) NSString *xt_mobileStyle;
//手机可用存储
@property(nonatomic,copy) NSString *xt_usableDiskSize;
//手机总存储
@property(nonatomic,copy) NSString *xt_totalDiskSize;
//手机可用存储
@property(nonatomic,copy) NSString *xt_usableMemorySize;
//手机总存储
@property(nonatomic,copy) NSString *xt_totalMemorySize;
//剩余电量
@property(nonatomic,copy) NSString *xt_usableQuantity;
//是否满电
@property(nonatomic,copy) NSString *xt_isFullQuantity;
//是否充电
@property(nonatomic,copy) NSString *xt_isCharging;
//分辨率高
@property(nonatomic,copy) NSNumber *xt_screenHeight;
//分辨率宽
@property(nonatomic,copy) NSNumber *xt_screenWidth;
//物理尺寸
@property(nonatomic,copy) NSString *xt_physicalSize;
//出厂时间
@property(nonatomic,copy) NSNumber *xt_deliveryTime;
///模拟器
@property(nonatomic,copy) NSString *xt_simulator;
///当前时区
@property(nonatomic,copy) NSString *xt_localTimeZone;
//是否使用代理
@property(nonatomic,copy) NSString *xt_isProxy;
//是否使用vpn
@property(nonatomic,copy) NSString *xt_isVPN;
///运营商
@property(nonatomic,copy) NSString *xt_phoneOperator;
///外网ip
@property(nonatomic,copy) NSString *xt_ipAddress;

+ (instancetype)xt_share;

///检查网络
- (void)xt_checkNetWork:(void (^)(BOOL have))block;
///获取idfa
+ (void)xt_getIdfaShowAlt:(BOOL)showAlt block:(void (^)(NSString *idfa))block;
///所有设备信息
-(NSDictionary *)xt_deviceInfoDic;

//第一次安装时间
-(NSString *)xt_firstAppTime;

/// 修复首次获取idfa错误
+ (void)fixTrackingAuthorizationWithCompletion:(void (^)(ATTrackingManagerAuthorizationStatus status))completion API_AVAILABLE(ios(14));

@end

NS_ASSUME_NONNULL_END
