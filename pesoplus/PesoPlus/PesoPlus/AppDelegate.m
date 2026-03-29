//
//  AppDelegate.m
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import "AppDelegate.h"

#import <AFNetworking/AFNetworking.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [User ppConfigUserAndSetupUserInfo];
    self.tabBarController = [[PPTabBarController alloc] init];
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.tabBarController];
    self.navController.navigationBarHidden = YES;
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    
//    [self getNet];
    return YES;
}

//-(void)getNet {
//    AFNetworkReachabilityManager *netStatus = [AFNetworkReachabilityManager sharedManager];
//    kWeakself;
//    [netStatus setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                [weakSelf getIdfa];
//                break;
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                [weakSelf getIdfa];
//                break;
//            case AFNetworkReachabilityStatusNotReachable:
//                break;
//            case AFNetworkReachabilityStatusUnknown:
//                break;
//            default:
//                break;
//        }
//    }];
//    [netStatus startMonitoring];
//}


//- (void)getIdfa {
//    
//    kWeakself;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if(@available(iOS 14.0, *)){
//            [self tackingAuthed:^(ATTrackingManagerAuthorizationStatus status) {
//                [self deviceIdfa:^(NSString * _Nonnull idfa) {
//                    [weakSelf postIdfa:idfa];
//                }];
//            }];
//            
//        }else{
//            [self deviceIdfa:^(NSString * _Nonnull idfa) {
//                [weakSelf postIdfa:idfa];
//            }];
//        }
//        
//        
//    });
//}
//
//-(void)postIdfa:(NSString*)idfa {
//
//    NSDictionary *dic = @{
//                        @"rscomraderyCiopjko": [PPPhoneInfo idfv],
//                        @"rsdispraiseCiopjko":idfa,
//                        @"asdfasasdgwg": @"fewfdf",
//                        @"ATETH": @"123123555",
//                         };
//    [Http post:@"moscvth" params:dic success:^(Response *response) {
//    } failure:^(NSError *error) {
//    }];
//}
//
//- (void)tackingAuthed:(void (^)(ATTrackingManagerAuthorizationStatus status))completion API_AVAILABLE(ios(14)) {
//    if (@available(iOS 14.0, *)) {
//        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
//            if (status == ATTrackingManagerAuthorizationStatusDenied && [ATTrackingManager trackingAuthorizationStatus] == ATTrackingManagerAuthorizationStatusNotDetermined) {
//                if (@available(iOS 15.0, *)) {
//                    __weak typeof(self) weakSelf = self;
//                    __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//                        [[NSNotificationCenter defaultCenter] removeObserver:observer];
//                        [weakSelf tackingAuthed:completion];
//                    }];
//                } else {
//                    if (completion) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            completion(status);
//                        });
//                    }
//                }
//            } else {
//                if (completion) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        completion(status);
//                    });
//                }
//            }
//        }];
//    }
//}
//
//- (void)deviceIdfa:(void (^)(NSString * _Nonnull))block {
//    __block NSString *idfa = @"";
//    if (@available(iOS 14, *)) {
//        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
//            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
//                idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
//                block(idfa);
//            } else if(status == ATTrackingManagerAuthorizationStatusNotDetermined){
//                
//            } else{
//                block(idfa);
//            }
//        }];
//    } else {
//        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
//            idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
//            block(idfa);
//        } else {
//            block(idfa);
//        }
//    }
//}

@end
