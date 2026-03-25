//
//  AppDelegate.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/14.
//

#import "AppDelegate.h"
#import "PUBEnvironmentManager.h"
#import "PUBBaseViewController.h"
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AppsFlyerLib/AppsFlyerLib.h>
//#import <Bugly/Bugly.h>
#import <AFNetworking/AFNetworking.h>
#import "PUBATTrackingTool.h"
#import "PUBDomainManager.h"
@interface AppDelegate ()
@property (nonatomic, assign) BOOL alertTracking;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [VCManager configureWithWindow:self.window];
    [self.window makeKeyAndVisible];
    [self forceLogin];
    [self startNetWorkMonitor];
    //[Bugly startWithAppId:buglyKey];
    return YES;
}


-(void)startNetWorkMonitor {
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    WEAKSELF
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"lw======WIFI");
                [weakSelf domainReplacement];
                [weakSelf checkAD];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"lw======蜂窝数据");
                [weakSelf domainReplacement];
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

#pragma mark - 域名替换
- (void)domainReplacement
{
    WEAKSELF
    [[PUBDomainManager sharedPUBDomainManager] domainNameCheckResult:^(BOOL value) {
        STRONGSELF
        if(value){
            [strongSelf checkAD];
            [User logoutCallServer];
            [strongSelf forceLogin];
        }
    }];
    
}

#pragma mark - 获取idfa授权
- (void)checkAD
{
    WEAKSELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(@available(iOS 14.0, *)){
            [PUBATTrackingTool requestTrackingAuthorizationWithCompletion:^(ATTrackingManagerAuthorizationStatus status) {
                [NSObject getIdfa:^(NSString *idfa) {
                    STRONGSELF
                    [strongSelf requestGoogle_marketIdfa:idfa];
                    if(ATTrackingManager.trackingAuthorizationStatus == ATTrackingManagerAuthorizationStatusDenied){
                       if(!strongSelf.alertTracking){
                           [strongSelf showATTrackingAlwer];
                       }
                   }
                }];
                
            }];
        }else{
            [NSObject getIdfa:^(NSString *idfa) {
                STRONGSELF
                [strongSelf requestGoogle_marketIdfa:idfa];
                if(![[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]){
                    if(!self.alertTracking){
                        [self showATTrackingAlwer];
                    }
                }
            }];
        }
        
        
    });
    
}

- (void)showATTrackingAlwer
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
            [weakSelf.window.rootViewController presentViewController:alert animated:true completion:nil];
    });
   
}

#pragma - 用户强制登录
- (void)forceLogin
{
    if (!User.isLogin) {
        [PUBTools checkLogin:^(NSInteger uid) {
            [PUBTrackHandleManager trackUpDataAppUserId:[NSString stringWithFormat:@"%ld",User.uid]];
            //[Bugly setUserIdentifier:User.username];
            return;
        }];
        return;
    }
    [PUBTrackHandleManager trackUpDataAppUserId:[NSString stringWithFormat:@"%ld",User.uid]];
    //[Bugly setUserIdentifier:User.username];
}

- (void)requestGoogle_marketIdfa:(NSString*)idfa {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"prevailing_eg"] = NSObject.getIDFV;
    dic[@"routh_eg"] = NotNull(idfa);
    dic[@"asdfasasdgwg"] = @"fewfdf";
    dic[@"ATETH"] = @"123123555";
    NSLog(@"lw======>dic%@",dic);
    [HttPPUBRequest postWithPath:googleMarket params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        if (mode.dataDic != nil && mode.dataDic[@"teknonymy_eg"] != nil && [mode.dataDic[@"teknonymy_eg"] isKindOfClass:[NSNumber class]]) {
            if ([mode.dataDic[@"teknonymy_eg"]  integerValue] == 1) {
                [AppsFlyerLib shared].appsFlyerDevKey = mode.dataDic[@"lumine_eg"];
                [AppsFlyerLib shared].appleAppID = mode.dataDic[@"afId"];
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
        
    } failure:^(NSError * _Nonnull error) {
        
    } showLoading:NO];
}

@end
