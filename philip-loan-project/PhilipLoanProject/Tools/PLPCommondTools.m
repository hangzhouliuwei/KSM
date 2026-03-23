//
//  Tools.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/26.
//

#import "PLPCommondTools.h"
#import <sys/utsname.h>
#import <objc/runtime.h>
#import <AdSupport/AdSupport.h>
#import "SSKeyChain.h"
#import "PLPDeviceInfoManager.h"
#import "AppDelegate.h"
#import "LocationAlertView.h"
#import "PLPWebViewController.h"
#import "UIViewController+Category.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
@implementation PLPCommondTools

+(void)requestCameraAuthority:(void (^)(BOOL))success
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (success) {
                success(granted);
            }
        }];
    } else if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        LocationAlertView *view = [[LocationAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 192)];
        view.infoLabel.text = @"Please provide permission to Creditloan";
        view.okBlk = ^{
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
        };
        [view popAlertViewOnBottom];
    } else {
        success(YES);
    }
}
+(void)requestAlbumAuthority:(void (^)(BOOL))success
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus authorizationStatus) {
            if (authorizationStatus == PHAuthorizationStatusAuthorized) {
                if (success) {
                    success(YES);  // 用户同意了权限
                }
            } else {
                LocationAlertView *view = [[LocationAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 192)];
                view.infoLabel.text = @"Please provide permission to Creditloan";
                view.okBlk = ^{
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                    }
                };
                [view popAlertViewOnBottom];
            }
        }];
    } else if (status == PHAuthorizationStatusAuthorized) {
        if (success) {
            success(YES);
        }
    } else {
        LocationAlertView *view = [[LocationAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 192)];
        view.infoLabel.text = @"Please provide permission to Creditloan";
        view.okBlk = ^{
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
        };
        [view popAlertViewOnBottom];
    }
}
+(void)clearCurrentNavigationStack:(UIViewController *)vc
{
    UINavigationController *navC = vc.navigationController;
    NSMutableArray *array = [NSMutableArray array];
    if (navC.viewControllers.count >= 2) {
        [array addObject:navC.childViewControllers.firstObject];
        for(int i = 1; i < navC.viewControllers.count - 1; i++) {
            PLPBaseViewController *vc = navC.viewControllers[i];
            if ([vc isMemberOfClass:NSClassFromString(@"PLPAuthCertificationController")]) {
                [array addObject:vc];
            }
        }
        [array addObject:navC.childViewControllers.lastObject];
    }
    navC.viewControllers = array;
}

+(void)tapItemWithProductID:(NSString *)productID
{
    if ([productID isReal]) {
        BOOL review = [kMMKV getBoolForKey:kReviewKey];
        if (review) {
            [self requestInfoWithProductId:productID];
        }else
        {
            [[PLPLocationManager sharedManager] requestLocactionInfo:^(BOOL hasPermission, id  _Nonnull info) {
                if (hasPermission) {
                    [self requestInfoWithProductId:productID];
                    [self uploadLocationInfo];
                }else
                {
                    LocationAlertView *view = [[LocationAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 192)];
                    view.okBlk = ^{
                        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        if ([[UIApplication sharedApplication] canOpenURL:url]) {
                            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                        }
                    };
                    [view popAlertViewOnBottom];
                    kHideLoading
                }
            }];
        }
    }
}

+(void)uploadLocationInfo
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"meontwelveymNc"] = [PLPLocationManager sharedManager].province?:@"";
    dic[@"prgetwelvenitureNc"] = [PLPLocationManager sharedManager].countryCode?:@"";
    dic[@"emlutwelvementNc"] = [PLPLocationManager sharedManager].country?:@"";
    dic[@"meadtwelvealtonNc"] = [PLPLocationManager sharedManager].street?:@"";
    dic[@"boomtwelveofoNc"] = [[PLPLocationManager sharedManager] getCurrentLatitude]?:@"";
    dic[@"unevtwelveoutNc"] = [[PLPLocationManager sharedManager] getCurrentLongitude]?:@"";
    dic[@"googtwelveenesisNc"] = [PLPLocationManager sharedManager].city?:@"";
    dic[@"amittwelveiouslyNc"] = [PLPLocationManager sharedManager].area?:@"";
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelvecr/location" paramsInfo:dic successBlk:^(id  _Nonnull responseObject) {
        
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
}


+(void)requestInfoWithProductId:(NSString *)productID
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"liettwelveusNc"] = productID;
    params[@"fuhatwelvemNc"] = @"cakestand";
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelvenv2/gce/apply" paramsInfo:params successBlk:^(id  _Nonnull responseObject) {
        NSDictionary *data = responseObject[@"viustwelveNc"];
        NSInteger flcNtwelvec = [data[@"flcNtwelvec"] integerValue];
        if (flcNtwelvec == 2) {
            [self uploadDeviceInfo];
        }
        NSString *relotwelveomNc = data[@"relotwelveomNc"];
        if ([relotwelveomNc containsString:@"http://"] || [relotwelveomNc containsString:@"https://"]) {
            PLPWebViewController *vc = [[PLPWebViewController alloc] init];
            vc.url = relotwelveomNc;
            [[UIViewController getCurrentViewController].navigationController pushViewController:vc animated:YES];
            kHideLoading
            return;
        }
        BOOL detrtwelveogyrateNc = [data[@"detrtwelveogyrateNc"] boolValue];
//#if DEBUG
//        detrtwelveogyrateNc = true;
//#endif
        if (detrtwelveogyrateNc) {
            // auth detail
            kHideLoading
            Class cls = NSClassFromString(@"PLPAuthCertificationController");
            PLPBaseViewController *vc = [cls new];
            vc.shouldPopHome = true;
            [[UIViewController getCurrentViewController].navigationController pushViewController:vc animated:YES];
            return;
        }
        [self requestNextInfoWithProductId:productID];
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
}
+(void)requestNextInfoWithProductId:(NSString *)productId
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"liettwelveusNc"] = productId;
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelvenv2/gce/detail" paramsInfo:params successBlk:^(id  _Nonnull responseObject) {
        NSDictionary *data = responseObject[@"viustwelveNc"];
        NSString *orderId = [NSString stringWithFormat:@"%@",data[@"leontwelveishNc"][@"coketwelvetNc"]];
        [PLPDataManager manager].orderId = orderId;
        if ([data[@"heistwelvetopNc"] isReal] && [data[@"heistwelvetopNc"][@"excuse"] isReal]) {
            kHideLoading
            [self pushToPage:data[@"heistwelvetopNc"][@"excuse"] productID:productId];
            return;
        }
        [self queryURLWithOrderNo:orderId];
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
}


+(void)pushToPage:(NSString *)pageName productID:(NSString *)productID
{
    if ([[PLPDataManager manager].controllerMap[pageName] isReal]) {
        NSString *clssName = [PLPDataManager manager].controllerMap[pageName];
        Class cls = NSClassFromString(clssName);
        UIViewController *vc = [cls new];
//        NSLog(@"%@",[UIViewController getCurrentViewController]);
        [[UIViewController getCurrentViewController].navigationController pushViewController:vc animated:YES];
    }else
    {
        NSAssert(true, @"insert value into controllerMap");
    }
}

+(void)queryURLWithOrderNo:(NSString *)orderNo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"spsmtwelveogenicNc"] = orderNo;
    params[@"qunqtwelveuevalentNc"] = @"dddd";
    params[@"ditotwelvemeNc"] = @"houijhyus";
    
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelvenv2/gce/push" paramsInfo:params successBlk:^(id  _Nonnull responseObject) {
        kHideLoading
        NSDictionary *data = responseObject[@"viustwelveNc"];
        NSString *url = [NSString stringWithFormat:@"%@",data[@"relotwelveomNc"]];
        PLPWebViewController *vc = [PLPWebViewController new];
        vc.url = url;
        vc.shouldPopHome = true;
        UIViewController *currentC = [UIViewController getCurrentViewController];
        [currentC.navigationController pushViewController:vc animated:YES];
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
}


+(void)uploadContactInfo
{
    
}

+(void)uploadDeviceInfo
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSMutableDictionary *memoryDic = [NSMutableDictionary dictionary];
    memoryDic[@"chystwelvealidesNc"] = [PLPDeviceInfoManager getUseDiskMemory];
    memoryDic[@"ebditwelvecNc"] = [PLPDeviceInfoManager getTotalDiskMemory];
    memoryDic[@"sclitwelvemazelNc"] = [PLPDeviceInfoManager getTotalMemory];
    memoryDic[@"hiactwelvekNc"] = [PLPDeviceInfoManager getUseMemory];
    result[@"zoaitwelvesmNc"] = memoryDic;
    
    NSMutableDictionary *wifiInfo = [NSMutableDictionary dictionary];
    wifiInfo[@"mititwelvemeNc"] = [PLPDeviceInfoManager networkBaseIdentifier];
    wifiInfo[@"frsctwelveatiNc"] = [PLPDeviceInfoManager networkServeIdentifier];
    wifiInfo[@"koobtwelveehNc"] = [PLPDeviceInfoManager networkMac];
    wifiInfo[@"uportwelvenNc"] = [PLPDeviceInfoManager networkName];
    NSMutableDictionary *new = [NSMutableDictionary dictionary];
    new[@"paritwelvecentricNc"] = @[wifiInfo];
    result[@"eatetwelvernizeNc"] = new;
    
    NSMutableDictionary *hardDic = [NSMutableDictionary dictionary];
    hardDic[@"xeottwelveimeNc"] = [PLPDeviceInfoManager hardSystemVersion];
    hardDic[@"prtutwelvebercularNc"] = @"iPhone";
    hardDic[@"bauvtwelverihiNc"] = [PLPDeviceInfoManager hardDeviceStyle];
    hardDic[@"pemetwelveanceNc"] = @([PLPDeviceInfoManager hardResolvingHeight]);
    hardDic[@"sttutwelvesNc"] = @([PLPDeviceInfoManager hardResolvingWidth]);
    hardDic[@"soentwelveoidNc"] = [PLPDeviceInfoManager hardPhysicSize];
    hardDic[@"teratwelveNc"] = @([PLPDeviceInfoManager hardDeviceTimeStamp]);
    result[@"hardware"] = hardDic;
    
    NSMutableDictionary *batteryDic = [NSMutableDictionary dictionary];
    batteryDic[@"delatwelvesseNc"] = @([PLPDeviceInfoManager queryBatteryValue]);
    batteryDic[@"battery_status"] = @([PLPDeviceInfoManager queryBatteryStatus] ? 1 : 0);
    batteryDic[@"akavtwelveitNc"] = @([PLPDeviceInfoManager queryBatteryisIn] ? 1 : 0);
    result[@"battery_status"] = batteryDic;
    
    NSMutableDictionary *timeDic = [NSMutableDictionary dictionary];
    timeDic[@"ovretwelvexertNc"] = [PLPDeviceInfoManager generateTimeZone];
    timeDic[@"pltitwelveniferousNc"] = @([PLPDeviceInfoManager generateUseDelegate] ? 1 : 0);
    timeDic[@"sumetwelvergibleNc"] = @([PLPDeviceInfoManager generateUseVPN] ? 1 : 0);
    timeDic[@"constwelveellorNc"] = [PLPDeviceInfoManager generateOperatorName];
    timeDic[@"manitwelvecideNc"] = [PLPDeviceInfoManager generateIDFV];
    timeDic[@"tuedtwelveoNc"] = [PLPDeviceInfoManager generateLanguage];
    timeDic[@"leeltwelvelingNc"] = [PLPDeviceInfoManager generateNetType];
    timeDic[@"bahltwelveykNc"] = @(1);
    timeDic[@"deodtwelveulateNc"] = [PLPDeviceInfoManager generateIPAddress];
    [PLPCommondTools fetchIDFASuccess:^(NSString * _Nonnull idfa) {
        timeDic[@"patutwelverageNc"] = idfa;
    }];
    result[@"renctwelveounterNc"] = timeDic;
    
    NSMutableDictionary *signalDic = [NSMutableDictionary dictionary];
    signalDic[@"breztwelveinessNc"] = [PLPDeviceInfoManager otherSignalStrength];
    signalDic[@"deistwelveableNc"] = @([PLPDeviceInfoManager otherIsSimulator] ? 1 : 0);
    signalDic[@"sinmtwelveanNc"] = @([PLPDeviceInfoManager otherIsRoot] ? 1 : 0);
    result[@"watytwelveNc"] = signalDic;
    
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelvecr/device" paramsInfo:result successBlk:^(id  _Nonnull responseObject) {
        
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
}












+(void)resetKeyWindowRootViewController:(id)viewConttoller
{
    ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = viewConttoller;
}

+(NSString *)getDeviceIDFV
{
    NSString *idfv = [SSKeychain passwordForService:[[NSBundle mainBundle] bundleIdentifier] account:@"idfv"];
    if (![idfv isReal]) {
        idfv = [[UIDevice currentDevice].identifierForVendor UUIDString];
        [SSKeychain setPassword:idfv forService:[[NSBundle mainBundle] bundleIdentifier] account:@"idfv"];
    }
    return idfv;
}
+(NSString *)getDeviceUUID
{
    NSString *idfv = [SSKeychain passwordForService:[[NSBundle mainBundle] bundleIdentifier] account:@"uuid"];
    if (![idfv isReal]) {
        idfv = [[NSUUID UUID] UUIDString];
        [SSKeychain setPassword:idfv forService:[[NSBundle mainBundle] bundleIdentifier] account:@"uuid"];
    }
    return idfv;
}


+(NSString *)getCurrentTimeStamp
{
    return [NSString stringWithFormat:@"%.f",[[NSDate date] timeIntervalSince1970] * 1000];
}
+(NSString *)generateRandomString
{
    NSUInteger randomLength = arc4random_uniform(7) + 10; // Random length between 10 and 16
    return [self generateRandomStringWithLength:randomLength];
}
+ (NSString *)generateRandomStringWithLength:(NSUInteger)length {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];

    for (NSUInteger i = 0; i < length; i++) {
        u_int32_t index = arc4random_uniform((u_int32_t)[letters length]);
        unichar character = [letters characterAtIndex:index];
        [randomString appendFormat:@"%C", character];
    }

    return randomString;
}
+(NSString *)formatterValue:(NSString *)value
{
    NSString *temp = [NSString stringWithFormat:@"%.2f",[value doubleValue]];
    NSArray *array = [temp componentsSeparatedByString:@"."];
    NSMutableArray *result = [NSMutableArray array];
    NSString *pre = array[0];
    if (pre.length > 3) {
        [result addObject:[pre substringWithRange:NSMakeRange(0, pre.length - 3)]];
        [result addObject:@","];
        [result addObject:[pre substringWithRange:NSMakeRange(pre.length - 3, 3)]];
    }else
    {
        [result addObject:pre];
    }
    if ([array[1] integerValue] != 0) {
        [result addObject:@"."];
        [result addObject:array[1]];
    }
    return [result componentsJoinedByString:@""];
}

+(NSString *)formatterUnitValue:(NSString *)value
{
    NSString *temp = [NSString stringWithFormat:@"%.2f",[value doubleValue]];
    NSArray *array = [temp componentsSeparatedByString:@"."];
    NSMutableArray *result = [NSMutableArray array];
    [result addObject:@"₱"];
    NSString *pre = array[0];
    if (pre.length > 3) {
        [result addObject:[pre substringWithRange:NSMakeRange(0, pre.length - 3)]];
        [result addObject:@","];
        [result addObject:[pre substringWithRange:NSMakeRange(pre.length - 3, 3)]];
    }else
    {
        [result addObject:pre];
    }
    if ([array[1] integerValue] != 0) {
        [result addObject:@"."];
        [result addObject:array[1]];
    }
    return [result componentsJoinedByString:@""];
}

+(NSString *)fetchBuildVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}
+(NSString *)fetchShortVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}
+ (NSString *)getDeviceModelName{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if (!deviceString) return @"iPhone";
    //iPhone
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7"; //国行、日版、港行
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus"; //国行、港行
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7"; //美版、台版
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus"; //美版、台版
    if ([deviceString isEqualToString:@"iPhone10,1"])    return @"iPhone 8"; //国行(A1863)、日行(A1906)
    if ([deviceString isEqualToString:@"iPhone10,2"])    return @"iPhone 8 Plus"; //国行(A1864)、日行(A1898)
    if ([deviceString isEqualToString:@"iPhone10,3"])    return @"iPhone X"; //国行(A1865)、日行(A1902)
    if ([deviceString isEqualToString:@"iPhone10,4"])    return @"iPhone 8"; //美版(Global/A1905)
    if ([deviceString isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus"; //美版(Global/A1897)
    if ([deviceString isEqualToString:@"iPhone10,6"])    return @"iPhone X";//美版(Global/A1901)
    if ([deviceString isEqualToString:@"iPhone11,8"])    return @"iPhone XR";
    if ([deviceString isEqualToString:@"iPhone11,2"])    return @"iPhone XS";
    if ([deviceString isEqualToString:@"iPhone11,6"])    return @"iPhone XS Max";
    if ([deviceString isEqualToString:@"iPhone11,4"])    return @"iPhone XS Max";
    if ([deviceString isEqualToString:@"iPhone12,1"])    return @"iPhone 11";
    if ([deviceString isEqualToString:@"iPhone12,3"])    return @"iPhone 11 Pro";
    if ([deviceString isEqualToString:@"iPhone12,5"])    return @"iPhone 11 Pro Max";
    if ([deviceString isEqualToString:@"iPhone12,8"])    return @"iPhone SE"; //(2nd generation)
    if ([deviceString isEqualToString:@"iPhone13,1"])    return @"iPhone 12 mini";
    if ([deviceString isEqualToString:@"iPhone13,2"])    return @"iPhone 12";
    if ([deviceString isEqualToString:@"iPhone13,3"])    return @"iPhone 12 Pro";
    if ([deviceString isEqualToString:@"iPhone13,4"])    return @"iPhone 12 Pro Max";
    if ([deviceString isEqualToString:@"iPhone14,2"])    return @"iPhone 13 Pro";
    if ([deviceString isEqualToString:@"iPhone14,3"])    return @"iPhone 13 Pro Max";
    if ([deviceString isEqualToString:@"iPhone14,4"])    return @"iPhone 13 mini";
    if ([deviceString isEqualToString:@"iPhone14,5"])    return @"iPhone 13";
    if ([deviceString isEqualToString:@"iPhone14,6"])    return @"iPhone SE"; //(2nd generation)
    if ([deviceString isEqualToString:@"iPhone14,7"])    return @"iPhone 14";
    if ([deviceString isEqualToString:@"iPhone14,8"])    return @"iPhone 14 Plus";
    if ([deviceString isEqualToString:@"iPhone15,2"])    return @"iPhone 14 Pro";
    if ([deviceString isEqualToString:@"iPhone15,3"])    return @"iPhone 14 Pro Max";
    
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceString isEqualToString:@"iPad6,11"])     return @"iPad 5th";
    if ([deviceString isEqualToString:@"iPad6,12"])     return @"iPad 5th";
    
    if ([deviceString isEqualToString:@"iPad7,1"])      return @"iPad Pro 12.9 2nd";
    if ([deviceString isEqualToString:@"iPad7,2"])      return @"iPad Pro 12.9 2nd";
    if ([deviceString isEqualToString:@"iPad7,3"])      return @"iPad Pro 10.5";
    if ([deviceString isEqualToString:@"iPad7,4"])      return @"iPad Pro 10.5";
    
    if ([deviceString isEqualToString:@"iPad7,5"])      return @"iPad 6th";
    if ([deviceString isEqualToString:@"iPad7,6"])      return @"iPad 6th";
    
    if ([deviceString isEqualToString:@"iPad8,1"])      return @"iPad Pro 11";
    if ([deviceString isEqualToString:@"iPad8,2"])      return @"iPad Pro 11";
    if ([deviceString isEqualToString:@"iPad8,3"])      return @"iPad Pro 11";
    if ([deviceString isEqualToString:@"iPad8,4"])      return @"iPad Pro 11";
    
    if ([deviceString isEqualToString:@"iPad8,5"])      return @"iPad Pro 12.9 3rd";
    if ([deviceString isEqualToString:@"iPad8,6"])      return @"iPad Pro 12.9 3rd";
    if ([deviceString isEqualToString:@"iPad8,7"])      return @"iPad Pro 12.9 3rd";
    if ([deviceString isEqualToString:@"iPad8,8"])      return @"iPad Pro 12.9 3rd";
    
    if ([deviceString isEqualToString:@"iPad11,1"])      return @"iPad mini 5th";
    if ([deviceString isEqualToString:@"iPad11,2"])      return @"iPad mini 5th";
    if ([deviceString isEqualToString:@"iPad11,3"])      return @"iPad Air 3rd";
    if ([deviceString isEqualToString:@"iPad11,4"])      return @"iPad Air 3rd";
    
    if ([deviceString isEqualToString:@"iPad11,6"])      return @"iPad 8th";
    if ([deviceString isEqualToString:@"iPad11,7"])      return @"iPad 8th";
    
    if ([deviceString isEqualToString:@"iPad12,1"])      return @"iPad 9th";
    if ([deviceString isEqualToString:@"iPad12,2"])      return @"iPad 9th";
    
    if ([deviceString isEqualToString:@"iPad14,1"])      return @"iPad mini 6th";
    if ([deviceString isEqualToString:@"iPad14,2"])      return @"iPad mini 6th";

    //iPod
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceString isEqualToString:@"iPod7,1"])      return @"iPod Touch (6 Gen)";
    if ([deviceString isEqualToString:@"iPod9,1"])      return @"iPod Touch (7 Gen)";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}
+(void)fetchIDFASuccess:(void (^)(NSString * _Nonnull))success
{
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                success([[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString]);
            } else if(status == ATTrackingManagerAuthorizationStatusNotDetermined){
                
            } else{
                success(@"");
            }
        }];
    } else {
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            success([[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString]);
        } else {
            success(@"");
        }
    }
}

+ (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}


/// 修复首次获取idfa错误
+ (void)phFixTrackingAuthorizationWithCompletion:(void (^)(ATTrackingManagerAuthorizationStatus status))completion API_AVAILABLE(ios(14))
{
    
    if (@available(iOS 14.0, *)) {
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                if (status == ATTrackingManagerAuthorizationStatusDenied && [ATTrackingManager trackingAuthorizationStatus] == ATTrackingManagerAuthorizationStatusNotDetermined) {
                    // 检测到 iOS 17.4 ATT 错误
                    NSLog(@"检测到 iOS 17.4 ATT 错误");
                    if (@available(iOS 15.0, *)) {
                        __weak typeof(self) weakSelf = self;
                        __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
                            [[NSNotificationCenter defaultCenter] removeObserver:observer];
                            [weakSelf phFixTrackingAuthorizationWithCompletion:completion];
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


+(NSDictionary*)parameFromURL:(NSURL *)url
{
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    NSArray<NSURLQueryItem *> *queryItems = urlComponents.queryItems;

    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    for (NSURLQueryItem *queryItem in queryItems) {
        [params setObject:queryItem.value forKey:queryItem.name];
    }
    
    return params;
}

+ (NSString *)urlZhEncode:(NSString *)urlStr 
{
    if (urlStr.length == 0) {
        return @"";
    }
    NSString *encodedString = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return encodedString;
}

@end
