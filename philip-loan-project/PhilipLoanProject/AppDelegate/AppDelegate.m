//
//  AppDelegate.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/23.
//

#import "AppDelegate.h"
#import "PLPBaseNavigationController.h"
#import "IQKeyboardManager.h"
#import <MMKV.h>
#import "PLPBaseTabbarController.h"
#import "PLPLoginRegistViewController.h"
#import "PLPBaseNavigationController.h"
#import <AFNetworking/AFNetworking.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
//#import <AdjustSdk/AdjustSdk.h>
//#import <Bugly/Bugly.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureThird];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [self startNetWork];
//    [Bugly startWithAppId:bugKey];
    //[[AFHTTPSessionManager manager] POST:@"https://baidu.com" parameters:nil headers:nil progress:nil success:nil failure:nil];
    if ([kMMKV getBoolForKey:kIsLoginKey]) {
        PLPBaseTabbarController *vc = [PLPBaseTabbarController new];
        self.window.rootViewController = vc;
        
    }else
    {
        PLPLoginRegistViewController *vc = [PLPLoginRegistViewController new];
        PLPBaseNavigationController *navC = [[PLPBaseNavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = navC;
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        NSURL *webpageURL = userActivity.webpageURL;
        NSString *host = webpageURL.host;
        if ([host isEqualToString:@"www.oragon-lending.com"] && [kMMKV getBoolForKey:kIsLoginKey]) {
            NSDictionary *dic = [PLPCommondTools parameFromURL:webpageURL];
            if(dic){
                [PLPCommondTools tapItemWithProductID:[NSString stringWithFormat:@"%@",dic[@"p"]]];
                UITabBarController *tab = (PLPBaseTabbarController*)self.window.rootViewController;
                tab.selectedIndex = 0;
                [tab.navigationController popToRootViewControllerAnimated: YES];
            }
        }
    }

    return YES;
}


-(void)configureThird
{
    [MJRefreshConfig defaultConfig].languageCode = @"en";
    
    [MMKV initializeMMKV:nil];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundColor:kBlackColor_333333];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setForegroundColor:kWhiteColor];
    [SVProgressHUD setImageViewSize:CGSizeZero];
    [SVProgressHUD setCornerRadius:8];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = true;
}


#pragma mark - UISceneSession lifecycle




#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"PhilipLoanProject"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

-(void)startNetWork
{
    kWeakSelf
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [weakSelf startCheckIDFA];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [weakSelf startCheckIDFA];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                //weakSelf.nettype = @"Bad Network";
                break;
            case AFNetworkReachabilityStatusUnknown:
                //weakSelf.nettype = @"Unknow Network";
                break;
            default:
                //NSLog(@"其他");
                break;
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

-(void)startCheckIDFA
{
    
    kWeakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (@available(iOS 14, *)) {
            [PLPCommondTools phFixTrackingAuthorizationWithCompletion:^(ATTrackingManagerAuthorizationStatus status) {
                [PLPCommondTools fetchIDFASuccess:^(NSString * _Nonnull idfa) {
                    [weakSelf updataGoogleMarketIdfa:idfa];
                    if(status == ATTrackingManagerAuthorizationStatusDenied){
                        [weakSelf showGCIdfaAlwer];
                    }
                }];

            }];
        
        } else {
            [PLPCommondTools fetchIDFASuccess:^(NSString * _Nonnull idfa) {
                [weakSelf updataGoogleMarketIdfa:idfa];
                if(![[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]){
                    [weakSelf showGCIdfaAlwer];
                }
            }];
            
        }
        
    });
}

- (void)showGCIdfaAlwer
{
    //if(!PTUser.isLogin)return;
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

-(void)updataGoogleMarketIdfa:(NSString*)idfa
{
    NSDictionary *dic = @{
                          @"asdfasasdgwg":@"fewf",
                          @"ATETH":@"12312",
                          @"manitwelvecideNc":[PLPCommondTools getDeviceIDFV],
                          @"patutwelverageNc": idfa.length > 0 ? idfa : @"",
                         };
    kWeakSelf
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelvecr/market" paramsInfo:dic successBlk:^(id  _Nonnull responseObject) {
        if(responseObject  && [responseObject isKindOfClass:[NSDictionary class]]){
            NSDictionary *dic = responseObject[@"viustwelveNc"];
            if(dic[@"knxitwelveuixbNc"] 
               && dic[@"sdjftwelvejkdsNc"]
               && [NSString stringWithFormat:@"%@",dic[@"knxitwelveuixbNc"]].intValue == 1){
//                NSString *appToken = [NSString stringWithFormat:@"%@",dic[@"sdjftwelvejkdsNc"]];
//                NSString *environment = ADJEnvironmentProduction;
//                ADJConfig *adjustConfig = [[ADJConfig alloc] initWithAppToken:appToken
//                                                             environment:environment];
//                [adjustConfig setLogLevel:ADJLogLevelSuppress];
//                [Adjust initSdk: adjustConfig];
//                [Adjust adidWithCompletionHandler:^(NSString * _Nullable adid) {
//                    [weakSelf updataReportAdid:adid];
//                }];
            }
        }
        
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
}

-(void)updataReportAdid:(NSString *)adid
{
    
    NSDictionary *dic = @{
                          @"asdfasasdgwg":@"fewfdf",
                          @"ATETH":@"123123555",
                          @"exeptwelvetionalNc":[PLPCommondTools getDeviceIDFV],
                          @"fkgjtwelvegkxdkcnNc": adid.length > 0 ? adid : @"",
                         };
    
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelvecr/aio" paramsInfo:dic successBlk:^(id  _Nonnull responseObject) {
       
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
    
}

@end
