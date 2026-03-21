//
//  AppDelegate.m
//  NewBag
//
//  Created by Jacky on 2024/1/29.
//

#import "AppDelegate.h"
#import "BagTabbarViewController.h"
#import <YTKNetwork/YTKNetworkConfig.h>
#import "BagRequestUrlArgumentsFilter.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "BagRouterManager.h"
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AppsFlyerLib/AppsFlyerLib.h>
#import <YYCache/YYCache.h>
#import <AFNetworking/AFNetworking.h>
#import "BagAppsFlysService.h"
#import "BagRootVCManager.h"
#import "Test111VC.h"
@interface AppDelegate ()
@property (nonatomic, assign) BOOL hasReported;
@property (nonatomic, assign) BOOL alertTracking;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
//    YYCache *cache = [[YYCache alloc] initWithName:cacheName];
//    if ([cache objectForKey:cacheHostURL]) {
//        config.baseUrl = (NSString *)[cache objectForKey:cacheHostURL];//配置请求域名地址
//    }else{
//        config.baseUrl = Host;//配置请求域名地址
//        [cache setObject:Host forKey:cacheHostURL];
//    }
//    config.baseUrl = TestHost;
//    //拼接通用参数到链接
//    BagRequestUrlArgumentsFilter *filter = [BagRequestUrlArgumentsFilter filterWithArguments];
//    [config addUrlFilter:filter];
//   
//    [IQKeyboardManager sharedManager].enable = YES;
//    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"Confirm";
//    //bugly
//     [Bugly startWithAppId:buglyKey];
    //[[BagRootVCManager shareInstance] initNetworkConfig];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = [[Test111VC alloc]init];
//    [[BagRootVCManager shareInstance]setRootVC];
    //强制登录
    //强制登录
    //[self forceLogin];
    
    [self.window makeKeyAndVisible];
    return YES;
}
//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    dispatch_after(DISPATCH_TIME_NOW + 1, dispatch_get_main_queue(), ^{
//        [self startNetWorkMonitor];
//    });
//}

#pragma - 用户强制登录
- (void)forceLogin
{
    if (!BagUserManager.shareInstance.isLogin) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[BagRouterManager shareInstance] jumpLoginWithSuccessBlock:^{
                [BagTrackHandleManager trackUpDataAppUserId:[NSString stringWithFormat:@"%ld",BagUserManager.shareInstance.uid]];
            }];
           
        });
        return;
    }
    [BagTrackHandleManager trackUpDataAppUserId:[NSString stringWithFormat:@"%ld",BagUserManager.shareInstance.uid]];
}

-(void)startNetWorkMonitor {
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    WEAKSELF
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"lw======WIFI");
                [weakSelf checkAD];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"lw======蜂窝数据");
                [weakSelf checkAD];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                //weakSelf.nettype = @"Bad Network";
                NSLog(@"lw======Bad Network");
                break;
            case AFNetworkReachabilityStatusUnknown:
                //weakSelf.nettype = @"Unknow Network";
                NSLog(@"lw======Unknow Network");
                break;
            default:
                //NSLog(@"其他");
                NSLog(@"lw======其他");
                break;
        }
    }];
    //开始监控
    [mgr startMonitoring];
}

- (void)checkAD{
    
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Permission" message:@"Request IDFA Permission, Your data will be used to deliver personalized ads to you " preferredStyle:UIAlertControllerStyleAlert];
    WEAKSELF
    [alert addAction: [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf requestGoogle_market];
    }]];
    if (@available(iOS 14, *)) {
        // iOS14及以上版本需要先请求权限
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            
            if (status == ATTrackingManagerAuthorizationStatusDenied) {//用户拒绝IDFA
                [weakSelf requestGoogle_market];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [alert addAction: [UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                                //
                            }];
                        }
                    }]];
                    [weakSelf.window.rootViewController presentViewController:alert animated:true completion:nil];
                });
                
            } else if(status == ATTrackingManagerAuthorizationStatusAuthorized){//用户允许IDFA
                [weakSelf requestGoogle_market];
            } else if(status == ATTrackingManagerAuthorizationStatusNotDetermined){//用户未做选择或未弹窗IDFA
                
            }else{
                [weakSelf requestGoogle_market];
            }
        }];
    } else {
        // iOS14以下版本依然使用老方法
        // 判断在设置-隐私里用户是否打开了广告跟踪
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            [self requestGoogle_market];
        } else {
            
            [weakSelf requestGoogle_market];
            [alert addAction: [UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                        //
                    }];
                }
                [weakSelf requestGoogle_market];
            }]];
            [self.window.rootViewController presentViewController:alert animated:true completion:nil];
        }
    }
}

- (void)requestGoogle_market {
    if (self.hasReported) {
        return;
    }
    WEAKSELF;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"manifourteencideNc"] = NSObject.getIDFV;
    [NSObject getIdfa:^(NSString *idfa) {
        dic[@"patufourteenrageNc"] = NotNull(idfa);
    }];
    dic[@"asdfasasdgwg"] = @"fewfdf";
    dic[@"ATETH"] = @"123123555";
    BagAppsFlysService *service = [[BagAppsFlysService alloc] initWithData:dic];
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        NSDictionary *data = request.response_dic;
        if (data != nil && data[@"enarfourteengingNc"] != nil && [data[@"enarfourteengingNc"] isKindOfClass:[NSNumber class]]) {
            if ([data[@"enarfourteengingNc"]  integerValue] == 1) {
                weakSelf.hasReported = YES;
                [AppsFlyerLib shared].appsFlyerDevKey = data[@"eqipfourteenonderanceNc"];
                [AppsFlyerLib shared].appleAppID = data[@"afId"];
                [[AppsFlyerLib shared] startWithCompletionHandler:^(NSDictionary<NSString *,id> * _Nullable dictionary, NSError * _Nullable error) {
                    if (error != nil) {
                        NSLog(@"lw=====>AF%@", error);
                    } else {
                        weakSelf.hasReported = YES;
                        NSLog(@"lw=====>AF%@", dictionary);
                    }
                }];
#ifdef DEBUG
                [AppsFlyerLib shared].isDebug = YES;
#else
#endif
            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
@end
