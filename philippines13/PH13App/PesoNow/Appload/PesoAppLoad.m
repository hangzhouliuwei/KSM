//
//  PesoAppLoad.m
//  PesoApp
//
//  Created by Jacky on 2024/9/10.
//

#import "PesoAppLoad.h"
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AFNetworking/AFNetworking.h>
//#import <AdjustSdk/AdjustSdk.h>
#import <Bugly/Bugly.h>
#import "PesoGetGoogleMarketAPI.h"
#import "PesoUploadAdidApi.h"


@implementation PesoAppLoad
singleton_implementation(PesoAppLoad)

- (void)initSDK
{
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"Confirm";
//    //键盘弹出时，点击背景，键盘收回
//    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [YTKNetworkConfig sharedConfig].baseUrl = APiBaseUrl;
//    [Bugly startWithAppId:BuglyAppId];
}

- (void)startNetworkMonitoring
{
    WEAKSELF
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [weakSelf startCheckIDFA];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [weakSelf startCheckIDFA];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                break;
            case AFNetworkReachabilityStatusUnknown:
                break;
            default:
                break;
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
- (void)startCheckIDFA{
    WEAKSELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        STRONGSELF
        if (@available(iOS 14, *)) {
            [PesoUtil fixTrackingAuthorizationWithCompletion:^(ATTrackingManagerAuthorizationStatus status) {
                [strongSelf getAdjustKey];
                if(status == ATTrackingManagerAuthorizationStatusDenied){
                    [strongSelf showAlert];
                }
            }];
        } else {
            [strongSelf getAdjustKey];
            if(![[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]){
                [strongSelf showAlert];
            }
        }
        
    });
}
- (void)getAdjustKey{
    NSDictionary *dic = @{
                           @"asdfasasdgwg":@"fewfdf",
                           @"ATETH":@"123123555",
                           @"patuthirteenrageNc":NotNil([PesoDeviceTool idfa]),
                           @"manithirteencideNc":NotNil([PesoDeviceTool idfv]),
                          };
    PesoGetGoogleMarketAPI *service = [[PesoGetGoogleMarketAPI alloc] initWithData:dic];
    [service startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        NSDictionary *dataDic = request.responseDic;
        NSLog(@"lw========>service%@",[dataDic yy_modelToJSONString]);
        if(dataDic && dataDic[@"enarthirteengingNc"]){
            if([dataDic[@"enarthirteengingNc"] integerValue] == 1 && dataDic[@"eqipthirteenonderanceNc"]){
//                NSString *adjustToken = [NSString stringWithFormat:@"%@",dataDic[@"eqipthirteenonderanceNc"]];
//                  #if DEBUG
//                  NSString *environment = ADJEnvironmentSandbox;
//                  ADJConfig *adjustConfig = [[ADJConfig alloc] initWithAppToken:adjustToken
//                                                               environment:environment];
//                  [adjustConfig setLogLevel:ADJLogLevelVerbose];
//
//                  #else
//                  NSString *environment = ADJEnvironmentProduction;
//                  ADJConfig *adjustConfig = [[ADJConfig alloc] initWithAppToken:adjustToken
//                                                               environment:environment];
//                  [adjustConfig setLogLevel:ADJLogLevelSuppress];
//                  #endif
//                  
//                [Adjust initSdk: adjustConfig];
//                WEAKSELF
//                [Adjust adidWithCompletionHandler:^(NSString * _Nullable adid) {
//                    STRONGSELF
//                    [strongSelf uploadAdid:adid];
//                }];
            }
            
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
    

    }];
}
- (void)showAlert{
//    if(!PesoUserCenter.sharedPesoUserCenter.isLogin)return;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Permission" message:@"Request IDFA Permission, Your data will be used to deliver personalized ads to you " preferredStyle:UIAlertControllerStyleAlert];
//            [alert addAction: [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//              
//            }]];
//            [alert addAction: [UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//               
//            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
//                }];
//            }
//            }]];
//            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:true completion:nil];
//    });
}
- (void)uploadAdid:(NSString*)adid
{
    PesoUploadAdidApi *api = [[PesoUploadAdidApi alloc] initWithData:@{
                                                                               @"exteneptionalNc":NotNil([PesoDeviceTool idfv]),
                                                                               @"fktengjgkxdkcnNc":NotNil(adid)
                                                                               }];
    [api startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        
    } failure:^(__kindof PesoBaseAPI * _Nonnull request) {
        
        
    }];
}
@end
