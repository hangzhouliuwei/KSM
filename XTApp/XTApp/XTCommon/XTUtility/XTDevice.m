//
//  XTDevice.m
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import "XTDevice.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import <SAMKeychain.h>
#import <sys/utsname.h>
#import <mach/mach.h>
#import <os/proc.h>
#include <ifaddrs.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import<SystemConfiguration/CaptiveNetwork.h>
#import<SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"



@interface XTDevice ()

///是否弹出过提示框
@property(nonatomic) BOOL xt_showIdfaAlt;
//第一次安装时间
@property(nonatomic,copy) NSString *xt_firstTime;

@end

@implementation XTDevice

+(instancetype)xt_share {
    static XTDevice *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc]init];
    });
    return shareInstance;
}
///检查网络
- (void)xt_checkNetWork:(void (^)(BOOL have))block{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    __weak AFNetworkReachabilityManager *weekManage = manager;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                if(block){
                    block(YES);
                }
                
            }break;
            default:{
                if(block){
                    block(NO);
                }
                break;
            }
        }
    }];
}

+ (void)xt_requestTrackingAuthorizationWithCompletion:(void (^)(ATTrackingManagerAuthorizationStatus status))completion  API_AVAILABLE(ios(14)){
    if (@available(iOS 14.0, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            if (status == ATTrackingManagerAuthorizationStatusDenied && [ATTrackingManager trackingAuthorizationStatus] == ATTrackingManagerAuthorizationStatusNotDetermined) {
                NSLog(@"iOS 17.4 ATT bug detected");
                if (@available(iOS 15.0, *)) {
                    __block id observer = nil;
                    observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
                        [[NSNotificationCenter defaultCenter] removeObserver:observer];
                        observer = nil;
                        [self xt_requestTrackingAuthorizationWithCompletion:completion];
                    }];
                } else {
                    // Fallback on earlier versions
                }
            } else {
                completion(status);
            }
        }];
    } else {
        // For iOS versions below 14, directly return not determined status
        if (completion) {
            completion(ATTrackingManagerAuthorizationStatusNotDetermined);
        }
    }
}

+ (void)xt_getIdfaShowAlt:(BOOL)showAlt block:(void (^)(NSString *idfa))block{

    __block NSString *idfa = @"";
    if (@available(iOS 14.0, *)){
        [self xt_requestTrackingAuthorizationWithCompletion:^(ATTrackingManagerAuthorizationStatus status) {
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                // 获取到权限后，依然使用老方法获取idfa
                if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                    idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    //                NSLog(@"%@",idfa);
                    block(idfa);
                } else if(status == ATTrackingManagerAuthorizationStatusNotDetermined){
                    if(showAlt){
                        
                    }
                } else{
                    block(idfa);
                    if(showAlt){
                       
                    }
                    XTLog(@"请在设置-隐私-跟踪中允许App请求跟踪");
                }
            }];
        }];
    }
    else {
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
//            NSLog(@"%@",idfa);
            block(idfa);
        } else {
            block(idfa);
            if(showAlt){
               // [[XTDevice xt_share] xt_showIdfaAltVC];
            }
            XTLog(@"请在设置-隐私-广告中打开广告跟踪功能");
        }
    }
}

//- (void)xt_showIdfaAltVC{
//    if(self.xt_showIdfaAlt){
//        return;
//    }
//    @weakify(self)
//    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Permission" message:@"Request IDFA Permission, Your data will be used to deliver personalized ads to you " preferredStyle:UIAlertControllerStyleAlert];
//    [alertVC addAction: [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        @strongify(self)
//        self.xt_showIdfaAlt = YES;
//    }]];
//    [alertVC addAction: [UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        @strongify(self)
//        self.xt_showIdfaAlt = YES;
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
//        }];
//    }
//    }]];
//    [[XTUtility xt_getCurrentVCInNav] presentViewController:alertVC animated:true completion:nil];
//}

//第一次安装时间
-(NSString *)xt_firstAppTime{
    if(!self.xt_firstTime){
        NSString *appTime = [SAMKeychain passwordForService:XT_App_BundleId account:@"firstAppTime"];
        if (!appTime || appTime.length == 0) {
            unsigned long long time = [[NSDate date] timeIntervalSince1970];
            self.xt_firstTime = [NSString stringWithFormat:@"%llu000",time];
            [SAMKeychain setPassword:self.xt_firstTime forService:XT_App_BundleId account:@"xt_firstAppTime"];
        }
    }
    return self.xt_firstTime;
}

- (NSString *)xt_language{
    if(!_xt_language){
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
        _xt_language = [allLanguages firstObject];
    }
    return _xt_language;
}

- (NSString *)xt_idfv{
    if(!_xt_idfv){
        NSString *idfvStr = [SAMKeychain passwordForService:XT_App_BundleId account:@"xt_idfv"];
        if (idfvStr == nil || [idfvStr isEqualToString:@""]) {
            NSUUID *deviceUUID  = [UIDevice currentDevice].identifierForVendor;
            idfvStr = deviceUUID.UUIDString;
            [SAMKeychain setPassword:idfvStr forService:XT_App_BundleId account:@"xt_idfv"];
        }
        
        _xt_idfv = idfvStr;
    }
    return _xt_idfv;
}

- (NSString *)xt_uuid{
    if(!_xt_uuid){
        NSString *uuidStr = [SAMKeychain passwordForService:XT_App_BundleId account:@"xt_uuid"];
        if (uuidStr == nil || [uuidStr isEqualToString:@""]) {
            uuidStr = [NSUUID UUID].UUIDString;
            [SAMKeychain setPassword:uuidStr forService:XT_App_BundleId account:@"xt_uuid"];
        }
        _xt_uuid = uuidStr;
    }
    return _xt_uuid;
}

- (NSString *)xt_networkType {
    Reachability *wifi = [Reachability reachabilityForInternetConnection];
    NSString *xt_networkType = @"";
    //2g,3g
    if (wifi.currentReachabilityStatus == ReachableViaWiFi) {
        xt_networkType = @"wifi";
    }
    else if (wifi.currentReachabilityStatus == ReachableViaWWAN) {
        //wifi
        xt_networkType = @"4g";
    }
    return xt_networkType;
}

- (NSString *)xt_mobileStyle {
    if(!_xt_mobileStyle) {
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        NSURL *url = [[NSBundle mainBundle]  URLForResource:@"XTMobile.plist" withExtension:nil];
        NSDictionary *mobileDic = [NSDictionary dictionaryWithContentsOfURL:url];
        _xt_mobileStyle = XT_Object_To_Stirng(mobileDic[platform]);
    }
    return _xt_mobileStyle;
}

- (NSString *)xt_sysVersion{
    if(!_xt_sysVersion) {
        _xt_sysVersion = [[UIDevice currentDevice] systemVersion];
    }
    return _xt_sysVersion;
}
///总磁盘大小
- (NSString *)xt_totalDiskSize{
    if(!_xt_totalDiskSize){
        unsigned long long size = 0;
        NSError *error;
        NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
        if (error) {
    #ifdef DEBUG
            XTLog(@"error: %@", error.localizedDescription);
    #endif
        }
        else {
     
            NSNumber *number = [dic objectForKey:NSFileSystemSize];
            size = [number unsignedLongLongValue];
     
        }
        _xt_totalDiskSize = [NSString stringWithFormat:@"%llu",size];
    }
    return _xt_totalDiskSize;
}
///可用磁盘大小
- (NSString *)xt_usableDiskSize{
    if(!_xt_usableDiskSize) {
        unsigned long long size = 0;
        NSError *error;
     
        NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
        if (error) {
        #ifdef DEBUG
            XTLog(@"error: %@", error.localizedDescription);
        #endif
        }
        else {
            NSNumber *number = [dic objectForKey:NSFileSystemFreeSize];
            size = [number unsignedLongLongValue];
        }
        _xt_usableDiskSize = [NSString stringWithFormat:@"%llu",size];
    }
    return _xt_usableDiskSize;
}
///可用内存
- (NSString *)xt_usableMemorySize{
    if(!_xt_usableMemorySize){
        NSString *usedBytes = @"0";
        NSByteCountFormatter *bytesFormatter = [[NSByteCountFormatter alloc] init];
        [bytesFormatter setAllowedUnits:NSByteCountFormatterUseBytes];
        [bytesFormatter setCountStyle:NSByteCountFormatterCountStyleBinary];
        mach_task_basic_info_data_t info;
        mach_msg_type_number_t count = MACH_TASK_BASIC_INFO_COUNT;
        kern_return_t kerr = task_info(mach_task_self(),
                                       MACH_TASK_BASIC_INFO,
                                       (task_info_t)&info,
                                       &count);
        if (kerr == KERN_SUCCESS) {
            int64_t used_bytes = info.resident_size;
            usedBytes = [NSString stringWithFormat:@"%lld", used_bytes];
        }
        _xt_usableMemorySize = usedBytes;
    }
    return _xt_usableMemorySize;
}
///总内存
- (NSString *)xt_totalMemorySize{
    if(!_xt_totalMemorySize){
        double size = [NSProcessInfo processInfo].physicalMemory;
        _xt_totalMemorySize = [NSString stringWithFormat:@"%.f",size];
    }
    return _xt_totalMemorySize;
}
///剩余电量
- (NSString *)xt_usableQuantity{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    CGFloat num = [[UIDevice currentDevice] batteryLevel];
    return [NSString stringWithFormat:@"%.2f",num * 100];
}

- (NSString *)xt_isFullQuantity{
    UIDevice *currentDevice = [UIDevice currentDevice];
    currentDevice.batteryMonitoringEnabled = YES;
    UIDeviceBatteryState batteryState = currentDevice.batteryState;
    if(batteryState == UIDeviceBatteryStateFull){
        return @"1";
    }
    return @"0";
}
///是否充电
- (NSString *)xt_isCharging{
    UIDevice *currentDevice = [UIDevice currentDevice];
    currentDevice.batteryMonitoringEnabled = YES;
    UIDeviceBatteryState batteryState = currentDevice.batteryState;
    if (batteryState == UIDeviceBatteryStateCharging){
        return @"1";
    }
    return @"0";
}

///分辨率高
- (NSNumber *)xt_screenHeight{
    if(!_xt_screenHeight){
        _xt_screenHeight = @([[UIScreen mainScreen] nativeBounds].size.height);
    }
    return _xt_screenHeight;
}
///分辨率宽
- (NSNumber *)xt_screenWidth{
    if(!_xt_screenWidth){
        _xt_screenWidth = @([[UIScreen mainScreen] nativeBounds].size.width);
    }
    return _xt_screenWidth;
}
///物理尺寸
- (NSString *)xt_physicalSize{
    if(!_xt_physicalSize){
        _xt_physicalSize = [NSString stringWithFormat:@"%0.1f",sqrt(self.xt_screenWidth.floatValue * self.xt_screenWidth.floatValue + self.xt_screenHeight.floatValue * self.xt_screenHeight.floatValue)];
    }
    return _xt_physicalSize;
}
///出厂时间
- (NSNumber *)xt_deliveryTime{
    if(!_xt_deliveryTime){
        NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
        NSDate *date = dic[NSFileCreationDate];
        if (date) {
            _xt_deliveryTime = @([date timeIntervalSince1970]);
        } else {
            _xt_deliveryTime = @0;
        }
    }
    return _xt_deliveryTime;
}

- (NSString *)xt_simulator{
    if(!_xt_simulator){
#if TARGET_IPHONE_SIMULATOR//模拟器
    BOOL isSimulator = YES;
#elif TARGET_OS_IPHONE//真机
    BOOL isSimulator = false;

#endif
        _xt_simulator = isSimulator ? @"1" : @"0";
    }
    return _xt_simulator;
}
///时区
- (NSString *)xt_localTimeZone{
    if(!_xt_localTimeZone){
        _xt_localTimeZone = [NSTimeZone localTimeZone].abbreviation ? [NSTimeZone localTimeZone].abbreviation : @"";
    }
    return _xt_localTimeZone;
}
///是否使用代理
- (NSString *)xt_isProxy{
    NSDictionary *proxySettings =  (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"http://www.google.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    if(!proxies || proxies.count == 0){
        return @"0";
    }
    NSDictionary *settings = [proxies objectAtIndex:0];
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]){
        //没有设置代理
        return @"0";
    }else{
        //设置代理了
        return @"1";
    }
}
///是否使用VPN
- (NSString *)xt_isVPN{
    BOOL isFlag = NO;
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    // need two ways to judge this.
    if (systemVersion.doubleValue >= 9.0) {
        NSDictionary *dic = CFBridgingRelease(CFNetworkCopySystemProxySettings());
        NSArray *keyArr = [dic[@"__SCOPED__"] allKeys];
        for (NSString *keyStr in keyArr) {
            if ([keyStr rangeOfString:@"tap"].location != NSNotFound ||
                [keyStr rangeOfString:@"tun"].location != NSNotFound ||
                [keyStr rangeOfString:@"ipsec"].location != NSNotFound ||
                [keyStr rangeOfString:@"ppp"].location != NSNotFound){
                isFlag = YES;
                break;
            }
        }
    }
    else {
        struct ifaddrs *interface = NULL;
        struct ifaddrs *tempAddr = NULL;
        int isSuccess = 0;
        isSuccess = getifaddrs(&interface);
        if (isSuccess == 0) {
            tempAddr = interface;
            while (tempAddr != NULL) {
                NSString *str = [NSString stringWithFormat:@"%s" , tempAddr->ifa_name];
                if ([str rangeOfString:@"tap"].location != NSNotFound ||
                    [str rangeOfString:@"tun"].location != NSNotFound ||
                    [str rangeOfString:@"ipsec"].location != NSNotFound ||
                    [str rangeOfString:@"ppp"].location != NSNotFound) {
                    isFlag = YES;
                    break;
                }
                tempAddr = tempAddr->ifa_next;
            }
        }
        freeifaddrs(interface);
    }
    return isFlag ? @"1" : @"0";
}
///运营商
- (NSString *)xt_phoneOperator{
    CTCarrier *cellularProvider = [[[CTTelephonyNetworkInfo alloc] init] subscriberCellularProvider];
    if (cellularProvider.isoCountryCode) {
        return [cellularProvider carrierName];
    }
    return @"";
}
///外网ip
- (NSString *)xt_ipAddress{
    NSMutableString *ipStr = [NSMutableString stringWithContentsOfURL:[NSURL URLWithString:@"https://pv.sohu.com/cityjson?ie=utf-8"] encoding:NSUTF8StringEncoding error:nil];
    //判断返回字符串是否为所需数据
    if ([ipStr hasPrefix:@"var returnCitySN = "]) {
        NSRange range = NSMakeRange(0, 19);
        [ipStr deleteCharactersInRange:range];
        NSString *ip = [ipStr substringToIndex:ipStr.length-1];

        NSData *data = [ip dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        return dic[@"cip"] ? dic[@"cip"] : @"";
    }
    return @"";
}

- (NSString *)xt_bssidString{
    Reachability *wifi = [Reachability reachabilityForInternetConnection];
    if (wifi.currentReachabilityStatus == ReachableViaWiFi) {
        CFArrayRef arr = CNCopySupportedInterfaces();
        if (arr != nil) {
            CFDictionaryRef myDic =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(arr, 0));
            if (myDic != nil) {
                NSDictionary *dic = (NSDictionary*)CFBridgingRelease(myDic);
                NSString *bssidStr = [dic valueForKey:@"BSSID"];
                bssidStr = bssidStr ? [self xt_getFormateMAC:bssidStr] : bssidStr;
                return bssidStr;
            }
        }
    }
    NSString *ssid = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info[@"BSSID"]) {
            ssid = info[@"BSSID"];
            break;
        }
    }
    return ssid;
}

- (NSString *)xt_getFormateMAC:(NSString *)mac {
    NSArray *subArr = [mac componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":-"]];
    NSMutableArray *subStrArr = [NSMutableArray array];
    for (NSString *str in subArr) {
        if (1 == str.length) {
            NSString *tempStr = [NSString stringWithFormat:@"0%@", str];
            [subStrArr addObject:tempStr];
        } else {
            [subStrArr addObject:str];
        }
    }
    NSString *str = [subStrArr componentsJoinedByString:@":"];
    return [str uppercaseString];
}

///获取wifi名字
-(NSString *)xt_wifiName{

    Reachability *wifi = [Reachability reachabilityForInternetConnection];
    if (wifi.currentReachabilityStatus == ReachableViaWiFi) {
        CFArrayRef arr = CNCopySupportedInterfaces();
        if (arr != nil) {
            CFDictionaryRef myDic =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(arr, 0));
            if (myDic != nil) {
                NSDictionary *dic = (NSDictionary*)CFBridgingRelease(myDic);
                return [dic valueForKey:@"SSID"];
            }
        }
    }
    NSString *ssid = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info[@"SSID"]) {
            ssid = info[@"SSID"];
            break;
        }
    }
    return ssid;
}

///所有设备信息
-(NSDictionary *)xt_deviceInfoDic{
    ///磁盘
    NSDictionary *zoeilaismNcDic = @{
        @"chyssixalidesNc":XT_Object_To_Stirng(self.xt_usableDiskSize),///可用存储
        @"ebdisixcNc":XT_Object_To_Stirng(self.xt_totalDiskSize),///总存储
        @"sclisixmazelNc":XT_Object_To_Stirng(self.xt_totalMemorySize),///总内存
        @"hiacsixkNc":XT_Object_To_Stirng(self.xt_usableMemorySize),///内存可用大小
    };
    ///电量
    NSDictionary *battery_statusDic = @{
        @"delasixsseNc":XT_Object_To_Stirng(self.xt_usableQuantity),///剩余电量
        @"battery_status":XT_Object_To_Stirng(self.xt_isFullQuantity),///是否满电
        @"akavsixitNc":XT_Object_To_Stirng(self.xt_isCharging),///是否充电
    };
    ///设备信息
    NSDictionary *hardwareDic = @{
        @"xeotsiximeNc":XT_Object_To_Stirng(self.xt_sysVersion),///系统版本
        @"prtusixbercularNc":@"iPhone",///设备名牌
        @"bauvsixrihiNc":XT_Object_To_Stirng(self.xt_mobileStyle),///设备型号
        @"pemesixanceNc":self.xt_screenHeight,///分辨率高
        @"sttusixsNc":self.xt_screenWidth,///分辨率宽
        @"soensixoidNc":XT_Object_To_Stirng(self.xt_physicalSize),///物理尺寸
        @"terasixNc":self.xt_deliveryTime,///出厂时间
    };
    ///todo
    NSDictionary *coeinchNcDic = @{
        
    };
    ///信号
    NSDictionary *waeiltyNcDic = @{
        @"brezsixinessNc":@"0",/// 信号强度，传0即可
        @"deissixableNc":XT_Object_To_Stirng(self.xt_simulator),///是否为模拟器
        @"sinmsixanNc":@0,///是否越狱
    };
    
    ///运营商
    NSMutableDictionary *reeiencounterNcDic = [NSMutableDictionary dictionaryWithDictionary:@{
        @"ovresixxertNc":XT_Object_To_Stirng(self.xt_localTimeZone),///时区
        @"pltisixniferousNc":XT_Object_To_Stirng(self.xt_isProxy),///是否使用代理 0、1
        @"sumesixrgibleNc":XT_Object_To_Stirng(self.xt_isVPN),///是否使用vpn 0、1
        @"conssixellorNc":XT_Object_To_Stirng(self.xt_phoneOperator),///运营商
        @"manisixcideNc":XT_Object_To_Stirng(self.xt_idfv),
        @"tuedsixoNc":XT_Object_To_Stirng(self.xt_language),
        @"leelsixlingNc":XT_Object_To_Stirng(self.xt_networkType),///网络类型
        @"bahlsixykNc":@1,///指示设备电话类型的常量1 手机;2 平板
        @"deodsixulateNc":XT_Object_To_Stirng(self.xt_ipAddress),///外网ip
    }];
    [XTDevice xt_getIdfaShowAlt:NO block:^(NSString * _Nonnull idfa) {
        [reeiencounterNcDic setObject:XT_Object_To_Stirng(idfa) forKey:@"patusixrageNc"];
    }];
    ///wifi
    NSDictionary *paeitricentricNcDic = @{
        @"mitisixmeNc":XT_Object_To_Stirng([self xt_bssidString]),
        @"frscsixatiNc":XT_Object_To_Stirng([self xt_wifiName]),
        @"koobsixehNc":XT_Object_To_Stirng([self xt_bssidString]),
        @"uporsixnNc":XT_Object_To_Stirng([self xt_wifiName]),
    };
    return @{
        @"zoaisixsmNc":zoeilaismNcDic,
        @"battery_status":battery_statusDic,
        @"hardware":hardwareDic,
        @"cochsixNc":coeinchNcDic,
        @"watysixNc":waeiltyNcDic,
        @"rencsixounterNc":reeiencounterNcDic,
        @"eatesixrnizeNc":@{
            @"parisixcentricNc":@[paeitricentricNcDic],
        },
    };
}


/// 修复首次获取idfa错误
+ (void)fixTrackingAuthorizationWithCompletion:(void (^)(ATTrackingManagerAuthorizationStatus status))completion API_AVAILABLE(ios(14))
{
    
    if (@available(iOS 14.0, *)) {
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                if (status == ATTrackingManagerAuthorizationStatusDenied && [ATTrackingManager trackingAuthorizationStatus] == ATTrackingManagerAuthorizationStatusNotDetermined) {
                    // 检测到 iOS 17.4 ATT 错误
                    if (@available(iOS 15.0, *)) {
                        __weak typeof(self) weakSelf = self;
                        __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
                            [[NSNotificationCenter defaultCenter] removeObserver:observer];
                            [weakSelf fixTrackingAuthorizationWithCompletion:completion];
                        }];
                    } else {
                        // 早期版本的处理方式
                        // 可以在这里添加适当的回退处理
                        // 确保 completion 在主线程上执行
                        if (completion) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                completion(status);
                            });
                        }
                    }
                } else {
                    // 未检测到 ATT 错误，直接返回授权状态
                    if (completion) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completion(status);
                        });
                    }
                }
            }];
        }
}

@end
