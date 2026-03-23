//
//  PTLanuchManager.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/18.
//

#import "PTLanuchManager.h"
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AFNetworking/AFNetworking.h>
#import "PTLanuchService.h"
#import <AdjustSdk/AdjustSdk.h>
#import "PTUploadAdidService.h"
#import <Bugly/Bugly.h>

@interface PTLanuchManager()

@end

@implementation PTLanuchManager
SINGLETON_M(PTLanuchManager)

- (void)startUpAppSDK
{
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"Confirm";
//    //键盘弹出时，点击背景，键盘收回
//    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [YTKNetworkConfig sharedConfig].baseUrl = PTbaseUrl;
    [Bugly startWithAppId:PTBuglyKey];
}

- (void)startNetWork
{
    WEAKSELF
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"lw======WIFI");
                [weakSelf startCheckIDFA];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"lw======蜂窝数据");
                [weakSelf startCheckIDFA];
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
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    
}

- (void)checkLogin
{
    if(!PTUser.isLogin){
        [PTVCRouter jumpLoginWithSuccessBlock:^{
            
        }];
    }
    
}

- (void)startCheckIDFA
{
    WEAKSELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        STRONGSELF
        if (@available(iOS 14, *)) {
            [PTTools fixTrackingAuthorizationWithCompletion:^(ATTrackingManagerAuthorizationStatus status) {
                [strongSelf updataGoogle_market];
                if(status == ATTrackingManagerAuthorizationStatusDenied){
                    [strongSelf showGCIdfaAlwer];
                }
            }];
        } else {
            [strongSelf updataGoogle_market];
            if(![[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]){
                    [strongSelf showGCIdfaAlwer];
            }
        }
        
    });
}

- (void)showGCIdfaAlwer
{
    if(!PTUser.isLogin)return;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Permission" message:@"Request IDFA Permission, Your data will be used to deliver personalized ads to you " preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction: [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
              
            }]];
            [alert addAction: [UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                }];
            }
            }]];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:true completion:nil];
    });
   
}

- (void)updataGoogle_market
{
    NSDictionary *dic = @{
                           @"asdfasasdgwg":@"fewfdf",
                           @"fewfdf":@"123123555",
                           @"patenturageNc":PTNotNull([PTDeviceInfo idfa]),
                           @"matennicideNc":PTNotNull([PTDeviceInfo idfv]),
                          };
    PTLanuchService *service = [[PTLanuchService alloc] initWithData:dic];
    [service startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        NSDictionary *dataDic = request.response_dic;
        NSLog(@"lw========>service%@",[dataDic yy_modelToJSONString]);
        if(dataDic && dataDic[@"kntenxiuixbNc"]){
            if([dataDic[@"kntenxiuixbNc"] integerValue] == 1 && dataDic[@"sdtenjfjkdsNc"]){
                NSString *adjustToken = [NSString stringWithFormat:@"%@",dataDic[@"sdtenjfjkdsNc"]];
                  #if DEBUG
                  NSString *environment = ADJEnvironmentSandbox;
                  ADJConfig *adjustConfig = [[ADJConfig alloc] initWithAppToken:adjustToken
                                                               environment:environment];
                  [adjustConfig setLogLevel:ADJLogLevelVerbose];

                  #else
                  NSString *environment = ADJEnvironmentProduction;
                  ADJConfig *adjustConfig = [[ADJConfig alloc] initWithAppToken:adjustToken
                                                               environment:environment];
                  [adjustConfig setLogLevel:ADJLogLevelSuppress];
                  #endif
                  
                [Adjust initSdk: adjustConfig];
                WEAKSELF
                [Adjust adidWithCompletionHandler:^(NSString * _Nullable adid) {
                    STRONGSELF
                    [strongSelf upDatatencrAdid:adid];
                }];
            }
            
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
    

    }];
}

- (void)upDatatencrAdid:(NSString*)adid
{
    PTUploadAdidService *service = [[PTUploadAdidService alloc] initWithData:@{
                                                                               @"exteneptionalNc":PTNotNull(PTDeviceInfo.idfv),
                                                                               @"fktengjgkxdkcnNc":PTNotNull(adid)
                                                                               }];
    [service startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        
    } failure:^(__kindof PTBaseRequest * _Nonnull request) {
        
        
    }];
}

@end
