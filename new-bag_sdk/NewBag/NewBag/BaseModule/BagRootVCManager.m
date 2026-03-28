//
//  BagRootVCManager.m
//  NewBag
//
//  Created by 刘巍 on 2024/7/5.
//

#import "BagRootVCManager.h"
#import <YTKNetwork/YTKNetworkConfig.h>
#import <YYCache/YYCache.h>
#import "BagRequestUrlArgumentsFilter.h"
#import <IQKeyboardManager.h>
#import <AFNetworking/AFNetworking.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>
#import "BagAppsFlysService.h"
#import <AppsFlyerLib/AppsFlyerLib.h>

@interface BagRootVCManager()
@property(nonatomic, assign) BOOL alertTracking;
@end

@implementation BagRootVCManager

+ (instancetype)shareInstance{
    static BagRootVCManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [BagRootVCManager new];
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:NetWorkMonitor object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            [manager checkAD];
        }];
    });
    return manager;
}

-(void)initNetworkConfig
{
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    YYCache *cache = [[YYCache alloc] initWithName:cacheName];
    if ([cache objectForKey:cacheHostURL]) {
        config.baseUrl = (NSString *)[cache objectForKey:cacheHostURL];//配置请求域名地址
    }else{
        config.baseUrl = Host;//配置请求域名地址
        [cache setObject:Host forKey:cacheHostURL];
    }
    config.baseUrl = TestHost;
    //拼接通用参数到链接
    BagRequestUrlArgumentsFilter *filter = [BagRequestUrlArgumentsFilter filterWithArguments];
    [config addUrlFilter:filter];
   
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"Confirm";
    [self startNetWorkMonitor];
    
}

- (void)setRootVC
{
    [self initNetworkConfig];
    [UIApplication sharedApplication].delegate.window.rootViewController = (UIViewController*)[[BagRouterManager shareInstance] rootVC];
}

- (void)checkAD{
    
    WEAKSELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (@available(iOS 14.0, *)) {
            [BagRootVCManager checkTrackingAuthorizationWithCompletion:^(ATTrackingManagerAuthorizationStatus status) {
                STRONGSELF
                if(status == ATTrackingManagerAuthorizationStatusDenied){
                    [weakSelf showGCIdfaAlwer];
                }
                NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
                NSLog(@"lw======>idfa%@",idfa);
                [strongSelf requestGoogle_marketIdfa:idfa];
            }];
            
        }else{
            NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
            if (![[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
                [self showGCIdfaAlwer];
            }
            [self requestGoogle_marketIdfa:idfa];
        }
    });
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


- (void)showGCIdfaAlwer
{
    WEAKSELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Permission" message:@"Request IDFA Permission, Your data will be used to deliver personalized ads to you " preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction: [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                weakSelf.alertTracking = YES;
            }]];
            [alert addAction: [UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                weakSelf.alertTracking = YES;
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                }];
            }
            }]];
        if (@available(iOS 13.0, *)) {
                // 获取当前活动的场景
                for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
                    if (scene.activationState == UISceneActivationStateForegroundActive) {
                        // 获取当前场景的窗口
                        UIWindow *window = scene.windows.firstObject;
                        // 获取窗口的根视图控制器
                        [window.rootViewController presentViewController:alert animated:YES completion:nil];
                        break;
                    }
                }
            } else {
                // 处理 iOS 13 以下版本
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
            }
    });
    
}

- (void)requestGoogle_marketIdfa:(NSString*)idfa
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"errF"] = NSObject.getIDFV;
    dic[@"lintwhiteF"] = NotNull(idfa);
    dic[@"asdfasasdgwg"] = @"fewfdf";
    dic[@"ATETH"] = @"123123555";
    BagAppsFlysService *service = [[BagAppsFlysService alloc] initWithData:dic];
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        NSDictionary *data = request.response_dic;
        if (data != nil && data[@"fuchsineF"] != nil && [data[@"fuchsineF"] isKindOfClass:[NSNumber class]]) {
            if ([data[@"fuchsineF"]  integerValue] == 1) {
                [AppsFlyerLib shared].appsFlyerDevKey = data[@"cylindromatousF"];
                [AppsFlyerLib shared].appleAppID = data[@"afId"];
                [[AppsFlyerLib shared] startWithCompletionHandler:^(NSDictionary<NSString *,id> * _Nullable dictionary, NSError * _Nullable error) {
                    if (error != nil) {
                        NSLog(@"lw=====>AF%@", error);
                    } else {
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

+ (void)checkTrackingAuthorizationWithCompletion:(void (^)(ATTrackingManagerAuthorizationStatus status))completion  API_AVAILABLE(ios(14)){
    if (@available(iOS 14.0, *)) {
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                if (status == ATTrackingManagerAuthorizationStatusDenied && [ATTrackingManager trackingAuthorizationStatus] == ATTrackingManagerAuthorizationStatusNotDetermined) {
                    // 检测到 iOS 17.4 ATT 错误
                    NSLog(@"检测到 iOS 17.4 ATT 错误");
                    if (@available(iOS 15.0, *)) {
                        __weak typeof(self) weakSelf = self;
                        __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
                            NSLog(@"进入=====进入高版本逻辑1");
                            [[NSNotificationCenter defaultCenter] removeObserver:observer];
                            [weakSelf checkTrackingAuthorizationWithCompletion:completion];
                        }];
                    } else {
                        // 早期版本的处理方式
                        // 可以在这里添加适当的回退处理
                        // 确保 completion 在主线程上执行
                        if (completion) {
                            NSLog(@"进入=====进入高版本逻辑2");
                            dispatch_async(dispatch_get_main_queue(), ^{
                                completion(status);
                            });
                        }
                    }
                } else {
                    // 未检测到 ATT 错误，直接返回授权状态
                    if (completion) {
                        NSLog(@"进入=====进入高版本逻辑3");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completion(status);
                        });
                    }
                }
            }];
        }
    
}

@end
